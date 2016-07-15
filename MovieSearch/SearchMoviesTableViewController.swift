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
        
        let movie = Movie(title: "Tremors", rating: 4.2, summary: "Blah")
        
        self.movies.append(movie)
        
        movieController.delegate = self
        searchBar.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        print("\nViewController - movies (before)")
        print("\(movieController.movies)")
        
        movieController.getMovies("Star Wars")
        
        print("\nViewController - movies (after)")
        print("\(movieController.movies)")
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movies.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("\nInside SearchMoviesTableViewController.cellForRowAtIndexPath(...)")
    
        guard let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? MovieTableViewCell else {
            
            return UITableViewCell()
            
        }

        let movie = self.movies[indexPath.row]
        
        cell.updateWithMovie(movie)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - MovieDelegate
    
    func moviesUpdated(movies: [Movie]) {
        
        self.movies = movies
        
    }
    
    // MARK: - Action(s)
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 0 {
            
            movieController.getMovies(searchText)
            
            tableView.reloadData()
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
