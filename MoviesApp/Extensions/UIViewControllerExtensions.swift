//
//  UIViewControllerExtensions.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 13.04.23.
//

import UIKit

extension UIViewController {
    func showHUD() {
        let spinner = UIActivityIndicatorView(style: .large)
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.startAnimating()
        spinner.tag = 1000
    }
    
    func dismissHUD() {
        view.subviews.forEach { view in
            if view.tag == 1000 {
                view.removeFromSuperview()
            }
        }
    }
}
