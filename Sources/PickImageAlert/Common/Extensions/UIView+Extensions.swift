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

// MARK: - Constants
private let loadNibError = "Could not load nib with identifier"

// MARK: - Protocols
extension UIView {
  func rounded(withCornerRadius: CGFloat? = nil) {
    layer.cornerRadius = withCornerRadius ?? bounds.height / 2
    layer.masksToBounds = true
  }

  static func fromNib<T: AnyObject>() -> T {
    let name = String(describing: T.self)
    let bundle = Bundle(for: T.self)
    guard let result = bundle.loadNibNamed(name, owner: nil)?.first as? T else {
      fatalError("⚠️ \(loadNibError): \(T.self)")
    }
    return result
  }
}
