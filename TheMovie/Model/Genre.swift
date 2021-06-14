//
//  Genre.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import Foundation

class Genre: Decodable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
