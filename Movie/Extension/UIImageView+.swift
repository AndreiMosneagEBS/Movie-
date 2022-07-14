//
//  UIImageView+.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String, displayPlaceholder: Bool = false) {
        let placeholderImage = UIImage(systemName: "nosign")?.withTintColor(.gray)
        if displayPlaceholder {
            self.image = placeholderImage
        }
        guard let url = URL.init(string: urlString) else {
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholderImage)
    }

}
