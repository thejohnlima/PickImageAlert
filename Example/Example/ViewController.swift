//
//  ViewController.swift
//  Example
//
//  Created by John Lima on 15/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit
import PickImageAlert

class ViewController: UIViewController {

  // MARK: - Properties
  private var pickImageAlert: PickImageAlert?

  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    let properties = PIAlertController.AlertProperties(
      title: "Pick Image",
      cameraActionTitle: "Camera",
      gallaryActionTitle: "Gallary",
      cancelActionTitle: "Cancel",
      style: .actionSheet
    )

    pickImageAlert = PickImageAlert(with: self, alertProperties: properties)
  }

  // MARK: - Actions
  @IBAction private func pickImage(sender: Any?) {
    pickImageAlert?.pickImage { image in
      print("📷 selected photo: \(String(describing: image))")
    }
  }
}
