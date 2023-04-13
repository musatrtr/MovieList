//
//  CacheManager.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 12.04.23.
//

import Foundation
import UIKit

class CacheManager {

    static let shared = CacheManager()
    
    private var gifCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        return cache
    }()
    
    
    func add(key: NSString, value: UIImage) {
        gifCache.setObject(value, forKey: key)
    }
    
    func getFrom(key: NSString) -> UIImage? {
        gifCache.object(forKey: key)
    }
}
