//
//  MovieCellViewModel.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import Foundation
import Alamofire
import AlamofireImage

class MovieCellViewModel {
    
    let title: String?
    let releaseDate: String?
    var model: Movie
    private let service = MovieService()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    init(model: Movie) {
        self.title = model.title

        if let date = formatter.date(from: model.releaseDate) {
            self.releaseDate = formatter.string(from: date)
        } else {
            self.releaseDate = model.releaseDate
        }

        self.model = model
    }

    func configure(completion: @escaping (_ image: UIImage) -> Void) {
        guard let url = model.posterPath else {
            completion(UIImage(imageLiteralResourceName: "no-image"))
            return
        }
        
        service.getImage(from: url, width: 200).responseData { (response) in
            if response.error == nil {
          
                if let data = response.data {
                    let image = UIImage(data: data)!
                    completion(image)
                }
            }
        }
    }
}
