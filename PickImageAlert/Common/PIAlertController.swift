//
//  PIAlertController.swift
//  PickImageAlert
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

import UIKit

public class PIAlertController: UIAlertController {

  // MARK: - Properties
  internal var didAppear: ((_ alert: UIAlertController) -> Void)?
  internal var didDisappear: ((_ alert: UIAlertController) -> Void)?

  // MARK: - View LifeCycle
  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    didAppear?(self)
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    didDisappear?(self)
  }
}

// MARK: - Extensions
extension PIAlertController {
  public struct AlertProperties {

    public var title: String?
    public var message: String?
    public var style: Style
    public var cameraActionTitle: String
    public var gallaryActionTitle: String
    public var cancelActionTitle: String

    public init(title: String?,
                cameraActionTitle: String,
                gallaryActionTitle: String,
                cancelActionTitle: String,
                message: String? = nil,
                style: Style = .actionSheet) {

      var alertStyle: Style {
        guard !UIDevice.current.isPad else {
          return .alert
        }
        return style
      }

      self.title = title
      self.message = message
      self.style = alertStyle
      self.cameraActionTitle = cameraActionTitle
      self.gallaryActionTitle = gallaryActionTitle
      self.cancelActionTitle = cancelActionTitle
    }
  }
}
