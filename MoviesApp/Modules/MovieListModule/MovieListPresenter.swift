//
//  MovieListPresenter.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation

protocol MovieListPresenterInterface: PresenterInterface {
    func didSelectMovie(at indexPath: IndexPath)
    func numberOfMovies() -> Int
    func getMovieInfo(for row: Int) -> MovieListTableCellModel?
    func willDisplayCell(at row: Int)
}

final class MovieListPresenter {

    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface
    private weak var view: MovieListViewInterface?
    
    private var movies: MovieListResponse?
    
    init(router: MovieListRouterInterface, interactor: MovieListInteractorInterface, view: MovieListViewInterface?) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension MovieListPresenter: MovieListPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.showHUD()
        interactor.loadMovieList(page: 1)
    }
    
    func numberOfMovies() -> Int {
        return movies?.results?.count ?? 0
    }
    
    func getMovieInfo(for row: Int) -> MovieListTableCellModel? {        
        guard let movie = movies?.results?[row] else {
            return nil
        }
    
        var ratingText: String?
    
        if let rating = movie.voteAverage, let vote = movie.voteCount {
            ratingText = "\(rating) rating in \(vote) vote(s)"
        }
        
        return MovieListTableCellModel(posterPath: movie.posterPath, title: movie.title, releaseDate: movie.releaseDate, rating: ratingText)
    }
    
    func didSelectMovie(at indexPath: IndexPath) {
        guard let movies, let result = movies.results?[indexPath.row] else { return }
        router.navigateToMovieDetails(for: result)
    }
    
    func willDisplayCell(at row: Int) {
        guard let movies, (movies.page ?? 0) < 10 else { return }
        if row == (movies.results?.count ?? 0) - 1 && movies.totalPages ?? 0 > movies.page ?? 0 {
            view?.showHUD()
            interactor.loadMovieList(page: (movies.page ?? 0) + 1)
        }
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    func updateMovieList(with list: MovieListResponse) {
        if movies == nil {
            movies = list
        } else {
            movies?.results?.append(contentsOf: list.results ?? [])
            movies?.page = list.page
        }
        
        view?.reloadData()
        view?.dismissHUD()
    }
    
    func handleLoadingError(_ error: Error) {
        view?.showAlert(message: error.localizedDescription, title: "Error", action: nil)
        view?.dismissHUD()
    }
}
