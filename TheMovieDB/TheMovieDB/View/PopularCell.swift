//
//  PopularCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

class PopularCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    lazy var popularImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(widht: 100, height: 120)
        iv.image = UIImage(named: "notimage")
        return iv
    }()
    
    var nameMovieLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "Not-Label"
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(popularImageView)
        popularImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        popularImageView.image = UIImage(named: "notImage")
        
        addSubview(nameMovieLabel)
        nameMovieLabel.anchor(top: popularImageView.topAnchor, left: popularImageView.leftAnchor, right: popularImageView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
