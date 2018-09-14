//
//  MovieTableViewController.swift
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        tableView.rowHeight = 250
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        let movie = movies?[indexPath.row]
        cell?.movie = movie
        return cell ?? UITableViewCell()
    }
    
    
}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        MovieClient.fetchMovies(forTitle: searchText) { (movies) in
            guard let movies = movies else {return}
            self.movies = movies
            for movie in movies {
                self.movies?.append(movie)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}








