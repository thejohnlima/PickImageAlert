//  MIT License
//
//  Copyright (c) 2018 John Lima
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Photos
import UIKit

/// PickImageAlert fetch images from your library and show them in UIAlertController.
/// Also adds one alert action to open camera and another one to open photos library.
/// The selected image is returned in UIImage type.
///
/// Follow the steps bellow to setup the alert in your view controller.
///
/// *Step 1:* Create an optional property
/// ```
/// var pickImageAlert: PickImageAlert?
/// ```
/// *Step 2:* Initialize the alert in your viewDidLoad method
/// ```
/// override func viewDidLoad() {
///   super.viewDidLoad()
///   let properties = PIAlertProperties(
///     title: "Choose Image",
///     cameraActionTitle: "Camera",
///     gallaryActionTitle: "Gallary",
///     cancelActionTitle: "Cancelar"
///   )
///   pickImageAlert = PickImageAlert(with: self, alertProperties: properties)
/// }
/// ```
/// *Step 3:* In your action, call the `pickImage` method to present the alert with images.
/// ```
/// @IBAction private func choosePhoto(sender: Any?) {
///   pickImageAlert?.pickImage { image in
///     print("image: \(String(describing: image))")
///   }
/// }
/// ```
/// That's it 🍺
open class PickImageAlert: NSObject {

  // MARK: - Custom Types
  public typealias SuccessBlock<T> = (_ result: T?) -> Void
  public typealias EmptyBlock = () -> Void

  // MARK: - Constants
  private let alertViewHeight: CGFloat = 360

  // MARK: - Properties
  var pickerController = UIImagePickerController()
  var pickImageSuccess: SuccessBlock<UIImage>?
  var alertController: PIAlertController?
  var photos: [PIPhoto] = []

  weak var targetController: UIViewController?

  lazy var photosView: PICollectionImages? = {
    let view: PICollectionImages = UIView.fromNib()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
  }()

  /// The limit of images that will appear in the collection.
  /// The default value is 30
  public var limitImages: Int = 30

  /// The limit size of the returned image
  /// The default value is 320x320
  public var imageSize = CGSize(width: 320, height: 320)

  // MARK: - Initializers
  /// Initialize with a target and the alert's properties
  ///
  /// - Parameters:
  ///   - target: Pass here your view controller
  ///   - alertProperties: Pass here some properties for your alert
  public init(with target: UIViewController, alertProperties: PIAlertProperties) {
    super.init()

    targetController = target

    alertController = PIAlertController(title: alertProperties.title,
                                        message: nil,
                                        preferredStyle: alertProperties.style)

    pickerController.delegate = self

    let cameraAction = UIAlertAction(title: alertProperties.cameraActionTitle, style: .default) { _ in
      self.openCamera()
    }

    let gallaryAction = UIAlertAction(title: alertProperties.gallaryActionTitle, style: .default) { _ in
      self.openGallery()
    }

    let cancelAction = UIAlertAction(title: alertProperties.cancelActionTitle, style: .cancel)

    cameraAction.setValue(alertProperties.cameraActionImage, forKey: "image")
    gallaryAction.setValue(alertProperties.gallaryActionImage, forKey: "image")

    alertController?.addAction(cameraAction)
    alertController?.addAction(gallaryAction)
    alertController?.addAction(cancelAction)

    alertController?.popoverPresentationController?.sourceView = target.view
    alertController?.view.tintColor = alertProperties.textColor

    alertController?.willChangeOrientation = {
      self.photosView?.collectionViewSizeChanged = true
    }

    alertController?.willLayoutSubviews = {
      if self.photosView?.collectionViewSizeChanged == true {
        self.photosView?.collectionView.collectionViewLayout.invalidateLayout()
      }
    }

    alertController?.didLayoutSubviews = {
      if self.photosView?.collectionViewSizeChanged == true {
        self.photosView?.collectionViewSizeChanged = false
        self.photosView?.collectionView.performBatchUpdates(nil)
      }
    }
  }

  // MARK: - Public Methods
  /// Call this method to present the alert with images
  ///
  /// - Parameter success: Selected image
  public func pickImage(success: @escaping SuccessBlock<UIImage>) {
    pickImageSuccess = success

    fetchPhotos(success: { [weak self] photos in
      if let photos = photos, !photos.isEmpty {
        self?.setupAlertCollection(photos)
      }
      self?.presentAlert()
    }, empty: { [weak self] in
      self?.presentAlert()
    })
  }

  // MARK: - Internal Methods
  static func requestImage(_ asset: PHAsset,
                           size: CGSize,
                           contentMode: PHImageContentMode = .aspectFit,
                           deliveryMode: PHImageRequestOptionsDeliveryMode = .opportunistic,
                           completion: @escaping SuccessBlock<UIImage>) {
    let options = PHImageRequestOptions()
    options.deliveryMode = deliveryMode
    options.isSynchronous = true

    let manager = PHCachingImageManager()

    manager.requestImage(for: asset, targetSize: size, contentMode: contentMode, options: options) { photo, _ in
      completion(photo)
    }
  }

  // MARK: - Private Methods
  private func setupAlertCollection(_ images: [PIPhoto]) {
    photos = images
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self, let photosView = self.photosView else { return }
      let index: Int = self.alertController?.view.subviews.count ?? 1 - 1
      self.alertController?.view.insertSubview(photosView, at: index)
      self.setupPhotosView()
      self.setupAlertViewConstraints()
    }
  }

  private func setupAlertViewConstraints() {
    guard let view = alertController?.view else { return }

    alertController?.view.translatesAutoresizingMaskIntoConstraints = false

    let constraintHeightIdentifier: String = alertController?.identifier ?? "" + "height"

    let constraintHeight = NSLayoutConstraint(item: view,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1.0,
                                              constant: alertViewHeight)
    constraintHeight.priority = .defaultHigh
    constraintHeight.isActive = true
    constraintHeight.identifier = constraintHeightIdentifier

    var constraintToRemove: NSLayoutConstraint {
      let constraint = alertController?.view.constraints.first { $0.identifier == constraintHeightIdentifier }
      return constraint ?? constraintHeight
    }

    alertController?.view.removeConstraint(constraintToRemove)
    alertController?.view.addConstraint(constraintHeight)
  }

  private func getAlertActionViewHeight() -> CGFloat {
    return alertController?.preferredStyle == .alert ? 44 : 57
  }

  private func setupPhotosView() {
    guard let alert = alertController else { return }

    photosView?.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 45).isActive = true
    photosView?.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: -10).isActive = true
    photosView?.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 10).isActive = true

    let constraintBottomValue = (CGFloat(alert.actions.count) * getAlertActionViewHeight()) + 16

    photosView?.bottomAnchor
      .constraint(equalTo: alert.view.bottomAnchor, constant: -constraintBottomValue).isActive = true

    photosView?.viewModel.photos = photos
    photosView?.delegate = self
    photosView?.collectionView.reloadData()
  }

  private func presentAlert() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self, let alert = self.alertController else { return }
      self.targetController?.present(alert, animated: true, completion: nil)
    }
  }

  private func openCamera() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      self.alertController?.dismiss(animated: true)
      if UIImagePickerController .isSourceTypeAvailable(.camera) {
        self.pickerController.sourceType = .camera
        self.targetController?.present(self.pickerController, animated: true, completion: nil)
      } else {
        let alert = UIAlertController(
          title: Localizable.errorTitle,
          message: Localizable.errorNoCamera,
          preferredStyle: .alert
        )
        let action = UIAlertAction(title: Localizable.titleCancel, style: .destructive)
        alert.addAction(action)
        self.targetController?.present(alert, animated: true, completion: nil)
      }
    }
  }

  private func openGallery() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      self.alertController?.dismiss(animated: true)
      self.pickerController.sourceType = .photoLibrary
      self.targetController?.present(self.pickerController, animated: true, completion: nil)
    }
  }

  private func fetchPhotos(success: @escaping SuccessBlock<[PIPhoto]>, empty: EmptyBlock? = nil) {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      switch status {
      case .authorized:
        self?.fetchPhotosAfterAuthorizedStatus(success: success)
      default:
        empty?()
      }
    }
  }

  private func fetchPhotosAfterAuthorizedStatus(success: @escaping SuccessBlock<[PIPhoto]>) {
    var result: [PIPhoto] = []

    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = self.limitImages
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

    let photoAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

    photoAssets.enumerateObjects { asset, _, _ in
      let photoSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
      let photo = PIPhoto(large: photoSize, small: self.imageSize, asset: asset)
      result.append(photo)
    }

    success(result)
  }
}

// MARK: - UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension PickImageAlert: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }

  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    picker.dismiss(animated: true) { [weak self] in
      self?.pickImageSuccess?(image)
    }
  }
}

// MARK: - PICollectionImagesDelegate
extension PickImageAlert: PICollectionImagesDelegate {
  func didSelect(image: UIImage) {
    alertController?.dismiss(animated: true) { [weak self] in
      self?.pickImageSuccess?(image)
    }
  }
}
