//
//  CollectionData.swift
//  TheMovie
//
//  Created by Marcos Jr on 14/06/21.
//

import Foundation

class CollectionData<T: Decodable>: Decodable {

    let results: [T]
    var currentPage: Int
    var totalPages: Int

    init(results: [T], currentPage: Int, totalPages: Int) {
        self.results = results
        self.currentPage = currentPage
        self.totalPages = totalPages
    }

    enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }
}
