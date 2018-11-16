//
//  PICollectionImagesTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

@testable import PickImageAlert
import XCTest

class PICollectionImagesTests: XCTestCase {

  // MARK: - Properties
  private var collectionImages: PICollectionImages?
  
  // MARK: - Overrides
  override func setUp() {
    super.setUp()
    collectionImages = UIView.fromNib()
    collectionImages?.viewModel.images = [UIImage()]
  }

  override func tearDown() {
    collectionImages = nil
    super.tearDown()
  }

  // MARK: - Tests
  func testInitWithSuccess() {
    XCTAssertNotNil(collectionImages)
    XCTAssertNotNil(collectionImages?.collectionView)
    XCTAssertEqual(collectionImages?.viewModel.images.count, 1)
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
    XCTAssertNotNil(cell?.image)
    XCTAssertNotNil(cell?.photoImageView)
    XCTAssertEqual(cell?.photoImageView.layer.cornerRadius, 3)
  }
}
