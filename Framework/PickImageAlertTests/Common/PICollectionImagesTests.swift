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
@testable import PickImageAlert
import XCTest

class PICollectionImagesTests: XCTestCase {

  // MARK: - Properties
  private var collectionImages: PICollectionImages?
  
  // MARK: - Overrides
  override func setUp() {
    super.setUp()
    collectionImages = UIView.fromNib()

    collectionImages?.viewModel.photos = [
      PIPhoto(
        large: CGSize(width: 320, height: 520),
        small: CGSize(width: 320, height: 320),
        asset: PHAsset()
      )
    ]
  }

  override func tearDown() {
    collectionImages = nil
    super.tearDown()
  }

  // MARK: - Tests
  func testInitWithSuccess() {
    XCTAssertNotNil(collectionImages)
    XCTAssertNotNil(collectionImages?.collectionView)
    XCTAssertEqual(collectionImages?.viewModel.photos.count, 1)
  }

  func testNumberOfItemsInCollectionView() {
    guard let collectionView = collectionImages?.collectionView else {
      XCTFail("⚠️ collection view should not be nil")
      return
    }
    let numberOfItems = collectionImages?.collectionView(collectionView, numberOfItemsInSection: 0)
    XCTAssertEqual(numberOfItems, 1)
  }

  func testCellItemInCollectionView() {
    guard let collectionView = collectionImages?.collectionView else {
      XCTFail("⚠️ collection view should not be nil")
      return
    }
    let indexaPath = IndexPath(item: 0, section: 0)
    let cell = collectionImages?.collectionView(collectionView, cellForItemAt: indexaPath) as? PICollectionImageCell
    XCTAssertNotNil(cell)
    XCTAssertNotNil(cell?.photo)
    XCTAssertNotNil(cell?.photoImageView)
    XCTAssertEqual(cell?.photoImageView.layer.cornerRadius, 3)
  }
}
