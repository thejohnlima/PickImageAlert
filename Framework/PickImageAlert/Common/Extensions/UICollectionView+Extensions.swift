//
//  UICollectionView+Extensions.swift
//  PickImageAlert
//
//  Created by John Lima on 10/11/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

internal let errorDequeueCellIdenfier = "Could not dequeue cell with identifier"

extension UICollectionView {

  internal func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }

  internal func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NIBLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }

  internal func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
      fatalError("⚠️  \(errorDequeueCellIdenfier): \(T.defaultReuseIdentifier)")
    }
    return cell
  }
}
