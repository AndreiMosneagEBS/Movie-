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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sertImage()

        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sertImage()

    }
    
    
     func sertImage() {
        imageOnCell.layer.cornerRadius = 8
//         imageOnCell.layer.borderWidth = 1
//         imageOnCell.layer.borderColor = UIColor.red.cgColor
    }
    
    func setup(model: Results) {
        titleMovie.text = model.title
        voteAverageMovie.text = String(model.voteAverage)
        yersMovie.text = model.releaseDate
        imageOnCell.setImage(with: "https://image.tmdb.org/t/p/w500/\(model.posterPath)")
    }
   
}
