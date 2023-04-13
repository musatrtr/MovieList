//
//  RouterInterface.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

public protocol RouterInterface: AnyObject {
    var navigationController: UINavigationController? { get set }
}
