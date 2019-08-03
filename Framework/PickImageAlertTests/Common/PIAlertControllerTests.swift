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
