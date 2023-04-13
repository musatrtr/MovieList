//
//  MovieDetailsInteractor.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation
import Combine

protocol MovieDetailsInteractorInterface {
    func getMovieDetails(movieID: Int)
}

protocol MovieDetailsInteractorOutput: AnyObject {
    func updateMovieDetails(with details: MovieDetailsResponse)
    func handleLoadingError(_ error: Error)
}

final class MovieDetailsInteractor {
    
    weak var output: MovieDetailsInteractorOutput?
    
    private(set) var apiSession: NetworkProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiSession: NetworkProtocol = NetworkManager()) {
        self.apiSession = apiSession
    }
}

extension MovieDetailsInteractor: MovieDetailsService {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, APIError> {
        return apiSession
            .request(with: MovieDetailsEndpoint.movieList(id: id))
            .eraseToAnyPublisher()
    }
    
    
}

extension MovieDetailsInteractor: MovieDetailsInteractorInterface {
    func getMovieDetails(movieID: Int) {
        let cancellable = self.getMovieDetails(id: movieID)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.output?.handleLoadingError(error)
                case .finished:
                    break
                }
            }) { [weak self] (response) in
                DispatchQueue.main.async { [weak self] in
                    self?.output?.updateMovieDetails(with: response)
                }
            }
        cancellables.insert(cancellable)
    }
}
