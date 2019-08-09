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

import UIKit

protocol PICollectionImagesDelegate: AnyObject {
  
  /// This function is responsible to get selected image
  ///
  /// - Parameter image: Selected image
  func didSelect(image: UIImage)
}

class PICollectionImages: UIView {
  
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
    collectionView.registerNib(PICollectionImageCell.self)

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
    return viewModel.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PICollectionImageCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.photo = viewModel.photos[indexPath.item]
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
    let photo = viewModel.photos[indexPath.item]
    PickImageAlert.requestImage(photo.asset, size: photo.large) { image in
      guard let image = image else { return }
      self.delegate?.didSelect(image: image)
    }
  }
}
