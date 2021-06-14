//
//  Movie.swift
//  TheMovie
//
//  Created by Marcos Jr on 13/06/21.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String

    init(id: Int,
         title: String,
         posterPath: String,
         releaseDate: String,
         runingTime: Int
    ) {
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
