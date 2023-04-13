//
//  MovieDetailsRouter.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

protocol MovieDetailsRouterInterface {

}

final class MovieDetailsRouter {
    private weak var presenter: MovieDetailsPresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(for movie: Movie, navigationController: UINavigationController?) -> UIViewController {

        let interactor = MovieDetailsInteractor()
        let view = MovieDetailsViewController.instantiate()
        let router = MovieDetailsRouter(navigationController: navigationController)
        let presenter = MovieDetailsPresenter(router: router, interactor: interactor, view: view, movie: movie)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension MovieDetailsRouter: MovieDetailsRouterInterface {}
