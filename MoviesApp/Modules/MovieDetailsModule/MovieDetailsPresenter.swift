//
//  MovieDetailsPresenter.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation

protocol MovieDetailsPresenterInterface: PresenterInterface {
    
}

final class MovieDetailsPresenter {
    
    private let router: MovieDetailsRouterInterface
    private let interactor: MovieDetailsInteractorInterface
    private weak var view: MovieDetailsViewInterface?
    private let movie: Movie
    private var movieDetails: MovieDetailsResponse?
    init(router: MovieDetailsRouterInterface, interactor: MovieDetailsInteractorInterface, view: MovieDetailsViewInterface?, movie: Movie) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.movie = movie
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI(movieName: movie.title ?? "")
        view?.showHUD()
        if let id = movie.id {
            interactor.getMovieDetails(movieID: id)
        }
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutput {
    func updateMovieDetails(with details: MovieDetailsResponse) {
        movieDetails = details
        
        var ratingText: String?
        
        if let rating = movie.voteAverage, let vote = movie.voteCount {
            ratingText = "\(rating) rating in \(vote) vote(s)"
        }
        
        let info = MovieDetailsEntity(
            posterImagePath: movieDetails?.posterPath,
            movieTitle: movieDetails?.title,
            year: movieDetails?.releaseDate,
            rating: ratingText,
            movieDescription: movieDetails?.overview
        )
        
        view?.setInfo(with: info)
        view?.dismissHUD()
    }
    
    func handleLoadingError(_ error: Error) {
        view?.dismissHUD()
        view?.showAlert(message: error.localizedDescription, title: "Error", action: nil)
    }
}
