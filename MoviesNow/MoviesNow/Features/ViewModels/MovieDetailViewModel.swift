//
//  MovieDetailViewModel.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 05/06/21.
//

import UIKit

final class MovieDetailViewModel {
    
    var title: String?
    var releaseDate: String?
    var runingTime: String?
    var genreConcat: String?
    var overview: String?
    
    private let service = MovieService()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    func getMovie(id: Int, completion: @escaping(_ model: MovieDetailViewModel, _ detail: DetailMovie) -> Void) {
        let request = service.getMovieBy(id: id)
        
        request.responseDecodable(of: DetailMovie.self) { response in
            switch response.result {
            case let .success(result):
                self.configure(model: result)
                completion(self, result)
                
            case .failure(_):
                fatalError("Miss movie Identifier")
            }
            
        }
    }
    
    func getImage(by name: String,completion: @escaping (_ image: UIImage) -> Void) {
        
        let request = service.getImage(from: name, width: 200)
        
        request.responseImage { response in
            
            switch response.result {
            case let .success(result):
                completion(result)
                
            case .failure(_):
                completion(#imageLiteral(resourceName: "no-image-available"))
            }
        }
    }
    
    func getTrailler(idMovie: Int, completion: @escaping (_ idTrailler: String) -> Void) {
        let request = service.getTrailler(id: idMovie)
        
        request.responseDecodable(of: Traillers.self) { response in
            switch response.result {
            case let .success(result):
                if !result.results.isEmpty {
                    completion(self.isValidIdTrailler(trailler: result.results[0]))
                }
                
            case .failure(_):
                completion("")
            }
        }
    }
    
    
    private func configure(model: DetailMovie) {
        
        title = model.title
        runingTime = "\(model.runingTime) minutes"
        overview = model.overview
        
        if let date = formatter.date(from: model.releaseDate) {
            releaseDate = formatter.string(from: date)
        } else {
            releaseDate = model.releaseDate
        }
        
        var genres = ""
        model.genres.forEach { genre in
            genres += "\(genre.name) "
        }
        
        self.genreConcat = genres
        
    }
    
    private func isValidIdTrailler(trailler: MovieTrailler) -> String {
        if trailler.site == "YouTube" {
            return trailler.key
        }
        return ""
    }
}
