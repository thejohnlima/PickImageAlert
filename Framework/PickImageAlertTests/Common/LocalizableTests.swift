//
//  LocalizableTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

@testable import PickImageAlert
import XCTest

class LocalizableTests: XCTestCase {

  // MARK: - Properties
  private var message: String?

  // MARK: - Overrides
  override func setUp() {
    super.setUp()
    message = Localizable.titleCancel
  }

  override func tearDown() {
    message = nil
    super.tearDown()
  }

  // MARK: - Tests
  func testLocalizedString() {
    XCTAssertEqual(message, "Cancel")
  }
}
