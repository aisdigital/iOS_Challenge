//
//  Videos.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import ObjectMapper

class Videos: Mappable {
    required init?(map: Map) {}
    var id: Int? = 0
    var results: [VideoMovies]? = []
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.results <- map["results"]
    }
}

class VideoMovies: Mappable {
    required init?(map: Map) {
        
    }
    
    var id: String? = ""
    var iso_639_1: String? = ""
    var iso_3166_1: String? = ""
    var key: String? = ""
    var name: String? = ""
    var site: String? = ""
    var size: Int? = 0
    var type: String? = ""

    func mapping(map: Map) {
        self.id <- map["id"]
        self.iso_639_1 <- map["iso_639_1"]
        self.iso_3166_1 <- map["iso_3166_1"]
        self.key <- map["key"]
        self.name <- map["name"]
        self.site <- map["site"]
        self.size <- map["size"]
        self.type <- map["type"]
    }
    
    func getURLTrailer() -> String {
        guard let key = key else { return "" }
        
        var urlFull = ""
        
        if type == "Trailer" {
            if site == "YouTube" {
              urlFull = "\(YOUTUBE_URL)\(key)"
            }
        } else {
                urlFull = ""
        }
        
        return urlFull
    }
}
