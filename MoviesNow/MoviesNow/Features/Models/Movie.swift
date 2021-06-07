//
//  Movie.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import Foundation

final class Movie: Decodable {
    
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    
    init(id: Int,
         title: String,
         posterPath: String,
         releaseDate: String) {
        
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
}
