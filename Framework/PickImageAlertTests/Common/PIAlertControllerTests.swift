//
//  PIAlertControllerTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

@testable import PickImageAlert
import XCTest

class PIAlertControllerTests: XCTestCase {

  // MARK: - Properties
  private var alertController: PIAlertController?
  private var alertProperties: PIAlertController.AlertProperties?

  // MARK: - Overrides
  override func setUp() {
    super.setUp()

    alertProperties = PIAlertController.AlertProperties(
      title: "Choose Photo",
      cameraActionTitle: "Camera",
      gallaryActionTitle: "Gallary",
      cancelActionTitle: "Cancel",
      style: .actionSheet
    )

    alertController = PIAlertController(
      title: alertProperties?.title,
      message: nil,
      preferredStyle: alertProperties?.style ?? .alert
    )
  }

  override func tearDown() {
    alertController = nil
    alertProperties = nil
    super.tearDown()
  }

  // MARK: - Tests
  func testSetupAlertPropertiesSuccess() {
    XCTAssertEqual(alertProperties?.title, "Choose Photo")
    XCTAssertEqual(alertProperties?.cameraActionTitle, "Camera")
    XCTAssertEqual(alertProperties?.gallaryActionTitle, "Gallary")
    XCTAssertEqual(alertProperties?.cancelActionTitle, "Cancel")
    XCTAssertEqual(alertProperties?.style, .actionSheet)
  }

  func testSetupAlertControllerSuccess() {
    XCTAssertEqual(alertController?.title, "Choose Photo")
    XCTAssertNil(alertController?.message)
    XCTAssertEqual(alertController?.preferredStyle, .actionSheet)
  }
}
