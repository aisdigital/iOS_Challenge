//
//  MovieListViewModel.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import Foundation

final class MovieListViewModel {
    
    private let service = MovieService()
    
    weak var delegate: MoviesDelegate?
    
    private var currentPage = 1
    private var totalPages = 0
    private var movies = [Movie]()
    
    init() {
        loadData()
    }
    
    func loadData(page: Int = 1) {
        
        let request = service.getMoviesInTheaters(currentPage: page)
        
        request.responseDecodable(of: CollectionData<Movie>.self) { response in
            switch response.result {
            
            case let .success(result):
                self.movies += result.results
                self.currentPage = result.currentPage
                self.totalPages = result.totalPages
                self.delegate?.getData(data: self.movies)
                
            case .failure(_):
                self.movies = [Movie]()
                self.currentPage = 1
                self.totalPages = 0
                self.delegate?.getData(data: self.movies)
            }
        }
    }
    
    func paginate(indexPath: IndexPath) {
        
        if indexPath.row == movies.count - 1 {
            currentPage += 1
            
            if currentPage <= totalPages {
                loadData(page: currentPage)
            }
        }
    }
}
