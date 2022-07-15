//
//  DescriptionCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 15.07.2022.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    

    @IBOutlet weak var descriptionText: UITextView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     func setup (model: Results?) {
        descriptionText.text = model?.overview
    }

    
    
    
}
