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

class PickImageAlertTests: XCTestCase {

  // MARK: - Properties
  private var pickImageAlert: PickImageAlert?

  // MARK: - Overrides
  override func setUp() {
    super.setUp()

    let controller = MockViewController()

    let properties = PIAlertProperties(
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
    XCTAssertEqual(pickImageAlert?.limitImages, 30)
    XCTAssertEqual(pickImageAlert?.imageSize, CGSize(width: 320, height: 320))
  }

  func testSetupAlertControllerWithSuccess() {
    XCTAssertEqual(pickImageAlert?.alertController?.actions.count, 3)
    XCTAssertEqual(pickImageAlert?.alertController?.actions[0].title, "Camera")
    XCTAssertEqual(pickImageAlert?.alertController?.actions[1].title, "Gallary")
    XCTAssertEqual(pickImageAlert?.alertController?.actions[2].title, "Cancelar")
  }
}
