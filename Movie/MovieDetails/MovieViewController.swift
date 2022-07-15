//
//  MovieViewController.swift
//  Movie
//
//  Created by Andrei Mosneag on 15.07.2022.
//

import UIKit

enum TypeCell {
    case description
    case reviews
}

class MovieViewController: UIViewController {
    
    var movie: Results?
    var typeCell: TypeCell = .description
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var averageScoreMovie: UILabel!
    @IBOutlet weak var yearsMovie: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCell()

    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellWithReuseIdentifier: "DescriptionCell")
        collectionView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellWithReuseIdentifier: "ReviewsCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    
    private func setup() {
        guard let movie = movie else {
            return
        }
        titleMovie.text = movie.title
        averageScoreMovie.text = "\(movie.voteAverage)"
        yearsMovie.text = movie.releaseDate
        imageMovie.setImage(with: "\(IMAGE_URL)\(movie.posterPath)")
        
    }
    @IBAction func descriptionAction(_ sender: Any) {
        self.typeCell = .description
        collectionView.reloadData()

    }
    @IBAction func reviewAction(_ sender: Any) {
        self.typeCell = .reviews
        collectionView.reloadData()
    }
}
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.typeCell {
        case .description:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.setup(model: movie)
            return cell
        case .reviews:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewsCell", for: indexPath) as! ReviewsCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
}
