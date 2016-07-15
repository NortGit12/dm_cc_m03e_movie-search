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
    
    let identifier: NSUUID
    let title: String
    let rating: Double
    let summary: String
    let posterImage: UIImage?
    
    private let kIdentifier = "identifier"
    private let kTitle = "title"
    private let kRating = "rating"
    private let kSummary = "summary"
    private let kPosterImage = "posterImage"
    
    var descriptionString: String {
        
        return "\(kIdentifier) = \(identifier), \(kTitle) = \(title), \(kRating) = \(rating), \(kSummary) = \(summary), \(kPosterImage) = \(posterImage)"
        
    }
    
    var dictionaryData: [String : AnyObject] {
        
        return [kTitle: title, kRating: rating, kSummary: summary, kPosterImage: posterImage ?? ""]
        
    }
    
    var jsonData: NSData? {
        
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryData, options: .PrettyPrinted)
        
    }
    
    // MARK: - Initializer(s)
    
    init(title: String, rating: Double, summary: String, posterImage: UIImage? = nil) {
        
        self.identifier = NSUUID()
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterImage = posterImage
        
    }
    
    init?(identifier: String, dictionary: [String : AnyObject]) {
        
        guard let identifier = NSUUID(UUIDString: identifier)
            , title = dictionary[kTitle] as? String
            , rating = dictionary[kRating] as? Double
            , summary = dictionary[kSummary] as? String
            , posterImage = dictionary[kPosterImage] as? UIImage
        else { return nil }
        
        self.identifier = identifier
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterImage = posterImage
        
    }
    
}