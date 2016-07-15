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
    
    weak var delegate: MovieDelegate?
    
    var movies: [Movie] {
        
        didSet {
            
            self.delegate?.moviesUpdated(movies)
            
        }
        
    }
    
    // MARK: - Initializer(s)
    
    init() {
    
        self.movies = []
    
    }
    
    func getMovies(name: String, completion: ((movies: [Movie]?) -> Void)? = nil) {
        
//        print("Searching for movies with \"\(name)\" in the title")
        
        guard let unwrappedURL = MovieController.getMoviesURL else { return }
        
        let urlParameters = ["api_key": "39b3b8ccedabe0c9373ba3b32a814d13", "query": name]
        
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
//            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            
//            print("responseDataString = \(responseDataString)")
            
            guard let data = data
            , dictionaryArray = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
            else {
                
                print("Error accesing the data")
                
                if let completion = completion {
                    
                    completion(movies: [])
                }
                
                return
            }
            
//            print("data = \(data)")
            
//            print("dictionaryArray = \(dictionaryArray)")

            guard let resultsArray = dictionaryArray[self.kResultsArray] as? [[String : AnyObject]]
            else {
            
                print("Error accessing the results array")
                
                if let completion = completion {
                    
                    completion(movies: [])
                    
                }
                
                return
            
            }
            
//            print("resultsArray:")
//            print("\(resultsArray)\n")
            
            var moviesResultsArray: [Movie] = []
            
            print("Movie details:")
            
            for movieDictionary in resultsArray {
                
                guard let title = movieDictionary[self.kTitle] as? String
                    , rating = movieDictionary[self.kRating] as? Double
                    , summary = movieDictionary[self.kSummary] as? String
//                    , posterImage = movieDictionary[self.kPosterImage] as? String
                else { return }
                
//                print("\ttitle = \(title), rating = \(rating)")
//                print("\tsummary = \(summary)\n")
                
                let movie = Movie(title: title, rating: rating, summary: summary)
                
//                print("movie = \(movie.descriptionString)")
                
                moviesResultsArray.append(movie)
                
            }
            
//            print("\nmoviesResultsArray = \(moviesResultsArray)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
//                print("Back on the main thread")
                
                self.movies = moviesResultsArray
                
//                print("self.movies:")
//                
//                for movie in self.movies {
//                    
//                    print("\t\(movie.descriptionString)")
//                    
//                }
                
                if let completion = completion {
                    
                    completion(movies: moviesResultsArray)
                    
                }
                
                return
            })
            
        }
        
    }
    
}

protocol MovieDelegate: class {
    
    func moviesUpdated(movies: [Movie])
    
}