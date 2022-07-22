//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    
    @IBOutlet weak var imageOnCell: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var voteAverageMovie: UILabel!
    @IBOutlet weak var yersMovie: UILabel!
    @IBOutlet weak var typeMovie: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sertImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sertImage()
        genres.text = ""

    }
//
//    func setGen(modeGen: [NameGenre], modelMovie: [Int]) -> [String] {
//        var genres: [String] = []
//        for id in modelMovie {
//            genres.append(modeGen.first(where: { $0.id == id})?.name ?? "")
//        }
//        return genres
//    }
//
    
     func sertImage() {
        imageOnCell.layer.cornerRadius = 8
        imageOnCell.layer.borderColor = UIColor.red.cgColor
    }
    
    func setup(model: Movie, genres: [NameGenre]) {
        titleMovie.text = model.title
        voteAverageMovie.text = "\(model.voteAverage)"
        yersMovie.text = model.releaseDate
        imageOnCell.setImage(with: "\(IMAGE_URL)\(model.posterPath)")
    
        for id in model.genreIds {
            self.genres.text?.append("\(genres.first(where: { $0.id == id})?.name ?? "") ")
        }
        
    }
   
}
