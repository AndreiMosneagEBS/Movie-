//
//  ViewController.swift
//  Movie
//
//  Created by Andrei Mosneag on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {

    private var movies: [Results] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        registerCell()
    }

    private func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    private func getMovies() {
        Request.shared.fetchMovies { result  in
            switch result {
            case .success(let values):
                guard let values = values else {return}
                Request.shared.getMovies(data: values) { movies in
                    self.movies = movies
                    self.tableView.reloadData()
                }
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
    
}
