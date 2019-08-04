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

import Foundation

/// Properties used to setup the alert
public struct PIAlertProperties {

  public var title: String?
  public var textColor: UIColor?
  public var style: UIAlertController.Style
  public var cameraActionTitle: String
  public var cameraActionImage: UIImage?
  public var gallaryActionTitle: String
  public var gallaryActionImage: UIImage?
  public var cancelActionTitle: String

  /// Initialize properties to setup the alert
  /// - Parameter title: The text that will appear on top of the alert
  /// - Parameter cameraActionTitle: Title for camera action
  /// - Parameter gallaryActionTitle: Title for gallary action
  /// - Parameter cancelActionTitle: Title for cancel action
  /// - Parameter cameraActionImage: Image for camera action
  /// - Parameter gallaryActionImage: Image for gallary action
  /// - Parameter textColor: The text color for actions title
  /// - Parameter style: Alert style (**.alert** or **.actionSheet**)
  public init(title: String?,
              cameraActionTitle: String,
              gallaryActionTitle: String,
              cancelActionTitle: String,
              cameraActionImage: UIImage? = nil,
              gallaryActionImage: UIImage? = nil,
              textColor: UIColor? = nil,
              style: UIAlertController.Style = .actionSheet) {

    var alertStyle: UIAlertController.Style {
      guard !UIDevice.current.isPad else {
        return .alert
      }
      return style
    }

    self.title = title
    self.textColor = textColor
    self.style = alertStyle
    self.cameraActionTitle = cameraActionTitle
    self.gallaryActionTitle = gallaryActionTitle
    self.cancelActionTitle = cancelActionTitle
    self.cameraActionImage = cameraActionImage
    self.gallaryActionImage = gallaryActionImage
  }
}
