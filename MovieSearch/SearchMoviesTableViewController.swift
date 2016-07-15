//
//  SearchMoviesTableViewController.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SearchMoviesTableViewController: UITableViewController, MovieDelegate, UISearchBarDelegate {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieController = MovieController()
    
    var movies: [Movie] = []
    
    // MARK: - General

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie = Movie(title: "Tremors", rating: 4.2, summary: "Blah", posterImage: "")
        
        self.movies.append(movie)
        
        movieController.delegate = self
        searchBar.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        movieController.getMovies("Star Wars")
        
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
    
    // MARK: - MovieDelegate
    
    func moviesUpdated(movies: [Movie]) {
        
        self.movies = movies
        
    }
    
    // MARK: - Action(s)
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchText = searchBar.text where searchText.characters.count > 0 else { return }
        
        movieController.getMovies(searchText)
        
        tableView.reloadData()
        
    }

}
