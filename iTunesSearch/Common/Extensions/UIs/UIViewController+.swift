//
//  UIViewController+.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

extension UIViewController: Reusable {}

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: T.identifier, bundle: nil)
    }
    return instantiateFromNib()
  }
  func showAlert(title: String?,
                 message: String?,
                 leftButton: String?,
                 rightButton: String?,
                 completionLeft: VoidCallback = nil,
                 completionRight: VoidCallback = nil) -> Void {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if let leftButton = leftButton {
      let firstAction = UIAlertAction(title: leftButton, style: .default) { (_) in
        if completionLeft != nil {
          completionLeft!()
        }
      }
      alert.addAction(firstAction)
    }
    if let rightButton = rightButton {
      let secondAction = UIAlertAction(title: rightButton, style: .default) { (_) in
        if completionRight != nil {
          completionRight!()
        }
      }
      alert.addAction(secondAction)
    }
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }
}
