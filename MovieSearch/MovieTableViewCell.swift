//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Jeff Norton on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    
    func updateWithMovie(movie: Movie) {
        
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        summaryLabel.text = movie.summary

        let imageURL = NSURL(string: movie.posterImage)
        let imageData = NSData(contentsOfURL:imageURL!)
        if imageData != nil {
            postImageView.image = UIImage(data:imageData!)
        }
        
    }

}
