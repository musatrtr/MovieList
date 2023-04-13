//
//  MovieListEndpoint.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

import Foundation

enum MovieListEndpoint: Endpoint {
    
    case movieList(page: Int)
    
    var path: String {
        switch self {
        case .movieList:
            return "/3/discover/movie"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .movieList(let page):
            var params: [URLQueryItem] = []
            params.append(URLQueryItem(name: "api_key", value: "c9856d0cb57c3f14bf75bdc6c063b8f3"))
            params.append(URLQueryItem(name: "page", value: "\(page)"))
            return params
        }
    }
}
