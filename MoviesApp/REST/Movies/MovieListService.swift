//
//  MovieListService.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

import Foundation
import Combine

protocol MovieListService {
    var apiSession: NetworkProtocol {get}
    
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
}
