//
//  WriteRewiews.swift
//  Movie
//
//  Created by Andrei Mosneag on 20.07.2022.
//

import UIKit
import Cosmos
import TinyConstraints



class WriteReviews: UIViewController {

    var movieReview: Movie?
    
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStar()
        showKeyboard()
        self.hideKeyboardWhenTappedAround()
        setup ()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    private func setup () {
        print(movieReview)
        guard let movie = movieReview else {
            return
        }
        imageView.setImage(with: "\(IMAGE_URL)\(movie.posterPath)")
        movieTitle.text = movie.title
    }
    
    
    private func setStar() {
        cosmosView.settings.filledImage = UIImage(named: "Star")?.withRenderingMode(.alwaysOriginal)
        cosmosView.settings.emptyImage = UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal)
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 22
        cosmosView.settings.fillMode = .half
        cosmosView.rating = 0
    }
    
    // MARK: - Show keyboard
    
    private func showKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    deinit {  NotificationCenter.default.removeObserver(self) }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.keyboardHeightLayoutConstraint?.constant = 0.0
        } else {
            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
        }
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    @IBAction private func popToBack(_ sender: AnyObject? = nil) {
           if let navigation = self.navigationController, navigation.children.count > 1 {
               navigation.popViewController(animated: true)
           } else {
               self.dismiss(animated: true, completion: nil)
           }
       }
    
    
}
