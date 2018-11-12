//
//  UIDevice+Extensions.swift
//  PickImageAlert
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

import UIKit

extension UIDevice {
  internal var isPad: Bool {
    return userInterfaceIdiom == .pad
  }
}
