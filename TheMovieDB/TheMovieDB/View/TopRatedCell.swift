//
//  TopRatedCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

class TopRatedCell: UICollectionViewCell {
    //MARK: - Properties
    
    ///UI Image Filme
    lazy var topRatedImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(widht: 80, height: 80)
        iv.backgroundColor = .aisdigital
        iv.layer.cornerRadius = 80 / 2
        return iv
    }()
    
    ///UI Titulo Filme
    var titleMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Nome do filme..."
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    ///UI Overview Filme
    var overviewMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Descrição do filme..."
        label.numberOfLines = 2
        label.textColor = .lightGray
        return label
    }()
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(topRatedImageView)
        topRatedImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [titleMovie, overviewMovie])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: topRatedImageView.topAnchor, left: topRatedImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
}

