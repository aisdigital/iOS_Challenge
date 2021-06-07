//
//  MovieCellViewModel.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import UIKit
import AlamofireImage

final class MovieCellViewModel {
    
    private static let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    let title: String
    let releaseDate: String
    var posterImage: UIImage?
    
    private let model: Movie
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    private let service = MovieService()
    
    init(model: Movie) {
        self.title = model.title
        
        if let date = formatter.date(from: model.releaseDate) {
            self.releaseDate = formatter.string(from: date)
        } else {
            self.releaseDate = model.releaseDate
        }
        
        self.model = model
    }
    
    func configureImage(completion: @escaping (_ image: UIImage) -> Void) {
        
        guard let imgUrl =  model.posterPath else {
            completion(#imageLiteral(resourceName: "no-image-available"))
            return
        }
        
        getImage(by: imgUrl) {
            if let image = self.loadImageFromCache(key: imgUrl) {
                completion(image)
            }
        }
        
    }
    
    private func getImage(by name: String,completion: @escaping () -> Void) {
        
        if loadImageFromCache(key: name) != nil {
            completion()
            return
        }
        
        let request = service.getImage(from: name, width: 200)
        
        request.responseImage { response in
            
            switch response.result {
            case let .success(result):
                self.addImageInCache(key: name, image: result)
                completion()
                
            case .failure(_):
                self.addImageInCache(key: name, image: #imageLiteral(resourceName: "no-image-available"))
            }
        }
    }
    
    private func addImageInCache(key: String, image: UIImage) {
        MovieCellViewModel.imageCache.add(image, withIdentifier: key)
        
    }
    
    private func loadImageFromCache(key: String) -> UIImage? {
        
        guard let image = MovieCellViewModel.imageCache.image(withIdentifier: key) else {
            return nil
        }
        
        return image
    }
    
    
}
