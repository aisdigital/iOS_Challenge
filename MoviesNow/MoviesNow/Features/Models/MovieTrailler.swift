//
//  MovieTrailler.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 05/06/21.
//

import Foundation

final class MovieTrailler: Decodable {
    
    let key: String
    let site: String
    
    init(key: String, site: String) {
        self.key = key
        self.site = site
    }
}
