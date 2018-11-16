//
//  PICollectionImageCell.swift
//  LookME
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

internal class PICollectionImageCell: UICollectionViewCell, ReusableView, NIBLoadableView {
  
  // MARK: - Constants
  private let photoCornerRadius: CGFloat = 3
  
  // MARK: - Properties
  @IBOutlet weak var photoImageView: UIImageView!
  
  var image: UIImage? {
    didSet {
      photoImageView.image = image
    }
  }
  
  // MARK: - Overrides
  override func awakeFromNib() {
    super.awakeFromNib()
    photoImageView.rounded(withCornerRadius: photoCornerRadius)
  }
}
