//
//  Localizable.swift
//  PickImageAlert
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

import Foundation

internal struct Localizable {
  static let errorTitle = "error.title".localized()
  static let errorNoCamera = "error.noCamera".localized()
  static let titleCancel = "title.cancel".localized()
}

extension String {
  internal func localized(withComment comment: String? = nil) -> String {
    let bundle = Bundle(for: PickImageAlert.self)
    return NSLocalizedString(self, bundle: bundle, comment: comment ?? "")
  }
}
