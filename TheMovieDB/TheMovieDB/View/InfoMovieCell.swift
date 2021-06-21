//
//  InfoMovieCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

class InfoMovieCell: UICollectionViewCell {
    
    //MARK: - Properties
    var nameMovieLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .bold)
        label.text = "Not-Label"
        label.setDimension(widht: 320, height: 44)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        let systemImage = UIImage(systemName: "heart")
        button.setImage(systemImage, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    private let heartIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(widht: 20, height: 20)
        iv.tintColor = .white
        iv.image = UIImage(systemName: "heart.fill")
        return iv
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
        label.text = "1.2k Likes"
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let popularityIcon: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(widht: 20, height: 20)
        iv.tintColor = .white
        iv.image = UIImage(systemName: "globe")
        return iv
    }()
    
    var popularityLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
        label.text = "Popularity:"
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    var flag: Bool = false
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [nameMovieLabel, heartButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        let stackLikes = UIStackView(arrangedSubviews: [heartIcon,likesLabel])
        stackLikes.axis = .horizontal
        stackLikes.distribution = .fillProportionally
        stackLikes.spacing = 4
        
        let stackPopularity = UIStackView(arrangedSubviews: [popularityIcon, popularityLabel])
        stackPopularity.axis = .horizontal
        stackPopularity.distribution = .fillProportionally
        stackPopularity.spacing = 4
        
        let stackMoreInfo = UIStackView(arrangedSubviews: [stackLikes, stackPopularity])
        stackMoreInfo.axis = .horizontal
        stackMoreInfo.distribution = .fillProportionally
        stackMoreInfo.spacing = 4
        
        let stackMain = UIStackView(arrangedSubviews: [stack, stackMoreInfo])
        stackMain.axis = .vertical
        stackMain.spacing = 8
        
        addSubview(stackMain)
        
        stackMain.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleLike() {
        var systemImage = UIImage()
        
        flag = !flag
        
        if flag {
            systemImage = UIImage(systemName: "heart.fill")!
        } else {
            systemImage = UIImage(systemName: "heart")!
        }
        heartButton.setImage(systemImage, for: .normal)
    }
    
    //MARK: - Helpers
}


