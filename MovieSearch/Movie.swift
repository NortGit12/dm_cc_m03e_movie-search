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
    var posterImage: UIImage
    
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
    
    init?(dictionary: [String : AnyObject]) {
        
        guard let title = dictionary[kTitle] as? String
            , rating = dictionary[kRating] as? Double
            , summary = dictionary[kSummary] as? String
            , posterImageURLFragment = dictionary[kPosterImage] as? String
        else { return nil }
        
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterImage = UIImage()
        
        ImageController.getImage(posterImageURLFragment) { (imageData) in
            
            if let imageData = imageData {
                
                self.posterImage = UIImage(data: imageData)!
                
            }
        }
    }
    
}