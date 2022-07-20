//
//  DescriptionTableViewCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 18.07.2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

//    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var descriptionText: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(overview: String) {
        descriptionText.text = overview
    }
    
    
}
