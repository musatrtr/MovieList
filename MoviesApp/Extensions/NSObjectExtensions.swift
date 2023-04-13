//
//  NSObjectExtensions.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation

extension NSObject {
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
}
