//
//  MovieModel.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.


import Foundation

struct MovieModels: Codable {
    let page: Int
    let results: [Results]

}

// MARK: - Result
struct Results: Codable {
    let originalLanguage: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let overview: String


    enum CodingKeys: String, CodingKey {

        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview, popularity
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
}


