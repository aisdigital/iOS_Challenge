//
//  CollectionData.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import Foundation

final class CollectionData<T: Decodable>: Decodable {
    
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
