//
//  SearchMoviesTableViewController.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SearchMoviesTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieController = MovieController()
    
    var movies: [Movie] = []
    
    // MARK: - General

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movies.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? MovieTableViewCell else {
            
            return UITableViewCell()
            
        }

        let movie = self.movies[indexPath.row]
        
        cell.updateWithMovie(movie)

        return cell
    }
    
    // MARK: - Action(s)
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text where searchText.characters.count > 0 else { return }
        
        movieController.getMovies(searchText) { (movies) in
         
            if let movies = movies {
                
                self.movies = movies
                self.tableView.reloadData()
                
            }
        }
    }

}
