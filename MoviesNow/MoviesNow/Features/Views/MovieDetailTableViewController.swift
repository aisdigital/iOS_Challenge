//
//  UserDetailTableViewController.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 05/06/21.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MovieDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageVew: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UITextView!
    @IBOutlet weak var playerView: WKYTPlayerView!
    
    var movieId: Int?
    private var detailViewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        detailViewModel = MovieDetailViewModel()
        self.posterImageVew.image = #imageLiteral(resourceName: "no-image-available")
        
        
        if let id = movieId {
            detailViewModel.getMovie(id: id) { data, model in
                self.movieTitleLabel.text = data.title
                
                self.releaseDateLabel.text = data.releaseDate
                self.runningTimeLabel.text = data.runingTime
                self.genreLabel.text = data.genreConcat
                self.synopsisLabel.text = data.overview
                
                if let imgUrl = model.posterPath {
                    self.detailViewModel.getImage(by: imgUrl) { image in
                        self.posterImageVew.image = image
                    }
                }
                
                self.detailViewModel.getTrailler(idMovie: model.id) { idTrailler in
                    if !idTrailler.isEmpty {
                        self.playerView.load(withVideoId: idTrailler)
                    }
                }
            }
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        playerView.stopVideo()
    }
    
}

extension MovieDetailTableViewController: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.stopVideo()
    }
}
