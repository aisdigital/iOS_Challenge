//
//  MovieService.swift
//  TheMovie
//
//  Created by Marcos Jr on 13/06/21.
//

import Alamofire

final class MovieService {

    private let url = "https://api.themoviedb.org/3/"
    private let urlImage = "https://image.tmdb.org/t/p/"
    
    func search(by text: String, completion: @escaping ([Movie]) -> Void) {
        
        let text = "search/movie?api_key=\(getKey())&language=en-US&query=\(text)&page=1&include_adult=false"
        AF.request("\(url)\(text)", method: .get).responseDecodable(of: CollectionData<Movie>.self) { response in
            
            switch response.result {

            case let .success(result):
                DispatchQueue.main.async {
                    completion(result.results)
                }

            case .failure(_):
                DispatchQueue.main.async {
                    completion([Movie]())
                }
            }
        }
    }
    
    func getMovieBy(id: Int) -> DataRequest{
         let movieId = "movie/\(id)"
         return AF.request("\(url)\(movieId)?api_key=\(getKey())&language=en-US", method: .get)
     }

    func getImage(from url: String, width: Int) -> DataRequest {

        let url = "\(urlImage)/w\(width)/\(url)" 

        return AF.request(url)
    }

    func getTrailler(id: Int) -> DataRequest {
        let movieId = "movie/\(id)/videos"
        return AF.request("\(url)\(movieId)?api_key=\(getKey())&language=en-US", method: .get)
    }

    private func getKey() -> String {
        guard let key = Bundle.main.infoDictionary?["KeyApi"] as? String else {
            fatalError("Could not find KeyApi in the info.plist")
        }
        return key
    }
}


