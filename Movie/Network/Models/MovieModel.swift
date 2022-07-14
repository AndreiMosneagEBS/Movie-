//
//  MovieModel.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import Foundation

// MARK: - Welcome
struct MovieModels: Codable {
    let page: Int
    let totalPages, totalResults: Int
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Results: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case english = "en"
    case espanole = "es"
    case japan = "ja"
}
