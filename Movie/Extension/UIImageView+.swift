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

extension UIButton {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
