//
//  FR.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import Alamofire
import SwiftyJSON
import Foundation


class Request {
    
    static let shared = Request()
    let decoder = JSONDecoder()
    
    func fetchMovies(completion: @escaping (Result<[Movie],Error>)-> Void) {
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(API_KEY)").response { response in
            switch response.result {
            case .success(let values):
                if let values = values {
                    let movies = try? self.decoder.decode(MovieResult.self, from: values)
                    if let movies = movies {
                        completion(.success(movies.results))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>)->  Void ) {
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=\(API_KEY)&query=\(query)", method: .get).response {response in
            switch response .result {
            case .success(let value):
                if let value = value {
                    do {
                        let movie = try self.decoder.decode(MovieResult.self, from: value)
                        completion(.success(movie.results))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                completion (.failure(error))
            }
        }
    }
    
    func getReviews(query: Int, completion: @escaping (Result<[Review], Error>)->  Void ) {
        AF.request("https://api.themoviedb.org/3/movie/\(query)/reviews?api_key=\(API_KEY)", method: .get).response { response in
            switch response.result {
            case .success(let value):
                guard let value = value else {return}
                do {
                    let reviews = try self.decoder.decode(ReviewResult.self, from: value)
                    completion(.success(reviews.results!))
                    print( reviews)// Rezolva asta
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGenre(completion: @escaping (Result<[NameGenre],Error>)-> Void) {
        AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=\(API_KEY)").response { response in
            switch response.result {
            case .success(let values):
                if let values = values {
                    let movies = try? self.decoder.decode(Genre.self, from: values)
                    if let movies = movies {
                        completion(.success(movies.genres))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
}



