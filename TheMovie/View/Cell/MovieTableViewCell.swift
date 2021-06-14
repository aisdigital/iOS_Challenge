//
//  MovieTableViewCell.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieReleaseLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    
    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    func configure(with viewModel: MovieCellViewModel) {
        self.movieTitleLabel.text = viewModel.title
        self.movieReleaseLabel.text = viewModel.releaseDate
        
        viewModel.configure { image in
            self.movieImageView.image = image
        }
    }
}
