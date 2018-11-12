//
//  ViewController.swift
//  Demo
//
//  Created by John Lima on 11/11/18.
//  Copyright © 2018 jlimadeveloper. All rights reserved.
//

import PickImageAlert
import UIKit

class ViewController: UIViewController {

  // MARK: - Properties
  var pickImageAlert: PickImageAlert?

  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  // MARK: - Actions
  @IBAction private func choosePhoto(sender: Any?) {
    pickImageAlert?.pickImage { image in
      print("image: \(String(describing: image))")
    }
  }

  // MARK: - Private Methods
  private func setupUI() {
    let properties = PIAlertController.AlertProperties(
      title: "Choose Image",
      cameraActionTitle: "Camera",
      gallaryActionTitle: "Gallary",
      cancelActionTitle: "Cancelar"
    )

    pickImageAlert = PickImageAlert(with: self, alertProperties: properties)
  }
}
