//
//  MovieService.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import Alamofire
import AlamofireImage

final class MovieService {
    
    private let urlDefault = "https://api.themoviedb.org/3/"
    private let urlImage = "https://image.tmdb.org/t/p/"
    
    func getMoviesInTheaters(currentPage: Int = 1) -> DataRequest {
        let url = "movie/now_playing"
        return  AF.request("\(urlDefault)\(url)?api_key=\(getKey())&language=en-US&page=\(currentPage)", method: .get)
    }
    
    func getMovieBy(id: Int) -> DataRequest{
        let movieId = "movie/\(id)"
        return AF.request("\(urlDefault)\(movieId)?api_key=\(getKey())&language=en-US", method: .get)
    }
    
    func search(by title: String) -> DataRequest {
        let title = "search/movie?api_key=\(getKey())&language=en-US&query=\(title)&page=1&include_adult=false"
        return AF.request("\(urlDefault)\(title)", method: .get)
    }
    
    func getImage(from url: String, width: Int) -> DataRequest {
        
        let url = "\(urlImage)/w\(width)/\(url)"
        
        return AF.request(url)
    }
    
    func getTrailler(id: Int) -> DataRequest {
        let movieId = "movie/\(id)/videos"
        return AF.request("\(urlDefault)\(movieId)?api_key=\(getKey())&language=en-US", method: .get)
    }
    
    private func getKey() -> String {
        guard let key = Bundle.main.infoDictionary?["KeyApi"] as? String else {
            fatalError("Could not find KeyApi in the info.plist")
        }

        return key
    }
    
}
