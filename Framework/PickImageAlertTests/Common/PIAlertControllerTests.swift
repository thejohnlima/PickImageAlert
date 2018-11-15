//
//  PIAlertControllerTests.swift
//  PickImageAlertTests
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
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
      message: "The latest photos from your library",
      style: .actionSheet
    )

    alertController = PIAlertController(
      title: alertProperties?.title,
      message: alertProperties?.message,
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
    XCTAssertEqual(alertProperties?.message, "The latest photos from your library")
    XCTAssertEqual(alertProperties?.cameraActionTitle, "Camera")
    XCTAssertEqual(alertProperties?.gallaryActionTitle, "Gallary")
    XCTAssertEqual(alertProperties?.cancelActionTitle, "Cancel")
    XCTAssertEqual(alertProperties?.style, .actionSheet)
  }

  func testSetupAlertControllerSuccess() {
    XCTAssertEqual(alertController?.title, "Choose Photo")
    XCTAssertEqual(alertController?.message, "The latest photos from your library")
    XCTAssertEqual(alertController?.preferredStyle, .actionSheet)
  }
}
