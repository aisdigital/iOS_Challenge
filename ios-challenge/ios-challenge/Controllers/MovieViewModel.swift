//
//  MovieViewModel.swift
//  ios-challenge
//
//  Created by Caio Madeira on 10/06/21.
//

import Foundation
import UIKit

class MovieViewModel {
    
    private var API = APIService()
    private var nowPlaying = [Movie]()
    
    func updateMovies(completion: @escaping () -> ()){
        
        API.getMovies { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.nowPlaying = listOf.movies
                completion()
            case .failure(let error):
                print("JSON Error: Erro ao processar dados.")
                print(error)
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if nowPlaying.count != 0 {
            return nowPlaying.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie{
        return nowPlaying[indexPath.row]
    }
    
}
