//
//  Movies.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation
import ObjectMapper

class Movies: Mappable {
    required init?(map: Map) {
        
    }
    var page: Int? = 0
    var results: [Movie]? = []
    var total_pages: Int? = 0
    var total_results: Int? = 0
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.results <- map["results"]
        self.total_pages <- map["total_pages"]
        self.total_results <- map["total_results"]
    }
}

class Movie: Mappable {
    required init?(map: Map) {
        
    }
    var poster_path: String? = ""
    var adult: Bool? = false
    var overview: String? = ""
    var release_date: String? = ""
    var genre_ids: [Int]? = []
    var id: Int? = 0
    var original_title: String? = ""
    var original_linguage: String? = ""
    var title: String? = ""
    var backdrop_path: String? = ""
    var popularity: Double? = 0.0
    var vote_count: Int? = 0
    var video: Bool? = false
    var vote_average: Double? = 0.0
    
    
    func mapping(map: Map) {
        self.poster_path <- map["poster_path"]
        self.adult <- map["adult"]
        self.overview <- map["overview"]
        self.release_date <- map["release_date"]
        self.genre_ids <- map["genre_ids"]
        self.id <- map["id"]
        self.original_title <- map["original_title"]
        self.original_linguage <- map["original_linguage"]
        self.title <- map["title"]
        self.backdrop_path <- map["backdrop_path"]
        self.popularity <- map["popularity"]
        self.vote_count <- map["vote_count"]
        self.video <- map["video"]
        self.vote_average <- map["vote_average"]
    }
    
    func getImagePosterPath() -> String {
        guard let poster_path = poster_path else {return ""}
        
        let urlFull = "\(POSTER_URL)\(poster_path)"
        return urlFull
    }
}

