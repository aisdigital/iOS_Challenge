//
//  MovieTableViewCell.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var tittleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    func configure(viewModel: MovieCellViewModel) {
        
        self.tittleLabel.text = viewModel.title
        self.releaseDateLabel.text = viewModel.releaseDate
        
        viewModel.configureImage { image in
            self.movieImageView.image = image
        }
        
    }
    
}
