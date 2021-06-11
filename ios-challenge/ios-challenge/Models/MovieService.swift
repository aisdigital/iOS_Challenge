//
//  APIRequest.swift
//  ios-challenge
//
//  Created by Caio Madeira on 10/06/21.
//

import Foundation
import UIKit



struct MoviesData: Decodable{
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable,Identifiable {
    
    let id: Int?
    let title: String
    let year: String?
    let rate: Double?
    let posterPath: String?
    let overview: String? // sinopse
    let runtime: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case year = "release_date"
        case rate = "vote_average"
        case posterPath = "poster_path"
        case overview = "overview"
        case runtime = "runtime"
    }
    
    
}

