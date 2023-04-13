//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import UIKit

private extension MovieListViewController {
    struct Constant {
        static let title: String = "Popular Movies"
        static let backgroundColor: UIColor = .white
        
        struct TableView {
            static let backgroundColor: UIColor = .darkGray.withAlphaComponent(0.1)
            static let estimatedRowHeight: CGFloat = 100
        }
    }
}

protocol MovieListViewInterface: ViewInterface {
    func prepareUI()
    func reloadData()
}

final class MovieListViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private weak var popularMoviesTableView: UITableView!
    
    static var storyboardName: StoryboardNames {
        return .Movie
    }
    
    var presenter: MovieListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MovieListViewController: MovieListViewInterface {
    func prepareUI() {
        navigationItem.title = Constant.title
        view.backgroundColor = Constant.backgroundColor
        
        popularMoviesTableView.backgroundColor = Constant.TableView.backgroundColor
        popularMoviesTableView.delegate = self
        popularMoviesTableView.dataSource = self
        popularMoviesTableView.separatorStyle = .none
        popularMoviesTableView.register(MovieListTableViewCell.getNib(),
                                        forCellReuseIdentifier: MovieListTableViewCell.identifier)
        popularMoviesTableView.showsVerticalScrollIndicator = false
//        popularMoviesTableView.estimatedRowHeight = Constant.TableView.estimatedRowHeight
        popularMoviesTableView.isPagingEnabled = false
    }
    
    func reloadData() {
        popularMoviesTableView.reloadData()
        popularMoviesTableView.layoutIfNeeded()
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell {
            if let movieInfo = presenter.getMovieInfo(for: indexPath.row) {
                cell.configure(with: movieInfo)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath.row)
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
