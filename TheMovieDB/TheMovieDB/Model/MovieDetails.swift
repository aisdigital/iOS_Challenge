//
//  MovieDetails.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation
import ObjectMapper

class MovieDetails: Mappable {
    required init?(map: Map) {
        
    }
    var adult: Bool? = false
    var backdrop_path: String? = ""
    var belongs_to_collection: AnyObject? = nil
    var budget: Int? = 0
    var genres: [Genres]? = []
    var homepage: String? = ""
    var id: Int? = 0
    var imdb_id: String? = ""
    var original_language: String? = ""
    var original_title: String? = ""
    var overview: String? = ""
    var popularity: Double = 0.0
    var poster_path: String? = ""
    var production_companies: [Production]? = []
    var production_countries: [Countries]? = []
    var release_date: String? = ""
    var revenue: Int? = 0
    var runtime: Int? = 0
    var spoken: [Spoken]? = []
    var status: String? = ""
    var tagline: String? = ""
    var title: String? = ""
    var video: Bool? = false
    var vote_average: Double? = 0.0
    var vote_count: Int? = 0
    
    func mapping(map: Map) {
        self.adult <- map["adult"]
        self.backdrop_path <- map["backdrop_path"]
        self.belongs_to_collection <- map["belongs_to_collection"]
        self.budget <- map["budget"]
        self.genres <- map["genres"]
        self.homepage <- map["homepage"]
        self.id <- map["id"]
        self.imdb_id <- map["imdb_id"]
        self.original_language <- map["original_language"]
        self.original_title <- map["original_title"]
        self.overview <- map["overview"]
        self.popularity <- map["popularity"]
        self.poster_path <- map["poster_path"]
        self.production_companies <- map["production_companies"]
        self.production_countries <- map["production_countries"]
        self.release_date <- map["release_date"]
        self.revenue <- map["revenue"]
        self.runtime <- map["runtime"]
        self.spoken <- map["spoken"]
        self.status <- map["status"]
        self.tagline <- map["tagline"]
        self.title <- map["title"]
        self.video <- map["video"]
        self.vote_average <- map["vote_average"]
        self.vote_count <- map["vote_count"]
    }
    
    func getImageBackDropPath() -> String {
        guard let backdrop_path = backdrop_path else {return ""}
        
        let urlFull = "\(POSTER_URL)\(backdrop_path)"
        return urlFull
    }
}

class Genres: Mappable {
    required init?(map: Map) {
        
    }
    var id: Int? = 0
    var name: String? = ""
        
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
    }
}

class Production: Mappable {
    required init?(map: Map) {
        
    }
    var name: String? = ""
    var id: Int? = 0
    var logo_path: String? = ""
    var origin_country: String? = ""
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.id <- map["id"]
        self.logo_path <- map["logo_path"]
        self.origin_country <- map["origin_country"]
    }
}

class Countries: Mappable {
    required init?(map: Map) {
        
    }
    var iso_3166_1: String? = ""
    var name: String? = ""
    
    func mapping(map: Map) {
        self.iso_3166_1 <- map["iso_3166_1"]
        self.name <- map["name"]
    }
}

class Spoken: Mappable {
    required init?(map: Map) {
        
    }
    var iso_639_1: String? = ""
    var name: String? = ""
    
    func mapping(map: Map) {
        self.iso_639_1 <- map["iso_630_1"]
        self.name <- map["name"]
    }
}
