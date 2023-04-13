//
//  PresenterInterface.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation

public protocol PresenterInterface: AnyObject {
    func viewDidLoad()
}

public extension PresenterInterface {
    func viewDidLoad() {}
}
