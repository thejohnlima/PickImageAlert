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
  var sectionMagin: (line: CGFloat, betweenItems: CGFloat) = (8, 8)
  var sectionInset: UIEdgeInsets = .zero
  var collectionViewSizeChanged: Bool = false
  
  weak var delegate: PICollectionImagesDelegate?
  
  // MARK: - Overrides
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }

  // MARK: - Private Methods
  private func setupCollectionView() {
    collectionView.register(PICollectionImageCell.self)

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = sectionMagin.betweenItems
    flowLayout.minimumLineSpacing = sectionMagin.line
    flowLayout.sectionInset = sectionInset
    flowLayout.scrollDirection = .horizontal

    collectionView.collectionViewLayout = flowLayout
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
    let height = collectionView.frame.height - (sectionInset.top + sectionInset.bottom)
    let size = CGSize(width: collectionView.frame.width / 2.2, height: height)
    return size
  }
}

// MARK: - UICollectionViewDelegate
extension PICollectionImages: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let image = viewModel.images[indexPath.item] as? UIImage else { return }
    delegate?.didSelect(image: image)
  }
}
