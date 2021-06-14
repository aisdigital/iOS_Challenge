//
//  MovieDetailsViewModel.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import Foundation

class MovieDetailsViewModel {
    
    let service = MovieService()
    var model: MovieDetails!
    var genresHelper: String = ""
    
    init(with model: MovieDetails) {
        self.model = model
        
        model.genres.forEach { genre in
            genresHelper += "\(genre.name), "
        }
    }
    
    func getTrailler(completion: @escaping (_ idTrailler: String) -> Void) {
        let request = service.getTrailler(id: model.id)

        request.responseDecodable(of: Traillers.self) { response in
            switch response.result {
            case let .success(result):
                if !result.results.isEmpty {
                    let trailler = result.results[0]
                    if trailler.site == "YouTube" {
                        completion(trailler.key)
                    } else {
                        completion("")
                    }
                }

            case .failure(_):
                completion("")
            }
        }
    }
}
