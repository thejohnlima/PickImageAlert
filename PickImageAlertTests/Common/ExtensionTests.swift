//
//  ExtensionTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 12/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

@testable import PickImageAlert
import XCTest

class ExtensionTests: XCTestCase {

  // MARK: - Tests
  func testCreateIdentifierWithSuccess() {
    let objectIdentifier = PIAlertController.identifier
    let selfIdentifier = self.identifier
    XCTAssertEqual(objectIdentifier, "PIAlertController")
    XCTAssertEqual(selfIdentifier, "ExtensionTests")
  }
}
