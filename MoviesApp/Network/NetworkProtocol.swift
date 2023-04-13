//
//  NetworkProtocol.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func request<T: Decodable>(with builder: Endpoint) -> AnyPublisher<T, APIError>
    func download(from path: String) -> AnyPublisher<Data, APIError>
}
