//
//  MovieController.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieController {
    
    // MARK: - Stored Properties
    
    static let baseURL = "http://api.themoviedb.org/3/search/movie"
    
    static let getMoviesURL = NSURL(string: baseURL)
    
    private let kResultsArray = "results"
    
    private let kIdentifier = "identifier"
    private let kTitle = "title"
    private let kRating = "vote_average"
    private let kSummary = "overview"
    private let kPosterImage = "poster_path"
    
    var movies: [Movie] = []
    
    // MARK: - Initializer(s)
    
    init() {
    
        self.movies = []
    }
    
    func getMovies(name: String, completion: ((movies: [Movie]?) -> Void)? = nil) {
        
        guard let unwrappedURL = MovieController.getMoviesURL else { return }
        
        let urlParameters = ["api_key": "39b3b8ccedabe0c9373ba3b32a814d13", "query": name]
        
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            guard let data = data
            , dictionaryArray = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
            else {
                
                print("Error accesing the data")
                
                if let completion = completion {
                    
                    completion(movies: [])
                }
                
                return
            }
            
            guard let resultsArray = dictionaryArray[self.kResultsArray] as? [[String : AnyObject]]
            else {
            
                print("Error accessing the results array")
                
                if let completion = completion {
                    
                    completion(movies: [])
                }
                
                return
            }
            
            var moviesResultsArray: [Movie] = []
            
            for movieDictionary in resultsArray {
                
                guard let movie = Movie(dictionary: movieDictionary) else { break }
                
                moviesResultsArray.append(movie)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.movies = moviesResultsArray
                
                if let completion = completion {
                    
                    completion(movies: moviesResultsArray)
                }
            })
        }
    }
    
}