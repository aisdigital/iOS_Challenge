//
//  ResultSearchViewModel.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 21/06/21.
//

import Foundation
import UIKit

protocol ResultSearchNavigationProtocol: AnyObject {
    func gotoMovieDetails(movie_id: Movie)
}

protocol ResultSearchViewModelProtocol {
    var movies: Observable<[Movie]> { get }
    var loadingMovies: Bool { get set }
    var title: String { get }
    var currentPage: Int { get set }
    
    func fetchSearch()
    func selectMovieItemAt(indexPath: IndexPath)
}

struct ResultSearchViewModel: ResultSearchViewModelProtocol {
    
    private var navigationDelegate: ResultSearchNavigationProtocol
    var movies: Observable<[Movie]>
    var loadingMovies: Bool
    var title: String
    var currentPage: Int
    
    init(navigationDelegate: ResultSearchNavigationProtocol, title: String) {
        self.navigationDelegate = navigationDelegate
        self.movies = Observable([])
        self.loadingMovies = false
        self.currentPage = 1
        self.title = title
        fetchSearch()
    }
    
    func fetchSearch() {
        TheMovieDBService.shared.fetchSearch(title: title, page: currentPage) { (info) in
            if let info = info {
                self.movies.value.append(contentsOf: info.results!)
            }
        }
    }
    
    func selectMovieItemAt(indexPath: IndexPath) {
        guard movies.value.indices.contains(indexPath.row) else { return }
        let item = movies.value[indexPath.row]
        navigationDelegate.gotoMovieDetails(movie_id: item)
    }
        
}
