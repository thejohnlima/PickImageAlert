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

    var cameraImage: UIImage?
    var gallaryImage: UIImage?

    if #available(iOS 13.0, *) {
      cameraImage = UIImage(systemName: "camera")
      gallaryImage = UIImage(systemName: "photo")
    }

    let properties = PIAlertProperties(
      title: "Pick Image",
      cameraActionTitle: "Camera",
      gallaryActionTitle: "Gallary",
      cancelActionTitle: "Cancel",
      cameraActionImage: cameraImage,
      gallaryActionImage: gallaryImage,
      textColor: .purple,
      style: .alert
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
