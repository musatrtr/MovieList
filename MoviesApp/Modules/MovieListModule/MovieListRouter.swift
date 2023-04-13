//
//  MovieListRouter.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

protocol MovieListRouterInterface {
    func navigateToMovieDetails(for movie: Movie)
}

final class MovieListRouter {
    private weak var presenter: MovieListPresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = MovieListInteractor()
        let view = MovieListViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = MovieListRouter(navigationController: navCon)
        let presenter = MovieListPresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

extension MovieListRouter: MovieListRouterInterface {
    func navigateToMovieDetails(for movie: Movie) {
        let view = MovieDetailsRouter.createModule(for: movie, navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
}
