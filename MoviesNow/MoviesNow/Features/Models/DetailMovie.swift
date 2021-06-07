//
//  DetailMovie.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 05/06/21.
//

import Foundation

final class DetailMovie: Decodable {
    
    let id: Int
    let genres: [Genre]
    let title: String
    let posterPath: String?
    let releaseDate: String
    let runingTime: Int
    let overview: String
    
    init(id: Int,
         genres: [Genre],
         title: String,
         posterPath: String,
         releaseDate: String,
         runingTime: Int,
         overview: String
    ) {
        self.id = id
        self.genres = genres
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.runingTime = runingTime
        self.overview = overview
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case genres
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runingTime = "runtime"
        case overview
        
    }
}
