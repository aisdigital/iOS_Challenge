//
//  MovieDetailViewController.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var traillerView: WKYTPlayerView!
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var overviewDetail: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel!
    var youtubeKey: String!
    
    init?(coder: NSCoder, viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a view model.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFields()
        self.viewModel.getTrailler { youtubeKey in
            self.traillerView.load(withVideoId: youtubeKey)
        }
    }
    
    func setupFields() {
        let genres = "Genres: \(viewModel.genresHelper)".dropLast(2)
        
        self.titleDetailLabel.text = viewModel.model.title
        self.overviewDetail.text = viewModel.model.overview
        self.genresLabel.text = String(genres)
        self.releaseDateLabel.text = viewModel.model.releaseDate
    }
}
