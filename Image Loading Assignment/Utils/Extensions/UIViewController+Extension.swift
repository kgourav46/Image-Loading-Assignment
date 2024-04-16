//
//  UIViewController+Extension.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstants.ok, style: .default))
        self.present(alert, animated: true)
    }
}
