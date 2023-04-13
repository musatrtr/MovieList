//
//  Utils.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

class Utils {
    class func showAlert(message: String, title: String, view: UIViewController, action: (() -> Void)?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let action = action {
                action()
            }
        }))
        view.present(alertViewController, animated: true)
    }
}
