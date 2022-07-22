//
//  WriteRewiews.swift
//  Movie
//
//  Created by Andrei Mosneag on 20.07.2022.
//

import UIKit
import Cosmos
import TinyConstraints
import SwiftUI



class WriteReviews: UIViewController {

    var movieReview: Movie?
    let colorClick: UIColor = UIColor(red: 0.38, green: 0.43, blue: 0.87, alpha: 1.0)
    let colorNotClick:  UIColor = UIColor(red: 0.38, green: 0.43, blue: 0.87, alpha: 0.5)
    
    
    @IBOutlet weak var scrolViews: UIScrollView!
    @IBOutlet private var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textTitle: UITextField!
    @IBOutlet private weak var textReview: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var backButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStar()
        showKeyboard()
        setup ()
        setupButton()
        self.hideKeyboardWhenTappedAround()
        textTitle.delegate = self
        textReview.delegate = self
    }
    
    private func setup () {
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
    
    private func setupButton(){
        submitButton.layer.cornerRadius = 8
        backButtonOutlet.tintColor = UIColor(red: 0.38, green: 0.43, blue: 0.87, alpha: 1.0)
        scrolViews.showsVerticalScrollIndicator = false
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
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if submitButton.backgroundColor == colorClick {
            let alert = UIAlertController(title: "Review",
                                          message: "Your review is sent ",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { [self](action) in
                popToBack()
            }))
            self.present(alert, animated: true)
        }
        
    }
  
}
extension WriteReviews: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
      
        if !text.isEmpty  {
            submitButton.backgroundColor = colorClick
        } else {
            submitButton.backgroundColor = colorNotClick

        }
        return true
    }
}


