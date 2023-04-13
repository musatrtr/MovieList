//
//  MovieListPresenterTests.swift
//  MoviesAppTests
//
//  Created by Musa Kökcen on 13.04.23.
//

import XCTest
@testable import MoviesApp

class MovieListPresenterTests: XCTestCase {
    var presenter: MovieListPresenter!
    var mockRouter: MockMovieListRouter!
    var mockInteractor: MockMovieListInteractor!
    var mockView: MockMovieListView!
    
    static var response = MovieListResponse(page: 1, results: [Movie(adult: false, backdropPath: "", genreIDS: nil, id: 123, originalLanguage: nil, originalTitle: nil, overview: "overview", popularity: nil, posterPath: "path", releaseDate: "12-12-22", title: "title", video: nil, voteAverage: 4.5, voteCount: 234)], totalPages: 2, totalResults: 2)
    
    override func setUp() {
        mockRouter = MockMovieListRouter()
        mockInteractor = MockMovieListInteractor()
        mockView = MockMovieListView()
        presenter = MovieListPresenter(router: mockRouter, interactor: mockInteractor, view: mockView)
        mockInteractor.output = presenter
    }
    
    override func tearDown() {
        mockView.isShowHUDCalled = false
        mockInteractor.isLoadMovieListCalled = false
        mockView.isReloadDataCalled = false
        mockView.isDismissHUDCalled = false
    }
    
    func test_viewDidLoad_Success() {
        
        XCTAssertFalse(mockView.isPrepareUICalled)
        XCTAssertFalse(mockView.isShowHUDCalled)
        XCTAssertFalse(mockInteractor.isLoadMovieListCalled)

        presenter.viewDidLoad()

        XCTAssertTrue(mockView.isPrepareUICalled)
        XCTAssertTrue(mockView.isShowHUDCalled)
        XCTAssertTrue(mockInteractor.isLoadMovieListCalled)
    }
    
    func test_didSelectMovie_Success() {
        XCTAssertFalse(mockRouter.isNavigateToMovieDetailsCalled)
       
        presenter.updateMovieList(with: MovieListPresenterTests.response)
        presenter.didSelectMovie(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockRouter.isNavigateToMovieDetailsCalled)
    }
    
    func test_numberOfMovies_Success() {
        XCTAssertEqual(presenter.numberOfMovies(), 0)
    
        presenter.updateMovieList(with: MovieListPresenterTests.response)

        XCTAssertEqual(presenter.numberOfMovies(), 1)
    }
    
    func test_getMovieInfo_Success() {
        XCTAssertNil(presenter.getMovieInfo(for: 0))
    
        presenter.updateMovieList(with: MovieListPresenterTests.response)

        let expectedModel = MovieListTableCellModel(posterPath: "path", title: "title", releaseDate: "12-12-22", rating: "4.5 rating in 234 vote(s)")
        
        XCTAssertEqual(presenter.getMovieInfo(for: 0)?.posterPath, expectedModel.posterPath)
        XCTAssertEqual(presenter.getMovieInfo(for: 0)?.title, expectedModel.title)
        XCTAssertEqual(presenter.getMovieInfo(for: 0)?.releaseDate, expectedModel.releaseDate)
        XCTAssertEqual(presenter.getMovieInfo(for: 0)?.rating, expectedModel.rating)
    }
    
    func test_willDisplayCell_Success() {
        XCTAssertFalse(mockView.isShowHUDCalled)
        XCTAssertFalse(mockInteractor.isLoadMovieListCalled)

        presenter.updateMovieList(with: MovieListPresenterTests.response)
        presenter.willDisplayCell(at: 0)

        XCTAssertTrue(mockView.isShowHUDCalled)
        XCTAssertTrue(mockInteractor.isLoadMovieListCalled)
    }
    
    func test_updateMovieList_Success() {
        XCTAssertFalse(mockView.isReloadDataCalled)
        XCTAssertFalse(mockView.isDismissHUDCalled)
        
        presenter.updateMovieList(with: MovieListPresenterTests.response)
        
        XCTAssertTrue(mockView.isReloadDataCalled)
        XCTAssertTrue(mockView.isDismissHUDCalled)
    }
    
    func test_handleLoadingError_Success() {
        
    }
}
