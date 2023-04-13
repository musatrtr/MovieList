//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

//https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate

import Foundation

public protocol Endpoint {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    
}

public extension Endpoint {
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "api.themoviedb.org"
    }

    var parameters: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: "c9856d0cb57c3f14bf75bdc6c063b8f3")]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

public extension Endpoint {
    func buildURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = parameters
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
