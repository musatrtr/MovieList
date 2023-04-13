//
//  Storyboarded.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

public protocol Storyboarded {
    static var storyboardName: StoryboardNames { get }
    static func instantiate(identifier: String?) -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate(identifier: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier ?? self.className) as? Self else {
            fatalError("Storyboard cannot instantiated")
        }

        return vc
    }
}
