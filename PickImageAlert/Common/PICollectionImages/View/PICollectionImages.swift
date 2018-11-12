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
  var cellSize: CGSize = .zero
  var cellInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
  
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
    return cellSize
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return cellInsets
  }
}

// MARK: - UICollectionViewDelegate
extension PICollectionImages: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let image = viewModel.images[indexPath.item] as? UIImage else { return }
    delegate?.didSelect(image: image)
  }
}
