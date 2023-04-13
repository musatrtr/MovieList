//
//  MovieListTableCellModel.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 12.04.23.
//

import Foundation

struct MovieListTableCellModel: Codable {
    let posterPath: String?
    let title: String?
    let releaseDate: String?
    let rating: String?
}
