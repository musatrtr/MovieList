//
//  MovieListInteractor.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation
import Combine

protocol MovieListInteractorInterface {
    func loadMovieList(page: Int)
}

protocol MovieListInteractorOutput: AnyObject {
    func updateMovieList(with list: MovieListResponse)
    func handleLoadingError(_ error: Error)
}

final class MovieListInteractor {
    weak var output: MovieListInteractorOutput?
    
    private(set) var apiSession: NetworkProtocol
    private var cancellables = Set<AnyCancellable>()
        
    init(apiSession: NetworkProtocol = NetworkManager()) {
        self.apiSession = apiSession
    }
}

extension MovieListInteractor: MovieListInteractorInterface {
    func loadMovieList(page: Int) {
        let cancellable = self.getMovieList(page: page)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.output?.handleLoadingError(error)
                case .finished:
                    break
                }
            }) { [weak self] (response) in
                DispatchQueue.main.async { [weak self] in
                    self?.output?.updateMovieList(with: response)
                }
            }
        cancellables.insert(cancellable)
    }
}

extension MovieListInteractor: MovieListService {
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return apiSession
            .request(with: MovieListEndpoint.movieList(page: page))
            .eraseToAnyPublisher()
    }
}
