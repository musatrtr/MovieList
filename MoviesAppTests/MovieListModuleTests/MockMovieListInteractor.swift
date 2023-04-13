//
//  MockMovieListInteractor.swift
//  MoviesAppTests
//
//  Created by Musa Kökcen on 13.04.23.
//

@testable import MoviesApp

class MockMovieListInteractor: MovieListInteractorInterface {
    weak var output: MovieListInteractorOutput?

    var isLoadMovieListCalled: Bool = false
    
    func loadMovieList(page: Int) {
        isLoadMovieListCalled = true
    }
}
