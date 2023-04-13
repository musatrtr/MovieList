//
//  MockMovieListRouter.swift
//  MoviesAppTests
//
//  Created by Musa Kökcen on 13.04.23.
//

@testable import MoviesApp

class MockMovieListRouter: MovieListRouterInterface {
    var isNavigateToMovieDetailsCalled: Bool = false
    
    func navigateToMovieDetails(for movie: MoviesApp.Movie) {
        isNavigateToMovieDetailsCalled = true
    }
}
