//
//  HeaderImageTableViewCell.swift
//  Movie
//
//  Created by Andrei Mosneag on 20.07.2022.
//

import UIKit

class HeaderImageTableViewCell: UITableViewCell {

//    @IBOutlet private weak var imageHeader: UIImageView!
    @IBOutlet weak var headerView: StretchyTableHeaderView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: String) {
//        imageHeader.setImage(with: "\(IMAGE_URL)\(model)")
    }
}
