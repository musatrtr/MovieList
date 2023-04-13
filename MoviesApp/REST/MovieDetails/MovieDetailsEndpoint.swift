//
//  MovieDetailsEndpoint.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 11.04.23.
//

import Foundation

enum MovieDetailsEndpoint: Endpoint {
    
    case movieList(id: Int)
    
    var path: String {
        switch self {
        case .movieList(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var parameters: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: "c9856d0cb57c3f14bf75bdc6c063b8f3")]
    }
}
