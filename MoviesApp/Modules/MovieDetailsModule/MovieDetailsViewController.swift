//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 08.04.23.
//

import Foundation
import UIKit

private extension MovieDetailsViewController {
    struct Constant {
        static let backgroundColor: UIColor = .white
        static let containerBackgroundColor: UIColor = .clear
        static let scrollViewBackgroundColor: UIColor = .clear
        static let scrollViewShowsVerticalScrollIndicator: Bool = false
        static let innerContainerBackgroundColor: UIColor = .clear
        
        struct PosterImage {
            static let cornerRadius: CGFloat = 8
            static let backgroundColor: UIColor = .darkGray.withAlphaComponent(0.1)
            
        }
        
        struct Year {
            static let textAlignment: NSTextAlignment = .left
            static let font: UIFont = .systemFont(ofSize: 12, weight: .bold)
            static let textColor: UIColor = .darkGray
        }
        
        struct Rating {
            static let textAlignment: NSTextAlignment = .left
            static let font: UIFont = .systemFont(ofSize: 12, weight: .bold)
            static let textColor: UIColor = .darkGray
        }
        
        struct Description {
            static let textAlignment: NSTextAlignment = .justified
            static let font: UIFont = .systemFont(ofSize: 12, weight: .regular)
            static let textColor: UIColor = .darkGray
        }
    }
}

protocol MovieDetailsViewInterface: ViewInterface {
    func prepareUI(movieName: String)
    func setInfo(with info: MovieDetailsEntity)
}

final class MovieDetailsViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var innerContainerView: UIView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var year: UILabel!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    
    static var storyboardName: StoryboardNames {
        return .Movie
    }
    
    var presenter: MovieDetailsPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension MovieDetailsViewController: MovieDetailsViewInterface {
    func prepareUI(movieName: String) {
        navigationItem.title = movieName
        view.backgroundColor = Constant.backgroundColor
        
        containerView.backgroundColor = Constant.containerBackgroundColor
        
        scrollView.backgroundColor = Constant.scrollViewBackgroundColor
        scrollView.showsVerticalScrollIndicator = Constant.scrollViewShowsVerticalScrollIndicator
        
        innerContainerView.backgroundColor = Constant.innerContainerBackgroundColor
        
        posterImage.layer.cornerRadius = Constant.PosterImage.cornerRadius
        posterImage.image = nil
        posterImage.backgroundColor = Constant.PosterImage.backgroundColor
        posterImage.contentMode = .scaleAspectFill
        
        year.textAlignment = Constant.Year.textAlignment
        year.font = Constant.Year.font
        year.textColor = Constant.Year.textColor
        year.text = ""
        
        rating.textAlignment = Constant.Rating.textAlignment
        rating.font = Constant.Rating.font
        rating.textColor = Constant.Rating.textColor
        rating.text = ""
        
        movieDescription.textAlignment = Constant.Description.textAlignment
        movieDescription.font = Constant.Description.font
        movieDescription.textColor = Constant.Description.textColor
        movieDescription.text = ""
    }
    
    func setInfo(with info: MovieDetailsEntity) {
        if let posterPath = info.posterImagePath {
            posterImage.loadImage(from: posterPath)
        }
        
        if let yearText = info.year {
            year.text = yearText
        } else {
            year.isHidden = true
        }
        
        if let ratingText = info.rating {
            rating.text = ratingText
        } else {
            rating.isHidden = true
        }
        
        if let movieDescriptionText = info.movieDescription {
            movieDescription.text = movieDescriptionText
        } else {
            movieDescription.isHidden = true
        }
    }
}
