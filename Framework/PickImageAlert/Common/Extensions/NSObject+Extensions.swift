//
//  NSObject+Extensions.swift
//  PickImageAlert
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

extension NSObject {
  internal var identifier: String {
    return String(describing: type(of: self))
  }

  internal static var identifier: String {
    return String(describing: self)
  }
}
