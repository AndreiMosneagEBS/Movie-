//
//  MovieCartTableViewCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 18.07.2022.
//

import UIKit

enum SelectedTab {
    case description
    case reviews
}

class BaseTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}


class MovieCartTableViewCell: BaseTableViewCell {
    
    var typeCell: SelectedTab = .description
    var onTapDescription: (() -> Void)?
    var onTapReview: (() -> Void)?
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var averageStar: UILabel!
    @IBOutlet weak var years: UILabel!
    @IBOutlet weak var typeOfMovie: UILabel!
    @IBOutlet weak var descriptionButtonOutlet: UIButton!
    @IBOutlet private weak var reviewsButtonOutlet: UIButton!
    @IBOutlet weak var genres: UILabel!
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionButtonOutlet.roundCorners([.topLeft, .topRight], radius: 8)
        reviewsButtonOutlet.roundCorners([.topLeft, .topRight], radius: 8)
    }
    
   

    
    
    func setup(model: Movie, review: [Review], type: SelectedTab, genres: [NameGenre]){
        titleMovie.text = model.title
        averageStar.text = String(model.voteAverage)
        years.text = model.releaseDate
        reviewsButtonOutlet.setTitle("Reviews (\(review.count))", for: .normal)
        for id in model.genreIds {
            self.genres.text?.append("\(genres.first(where: { $0.id == id})?.name ?? "") ")
        }
        
        switch type {
        case .reviews:
            markSelected(button: reviewsButtonOutlet)
            markDeselected(button: descriptionButtonOutlet)
            
        case .description:
            markSelected(button: descriptionButtonOutlet)
            markDeselected(button: reviewsButtonOutlet)
        }
    }
    
    @IBAction func descriptionActionButton(_ sender: Any) {
        markSelected(button: descriptionButtonOutlet)
        markDeselected(button: reviewsButtonOutlet)
        
        onTapDescription?()
    }
    
    @IBAction func reviewsActionButton(_ sender: Any) {
        
        markSelected(button: reviewsButtonOutlet)
        markDeselected(button: descriptionButtonOutlet)
        
        onTapReview?()
    }
    
    func markSelected(button: UIButton) {
        button.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.2, alpha: 1.0)
        button.tintColor = .white
    }
    
    func markDeselected(button: UIButton) {
        button.tintColor = UIColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        button.backgroundColor = .clear
    }
}
