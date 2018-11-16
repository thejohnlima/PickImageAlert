//
//  UIView+Extensions.swift
//  PickImageAlert
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

// MARK: - Constants
internal let loadNibError = "Could not load nib with identifier"

// MARK: - Protocols
internal protocol ReusableView: AnyObject {
  static var defaultReuseIdentifier: String { get }
}

internal protocol NIBLoadableView: AnyObject {
  static var nibName: String { get }
}

extension ReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

// MARK: - Extensions
extension NIBLoadableView where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}

extension UIView {

  // MARK: - Public Methods
  internal func rounded(withCornerRadius: CGFloat? = nil) {
    layer.cornerRadius = withCornerRadius ?? bounds.height / 2
    layer.masksToBounds = true
  }

  internal static func fromNib<T: UIView>() -> T {
    let name = String(describing: T.self)
    let bundle = Bundle(for: T.self)
    guard let result = bundle.loadNibNamed(name, owner: nil)?.first as? T else {
      fatalError("⚠️ \(loadNibError): \(T.identifier)")
    }
    return result
  }
}
