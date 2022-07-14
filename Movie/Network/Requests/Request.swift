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
    
    func fetchMovies(completion: @escaping (Result<Data?,Error>)-> Void) {
        
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=591c9e4cb1d729304b880495da45b414").response { response in
            switch response.result {
            case .success(let values):
                completion(.success(values))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovies(data: Data, completion: ([Results]) -> Void) {
        let decoder = JSONDecoder()
        do {
            let movies = try? decoder.decode(MovieModels.self, from: data)
            if let movies = movies {
                completion(movies.results)
            }
        } catch {
            print("error")
        }
    }
}



