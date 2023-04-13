//
//  UITableViewExtensions.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 11.04.23.
//

import UIKit

extension UITableViewCell {
    class func getNib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
    
    class var identifier: String {
        return self.className
    }
}
