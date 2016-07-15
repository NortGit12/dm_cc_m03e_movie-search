//
//  Movie.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class Movie {
    
    // MARK: - Stored Properties
    
    let title: String
    let rating: Double
    let summary: String
    let posterImage: UIImage?
    
    private let kTitle = "title"
    private let kRating = "vote_average"
    private let kSummary = "overview"
    private let kPosterImage = "poster_path"
    
    var descriptionString: String {
        
        return "\(kTitle) = \(title), \(kRating) = \(rating), \(kSummary) = \(summary), \(kPosterImage) = \(posterImage)"
        
    }
    
    var dictionaryData: [String : AnyObject] {
        
        return [kTitle: title, kRating: rating, kSummary: summary, kPosterImage: posterImage ?? ""]
        
    }
    
    var jsonData: NSData? {
        
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryData, options: .PrettyPrinted)
        
    }
    
    // MARK: - Initializer(s)
    
    init(title: String, rating: Double, summary: String, posterImage: UIImage? = nil) {
        
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterImage = posterImage
        
    }
    
    init?(identifier: String, dictionary: [String : AnyObject]) {
        
        guard let title = dictionary[kTitle] as? String
            , rating = dictionary[kRating] as? Double
            , summary = dictionary[kSummary] as? String
            , posterImage = dictionary[kPosterImage] as? UIImage
        else { return nil }
        
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterImage = posterImage
        
    }
    
}