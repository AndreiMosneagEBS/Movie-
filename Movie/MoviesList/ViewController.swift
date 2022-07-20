//
//  ViewController.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var movies: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        registerCell()
    }
    
    private func registerCell() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    //MARK: - Requests
    
    private func getMovies() {
        Request.shared.fetchMovies { result  in
            switch result {
            case .success(let movies):
                self.movies = movies
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
    
    
    
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.setup(model: movies[indexPath.row])
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
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let input = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        self.search(input: input)
        tableView.reloadData()
        return true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.showsCancelButton = false
            self.search(input: "")
            return
        }
        self.search(input: searchText)
    }
}
