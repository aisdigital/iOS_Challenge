//
//  TopRatedViewModel.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation
import UIKit

protocol TopRatedNavigationProtocol: AnyObject { 
    func gotoMovieDetails(movie_id: Movie)
}
    
protocol TopRatedViewModelProtocol {
    var error: Observable<Error?> { get }
    var isLoading: Observable<Bool> { get }
    var isPullRefresh: Observable<Bool> { get }
    var movies: Observable<[Movie]> { get }
    var loadingMovies: Bool { get set }
    var currentPage: Int { get set }
    
    func fetchTopRated()
    func pullRefresh()
    func selectMovieItemAt(indexPath: IndexPath)
}

struct TopRatedViewModel: TopRatedViewModelProtocol {
    
    private var navigationDelegate: TopRatedNavigationProtocol
    var error: Observable<Error?>
    var isLoading: Observable<Bool>
    var isPullRefresh: Observable<Bool>
    var movies: Observable<[Movie]>
    var loadingMovies: Bool
    var currentPage: Int
    
    init(navigationDelegate: TopRatedNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isPullRefresh = Observable(false)
        self.movies = Observable([])
        self.loadingMovies = false
        self.currentPage = 1
        fetchTopRated()
    }
    
    func fetchTopRated() {
        TheMovieDBService.shared.fetchTopRated(page: currentPage) { (info) in
            if let info = info {
                self.movies.value.append(contentsOf: info.results!)
            }
        }
    }
    
    func pullRefresh() {
        self.isPullRefresh.value = true
        self.movies.value.removeAll()
        
        TheMovieDBService.shared.fetchTopRated(page: currentPage) { (info) in
            if let info = info {
                self.movies.value.append(contentsOf: info.results!)
                self.isPullRefresh.value = false
                
            }
        }
    }
    
    func selectMovieItemAt(indexPath: IndexPath) {
        guard movies.value.indices.contains(indexPath.row) else { return }
        let item = movies.value[indexPath.row]
        navigationDelegate.gotoMovieDetails(movie_id: item)
    }
        
}

