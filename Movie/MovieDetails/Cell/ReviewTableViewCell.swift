//
//  ReviewTableViewCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 18.07.2022.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var averageStar: UILabel!
    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var nameUsername: UILabel!
    @IBOutlet weak var dateYears: UILabel!
    @IBOutlet weak var textReview: UILabel!
    @IBOutlet weak var noReviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
    }

    
    func setData(dataAPI: String)-> String {
        let data = "\(dataAPI.prefix(10))"
        return data

    }
    
     func noReviews(reviews:[Review]) {
         if reviews.isEmpty {
            noReviews.isHidden = false
        }
    }
    
    
    
    
    func setup(model: Review) {
        guard let models = model.authorDetails?.rating else{return}
        averageStar.text = String(models)
        reviewName.text = model.author
        nameUsername.text = model.authorDetails?.username
        dateYears.text = setData(dataAPI: model.createdAt)
        textReview.text = model.content
    }
    
}
