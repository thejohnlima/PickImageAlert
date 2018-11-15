//
//  PickImageAlertTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 12/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

@testable import PickImageAlert
import XCTest

class PickImageAlertTests: XCTestCase {

  // MARK: - Properties
  private var pickImageAlert: PickImageAlert?

  // MARK: - Overrides
  override func setUp() {
    super.setUp()

    let controller = MockViewController()

    let properties = PIAlertController.AlertProperties(
      title: "Choose Image",
      cameraActionTitle: "Camera",
      gallaryActionTitle: "Gallary",
      cancelActionTitle: "Cancelar"
    )

    pickImageAlert = PickImageAlert(with: controller, alertProperties: properties)
  }

  override func tearDown() {
    pickImageAlert = nil
    super.tearDown()
  }

  // MARK: - Tests
  func testInitWithSuccess() {
    XCTAssertNotNil(pickImageAlert)
    XCTAssertNotNil(pickImageAlert?.alertController)
    XCTAssertNotNil(pickImageAlert?.pickerController.delegate)
    XCTAssertTrue(pickImageAlert?.pickerController.delegate is PickImageAlert)
    XCTAssertEqual(pickImageAlert?.limitImages, 120)
    XCTAssertEqual(pickImageAlert?.imageSize, CGSize(width: 320, height: 320))
  }

  func testSetupAlertControllerWithSuccess() {
    XCTAssertEqual(pickImageAlert?.alertController?.actions.count, 3)
    XCTAssertEqual(pickImageAlert?.alertController?.actions[0].title, "Camera")
    XCTAssertEqual(pickImageAlert?.alertController?.actions[1].title, "Gallary")
    XCTAssertEqual(pickImageAlert?.alertController?.actions[2].title, "Cancelar")
  }
}