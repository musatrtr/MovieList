//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 10.04.23.
//

import Foundation
import Combine

struct NetworkManager: NetworkProtocol {
    
    func request<T>(with builder: Endpoint) -> AnyPublisher<T, APIError> where T: Decodable {
        
        let decoder = JSONDecoder()
        
        guard let request = builder.buildURL() else {
            return Fail(
                error: .unknown
            ).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError {_ in .decodingError}
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func download(from path: String) -> AnyPublisher<Data, APIError> {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(path)") else {
            return Just(Data())
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap({ output in
                if let response = output.response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        return output.data
                    default:
                        throw APIError.httpError(response.statusCode)
                    }
                }
                throw APIError.unknown
            })
            .mapError { error in
                return APIError.decodingError
            }
            .eraseToAnyPublisher()
    }
}
