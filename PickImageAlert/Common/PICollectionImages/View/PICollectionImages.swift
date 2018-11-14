//
//  PICollectionImages.swift
//  LookME
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

import UIKit

internal protocol PICollectionImagesDelegate: AnyObject {
  
  /// This function is responsible to get selected image
  ///
  /// - Parameter image: Selected image
  func didSelect(image: UIImage)
}

internal class PICollectionImages: UIView {
  
  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  
  let viewModel = PICollectionImagesViewModel()
  var sectionSpace: (line: CGFloat, between: CGFloat) = (8, 8)
  var sectionInset: UIEdgeInsets = .zero
  
  weak var delegate: PICollectionImagesDelegate?
  
  // MARK: - Overrides
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  // MARK: - Private Methods
  private func configureUI() {
    collectionView.register(PICollectionImageCell.self)
  }
}

// MARK: - UICollectionViewDataSource
extension PICollectionImages: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PICollectionImageCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.image = viewModel.images[indexPath.item] as? UIImage
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PICollectionImages: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let subtractValue: CGFloat = sectionInset.top + sectionInset.bottom
    let height: CGFloat = collectionView.frame.height - subtractValue
    let size = CGSize(width: collectionView.frame.width / 2.2, height: height)
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInset
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return sectionSpace.between
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionSpace.line
  }
}

// MARK: - UICollectionViewDelegate
extension PICollectionImages: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let image = viewModel.images[indexPath.item] as? UIImage else { return }
    delegate?.didSelect(image: image)
  }
}
