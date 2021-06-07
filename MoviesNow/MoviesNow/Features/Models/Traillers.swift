//
//  Traillers.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 05/06/21.
//

import Foundation

final class Traillers: Decodable {
    
    let results: [MovieTrailler]
    
    init(results:  [MovieTrailler]) {
        self.results = results
    }
}
