//
//  SlidePhotoMoviesCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

class SlidePhotoMoviesCell: UICollectionViewCell {
    
    var imageSimilarMovies: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(widht: 80, height: 100)
        iv.backgroundColor = .aisdigital
        iv.image = UIImage(named: "notimage")
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
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.numberOfLines = 4
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(imageSimilarMovies)
        imageSimilarMovies.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [titleMovie, overviewMovie])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: imageSimilarMovies.topAnchor, left: imageSimilarMovies.rightAnchor, bottom: imageSimilarMovies.bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
