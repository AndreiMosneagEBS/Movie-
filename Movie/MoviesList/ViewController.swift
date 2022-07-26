//
//  ViewController.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var movies: [Movie] = []
    private var genres: [NameGenre] = []
    var page: Int = 1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        registerCell()
        setSuperViews()
        getGenre()

    }
    
    private func registerCell() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    //MARK: - Requests
    
    private func getMovies() {
        Request.shared.fetchMovies(page: page) { result  in
            self.page += 1
            switch result {
            case .success(let movies):
                self.movies.append(contentsOf: movies)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func search(input: String) {
        Request.shared.searchMovies(query: input) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getGenre() {
        Request.shared.getGenre {result in
            switch result {
            case .success(let genres):
                self.genres = genres
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setSuperViews(){
        tableView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = .clear
//        tableView.showsVerticalScrollIndicator = false

    }
    
    private func createSpinnerFooter()-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.setup(model: movies[indexPath.row], genres: genres)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let id = movies[indexPath.row]
        let viewController = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController
        if let viewController = viewController {
            viewController.movie = movies[indexPath.row]
            viewController.gen = genres
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty {
            getMovies()
            searchBar.showsCancelButton = false
        }else {
            let input = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
            self.search(input: input)
        }
        return true
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }
}

extension ViewController :  UIScrollViewDelegate {     // Modificat
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            guard !Request.shared.isPagination else {
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
            Request.shared.fetchMovies(pagination: true ,page:page) { result  in
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                self.getMovies()
            }
        }
    }

}
