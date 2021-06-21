//
//  VideoCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit
import YouTubePlayer

class VideoCell: UICollectionViewCell {
    //MARK: - Properties
    
    var key: String? = ""
    
    lazy var videoPlayer: YouTubePlayerView = {
        let frameForPlayer = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let view = YouTubePlayerView(frame: frame)
        
        return view
    }()

    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(videoPlayer)
        videoPlayer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 260)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            videoPlayer.loadVideoID("\(key?.description ?? "")")
    }
    
}

