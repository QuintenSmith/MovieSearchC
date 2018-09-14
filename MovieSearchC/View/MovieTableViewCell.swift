//
//  MovieTableViewCell.swift
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var movie: Movie?{
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        guard let movie = movie else { return }
        guard let rating = movie.rating else {return}
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(rating)"
        summaryLabel.text = movie.summary
    }

}
