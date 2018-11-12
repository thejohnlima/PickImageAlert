//
//  PickImageAlert.swift
//  PickImageAlert
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

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
///   let properties = PIAlertController.AlertProperties(
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

  private var photoCellSize: CGSize {
    let deviceSize = UIScreen.main.bounds.size
    let isLandscape: Bool = deviceSize.width > deviceSize.height
    let percentWidth: CGFloat = isLandscape ? 0.2 : 0.38
    let width: CGFloat = deviceSize.width * percentWidth
    let height: CGFloat = isLandscape ? 108 : 120
    return CGSize(width: width, height: height)
  }

  // MARK: - Properties
  internal let photosView: PICollectionImages = UIView.fromNib()
  internal var pickerController = UIImagePickerController()
  internal var pickImageSuccess: SuccessBlock<UIImage>?
  internal var alertController: PIAlertController?
  internal var fetchedImages: [UIImage] = []
  internal weak var targetController: UIViewController?

  /// The limit of images that will appear in the collection.
  /// The default value is 120
  public var limitImages: Int = 120

  /// The limit size of the returned image
  /// The default value is 320x320
  public var imageSize = CGSize(width: 320, height: 320)

  // MARK: - Initializers
  /// Initialize with a target and the alert's properties
  ///
  /// - Parameters:
  ///   - target: Pass here your view controller
  ///   - alertProperties: Pass here some properties for your alert
  public init(with target: UIViewController, alertProperties: PIAlertController.AlertProperties) {
    super.init()

    targetController = target

    alertController = PIAlertController(title: alertProperties.title,
                                        message: alertProperties.message,
                                        preferredStyle: alertProperties.style)

    pickerController.delegate = self

    let cameraAction = UIAlertAction(title: alertProperties.cameraActionTitle, style: .default) { _ in
      self.openCamera()
    }

    let gallaryAction = UIAlertAction(title: alertProperties.gallaryActionTitle, style: .default) { _ in
      self.openGallery()
    }

    let cancelAction = UIAlertAction(title: alertProperties.cancelActionTitle, style: .cancel)

    alertController?.addAction(cameraAction)
    alertController?.addAction(gallaryAction)
    alertController?.addAction(cancelAction)

    alertController?.popoverPresentationController?.sourceView = target.view

    alertController?.didAppear = { _ in
      self.addObservers()
    }

    alertController?.didDisappear = { _ in
      self.removeObservers()
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

  // MARK: - Private Methods
  private func setupAlertCollection(_ images: [UIImage]) {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }

      strongSelf.photosView.removeFromSuperview()
      strongSelf.alertController?.view.addSubview(strongSelf.photosView)

      strongSelf.fetchedImages = images
      strongSelf.setupPhotosView()

      strongSelf.alertController?.view.translatesAutoresizingMaskIntoConstraints = false

      strongSelf.setupAlertViewConstraintHeight()
    }
  }

  private func setupAlertViewConstraintHeight() {
    var alertViewConstraintHeight: NSLayoutConstraint? {
      guard let view = alertController?.view else { return nil }
      let constraint = NSLayoutConstraint(item: view,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1.0,
                                          constant: alertViewHeight)
      constraint.isActive = true
      constraint.priority = .defaultHigh
      return constraint
    }

    guard let constraintHeight = alertViewConstraintHeight else { return }
    alertController?.view.removeConstraint(constraintHeight)
    alertController?.view.addConstraint(constraintHeight)
  }

  private func setupPhotosView() {
    guard let alert = alertController else { return }

    photosView.translatesAutoresizingMaskIntoConstraints = false
    photosView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 45).isActive = true
    photosView.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: -10).isActive = true
    photosView.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 10).isActive = true

    let constraintHeight = NSLayoutConstraint(item: photosView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1.0,
                                              constant: photoCellSize.height)
    constraintHeight.priority = .defaultLow
    constraintHeight.isActive = true

    photosView.removeConstraint(constraintHeight)
    photosView.addConstraint(constraintHeight)

    photosView.backgroundColor = .clear
    photosView.viewModel.images = fetchedImages
    photosView.delegate = self
    photosView.cellSize = photoCellSize
    photosView.collectionView.reloadData()
  }

  private func presentAlert() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self, let alert = self.alertController else { return }
      self.targetController?.present(alert, animated: true, completion: nil)
    }
  }

  private func openCamera() {
    alertController?.dismiss(animated: true)
    if UIImagePickerController .isSourceTypeAvailable(.camera) {
      pickerController.sourceType = .camera
      targetController?.present(pickerController, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(
        title: Localizable.errorTitle,
        message: Localizable.errorNoCamera,
        preferredStyle: .alert
      )
      let action = UIAlertAction(title: Localizable.titleCancel, style: .destructive)
      alert.addAction(action)
      targetController?.present(alert, animated: true, completion: nil)
    }
  }

  private func openGallery() {
    alertController?.dismiss(animated: true)
    pickerController.sourceType = .photoLibrary
    targetController?.present(pickerController, animated: true, completion: nil)
  }

  private func fetchPhotos(success: @escaping SuccessBlock<[UIImage]>, empty: EmptyBlock? = nil) {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      guard let `self` = self else {
        empty?()
        return
      }
      switch status {
      case .authorized:
        self.fetchPhotosAfterAuthorizedStatus(success: success)
      default:
        empty?()
      }
    }
  }

  private func fetchPhotosAfterAuthorizedStatus(success: @escaping SuccessBlock<[UIImage]>) {
    var result: [UIImage] = []

    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = self.limitImages
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

    let photoAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

    photoAssets.enumerateObjects { asset, _, _ in
      let options = PHImageRequestOptions()
      options.deliveryMode = .fastFormat
      options.isSynchronous = true

      var photoSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)

      if photoSize.width > self.imageSize.width {
        photoSize = self.imageSize
      }

      // swiftlint:disable closure_end_indentation
      // swiftlint:disable trailing_closure
      PHCachingImageManager().requestImage(
        for: asset,
        targetSize: photoSize,
        contentMode: .aspectFit,
        options: options,
        resultHandler: { photo, _ in
          if let photo = photo {
            result.append(photo)
          }
      })
    }

    success(result)
  }

  private func addObservers() {
    UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(deviceOrientationChanged),
                                           name: UIDevice.orientationDidChangeNotification,
                                           object: nil)
  }

  private func removeObservers() {
    UIDevice.current.endGeneratingDeviceOrientationNotifications()
    NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
  }

  @objc
  private func deviceOrientationChanged() {
    setupPhotosView()
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
