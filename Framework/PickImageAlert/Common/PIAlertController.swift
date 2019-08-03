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

import UIKit

public class PIAlertController: UIAlertController {

  // MARK: - Properties
  internal var willAppear: (() -> Void)?
  internal var didAppear: (() -> Void)?
  internal var didDisappear: (() -> Void)?
  internal var willChangeOrientation: (() -> Void)?
  internal var willLayoutSubviews: (() -> Void)?
  internal var didLayoutSubviews: (() -> Void)?

  // MARK: - View LifeCycle
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    willAppear?()
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    didAppear?()
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    didDisappear?()
  }

  override public func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    willLayoutSubviews?()
  }

  override public func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    didLayoutSubviews?()
  }

  override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    willChangeOrientation?()
  }
}

// MARK: - Extensions
extension PIAlertController {
  public struct AlertProperties {

    public var title: String?
    public var style: Style
    public var cameraActionTitle: String
    public var gallaryActionTitle: String
    public var cancelActionTitle: String

    public init(title: String?,
                cameraActionTitle: String,
                gallaryActionTitle: String,
                cancelActionTitle: String,
                style: Style = .actionSheet) {

      var alertStyle: Style {
        guard !UIDevice.current.isPad else {
          return .alert
        }
        return style
      }

      self.title = title
      self.style = alertStyle
      self.cameraActionTitle = cameraActionTitle
      self.gallaryActionTitle = gallaryActionTitle
      self.cancelActionTitle = cancelActionTitle
    }
  }
}
