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
    
    var movie: Movie?
    private var reviews: [Review] = []
    private var sections: [MovieCellType.Section] = []
    private var typeCell: SelectedTab = .reviews
    @IBOutlet weak var writeReview: UIButton!
    
    
    @IBOutlet private weak var tableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        generateAllSection()
//        setSuperViews()
        getReviews(movieId: movie?.id)
        generateImageHeader()
        setButton()
    }
    
    //MARK: - Register cell
    
    private func registerCell() {
        tableView.register(UINib(nibName: "MovieCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCartTableViewCell")
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.register(UINib(nibName: "NoReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NoReviewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    
    }
    
    private func setButton() {
        writeReview.layer.cornerRadius = 8
    }
    
    //MARK: - Generate cell
    
    private func generateImageHeader() {
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 350))
        if let movie = movie {
            headerView.setImage(UrlPhoto: "\(IMAGE_URL)\(movie.posterPath)")
            self.tableView.tableHeaderView = headerView
        }
    }
    
    private func generateAboutMovieSection(movie: Movie, reviews: [Review]) -> MovieCellType.Section  {
        
        var aboutMovieCells: [MovieCellType.CellType] = [.header(model: movie)]
        
        switch typeCell {
        case .description:
            aboutMovieCells.append(.description(movie.overview))
            
        case .reviews:
            if reviews.count > 0 {
                reviews.forEach({ review in
                    aboutMovieCells.append(.review(model: review))
                })
            } else {
                aboutMovieCells.append(.noReviews)
            }
        }
        return MovieCellType.Section(type: .aboutMovie, cell: aboutMovieCells)
    }
    
    private func generateAllSection() {
        guard let movie = movie else {
            return
        }
        let aboutMovie = generateAboutMovieSection(movie: movie, reviews: reviews)
        
        var newSection: [MovieCellType.Section] = []
        newSection.append(aboutMovie)
        sections = newSection
        self.tableView.reloadData()
    }

    private func getReviews(movieId: Int?) {
        guard let id = movieId else {
            return
        }
        Request.shared.getReviews(query: id) { result in
            switch result {
            case .success(let reviews):
                self.reviews = reviews
                self.generateAllSection()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - Action
    
    @IBAction func writeReviews(_ sender: Any) {
        
        let viewController = UIStoryboard(name: "WriteReviews", bundle: nil).instantiateViewController(withIdentifier: "WriteReviews") as? WriteReviews
        if let viewController = viewController {
            viewController.movieReview = movie
            navigationController?.pushViewController(viewController, animated: true)

        }
    }
    
    @IBAction private func popToBack(_ sender: AnyObject? = nil) {
           if let navigation = self.navigationController, navigation.children.count > 1 {
               navigation.popViewController(animated: true)
           } else {
               self.dismiss(animated: true, completion: nil)
           }
       }
    
    
}
//MARK: - Extension


extension MovieViewController: UITableViewDelegate,  UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cell.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = sections[indexPath.section].cell[indexPath.row]
        switch cellType {

            
        case .header(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCartTableViewCell", for: indexPath) as! MovieCartTableViewCell
            cell.setup(model: model, review: reviews, type: typeCell)
            
            cell.onTapReview = { [weak self] in
                self?.typeCell = .reviews
                self!.writeReview.isHidden = false

                self?.generateAllSection()
            }
            
            cell.onTapDescription = { [weak self] in
                self?.typeCell = .description
                self!.writeReview.isHidden = true
                self?.generateAllSection()
            }
            
            return cell
            
        case .description(let overview):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            cell.isUserInteractionEnabled = false
            cell.setup(overview: overview)
            return cell
            
        case .noReviews:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoReviewsTableViewCell", for: indexPath) as! NoReviewsTableViewCell
         
            return cell
            
            
        case .review(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
            
            cell.setup(model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = sections[indexPath.section].cell[indexPath.row]
        switch cellType {
        case .header:
            return CGFloat(180)
        case .noReviews:
            return CGFloat(200)
     
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = sections[indexPath.section].cell[indexPath.row]
        switch cellType {
    
        case .noReviews:
            return CGFloat(200)
        default:
            return UITableView.automaticDimension
        }
    }
}

extension MovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let headerView = self.tableView.tableHeaderView as! StretchyTableHeaderView
            headerView.scrollViewDidScroll(scrollView: scrollView)
        }
}
