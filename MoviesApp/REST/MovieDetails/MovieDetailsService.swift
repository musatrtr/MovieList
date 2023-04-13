//
//  MovieDetailsService.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 11.04.23.
//

import Foundation
import Combine

protocol MovieDetailsService {
    var apiSession: NetworkProtocol {get}
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, APIError>
}
