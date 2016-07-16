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
    
    static func getImage(imageURLFragment: String, completion: ((imageData: NSData?) -> Void)? = nil) {
        
        guard let completeImageURL = NSURL(string: ImageController.baseImageURLString + imageURLFragment) else {
            
            print("Error trying to build the complete image URL")
            
            if let completion = completion {
                
                completion(imageData: nil)
                
            }
            
            return
        }
        
        let urlParameters = ["api_key": "39b3b8ccedabe0c9373ba3b32a814d13"]
        
        NetworkController.performRequestForURL(completeImageURL, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            print("I'm here")
            
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            
            print("responseDataString (attempting to get image) = \(responseDataString)")
            
            guard let data = data where error != nil else {
                
                if let completion = completion {
                    
                    completion(imageData: nil)
                    
                }
                
                return
                
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                print("Acquired image URL")
                
                if let completion = completion {
                
                    completion(imageData: data)
                    
                }
                
            })
            
        }
        
    }
    
}