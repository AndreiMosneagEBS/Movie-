//
//  CellType.swift
//  Movie
//
//  Created by Andrei Mosneag on 18.07.2022.
//

import Foundation

struct MovieCellType {
    
    enum SectionType {
        case header
        case aboutMovie
    }
    
    
    enum CellType {
        case header(model: Movie)
        case description(String)
        case review(model: Review)
        case noReviews
    }
    
    struct Section {
        var type : SectionType
        var cell : [CellType]
    }
}
