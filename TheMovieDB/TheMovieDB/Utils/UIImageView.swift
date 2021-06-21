//
//  UIImageView.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

extension UIImageView {
    static func photoImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

