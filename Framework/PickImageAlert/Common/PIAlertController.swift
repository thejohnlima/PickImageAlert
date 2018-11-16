//
//  PIAlertController.swift
//  PickImageAlert
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

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
