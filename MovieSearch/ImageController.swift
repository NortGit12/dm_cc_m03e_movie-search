//
//  ImageController.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageController {
    
    // MARK: - Stored Properties
    
    static let baseImageURLString = "http://image.tmdb.org/t/p/w500"
    
    static let baseImageURL = NSURL(string: baseImageURLString)
    
    // MARK: - Method(s)
    
    static func getImage(imageURLFragment: String, completion: ((image: UIImage?) -> Void)) {
        
        guard let completeImageURL = NSURL(string: ImageController.baseImageURLString + imageURLFragment) else { fatalError("Image URL optional is nil") }
        
        let urlParameters = ["api_key": "39b3b8ccedabe0c9373ba3b32a814d13"]
        
        NetworkController.performRequestForURL(completeImageURL, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            
            guard let data = data else {
                
                completion(image: nil)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                completion(image: UIImage(data: data))
            })
        }
    }
    
}