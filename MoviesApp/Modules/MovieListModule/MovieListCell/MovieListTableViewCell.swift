//
//  MovieListTableViewCell.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 11.04.23.
//

import UIKit
import Combine

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var separator: UIView!
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    override func prepareForReuse() {
        prepareUI()
    }
    
    private func prepareUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        container.backgroundColor = .clear
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 4
        container.layer.borderColor = UIColor.darkGray.cgColor
        
        separator.backgroundColor = .darkGray
        
        moviePoster.backgroundColor = .clear
        moviePoster.layer.cornerRadius = 8
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.image = nil
        
        movieTitle.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        movieTitle.textColor = .darkGray
        movieTitle.text = ""
        
        releaseDate.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        releaseDate.textColor = .darkGray
        releaseDate.text = ""
        
        rating.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rating.textColor = .darkGray
        rating.text = ""
    }
    
    func configure(with info: MovieListTableCellModel) {
        if let title = info.title {
            movieTitle.text = title
        } else {
            movieTitle.text = "Popular Movie"
        }
        
        if let releaseDateText = info.releaseDate {
            releaseDate.text = releaseDateText
        } else {
            releaseDate.isHidden = true
        }
        
        if let ratingText = info.rating {
            rating.text = ratingText
        } else {
            rating.isHidden = true
        }
        
        if let path = info.posterPath {
            moviePoster.loadImage(from: path)
        }

//        moviePoster.loadImage(from: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg")
    }
    
}
