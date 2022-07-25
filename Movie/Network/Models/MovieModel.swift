//
//  MovieModel.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.


import Foundation

struct MovieResult: Codable {
    let page: Int
    let results: [Movie]

}

// MARK: - Result
struct Movie: Codable, Equatable {
    let originalLanguage: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let overview: String
    let id: Int
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        

        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case overview, popularity, id
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
}


struct ReviewResult: Codable {
    let id, page: Int?
    let results: [Review]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
}

struct Review: Codable, Equatable {
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id
    }
    
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

struct Genre: Codable {
    let genres: [NameGenre]
}

// MARK: - Genre
struct NameGenre: Codable {
    let id: Int?
    let name: String?
}





struct Details: Codable {
    let genres: [Genres]
    let originalTitle: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case genres
        case originalTitle = "original_title"
        case overview
    }
}

struct Genres: Codable {
    let id: Int
    let name: String
}
