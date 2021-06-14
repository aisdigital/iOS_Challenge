//
//  Traillers.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import Foundation

class Traillers: Decodable {
    let results: [Trailler]

    init(results:  [Trailler]) {
        self.results = results
    }
}

class Trailler: Decodable {

    let key: String
    let site: String

    init(key: String, site: String) {
        self.key = key
        self.site = site
    }
}
