//
//  APIError.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

import Foundation

public enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
