//
//  ReviewsCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 15.07.2022.
//

import UIKit

class ReviewsCell: UICollectionViewCell {
    
    @IBOutlet weak var writeReview: UIButton!
    
  
    override func layoutSubviews() {
        setupButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setupButton(){
        writeReview.layer.cornerRadius = 8
    }
    
    @IBAction func writeReviewAction(_ sender: Any) {
        
    }
    
}
