//
//  ViewInterface.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

public protocol ViewInterface: AnyObject {
    static var storyboardId: String { get }
    func showHUD()
    func dismissHUD()
    func showAlert(message: String, title: String, action: (() -> Void)?)
}

public extension ViewInterface where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
    
    func showHUD() {
        self.showHUD()
    }
    
    func dismissHUD() {
        self.dismissHUD()
    }
    
    func showAlert(message: String, title: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            Utils.showAlert(message: message, title: title, view: self, action: action)
        }
    }
}
