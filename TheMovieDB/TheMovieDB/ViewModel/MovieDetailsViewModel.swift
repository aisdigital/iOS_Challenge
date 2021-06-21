//
//  MovieDetailsViewModel.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation
import UIKit

protocol MovieDetailsNavigationProtocol: AnyObject {}

protocol MovieDetailsViewModelProtocol {
    var movieDetails: Observable<MovieDetails?> { get }
    var similiarMovies: Observable<[SimilarMovies]> { get }
    var videoMovies: Observable<[VideoMovies]> { get }
    var movie_id: Int { get }
    var currentPage: Int { get set }
    
    func fetchMovieDetails()
    func fetchSimilarMovies()
    func fetchVideoMovies()
}

struct MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private var navigationDelegate: MovieDetailsNavigationProtocol
    var movieDetails: Observable<MovieDetails?>
    var similiarMovies: Observable<[SimilarMovies]>
    var videoMovies: Observable<[VideoMovies]>
    var movie_id: Int
    var currentPage: Int
    
    
    init(navigationDelegate: MovieDetailsNavigationProtocol, movie_id: Int) {
        self.navigationDelegate = navigationDelegate
        self.movie_id = movie_id
        self.movieDetails = Observable(nil)
        self.similiarMovies = Observable([])
        self.videoMovies = Observable([])
        self.currentPage = 1
        fetchMovieDetails()
        fetchSimilarMovies()
        fetchVideoMovies()
    }
    
    func fetchMovieDetails() {
        TheMovieDBService.shared.fetchMovieDetails(movie_id: movie_id) { (info) in
            if let info = info {
                movieDetails.value = info
            }
        }
    }
    
    func fetchSimilarMovies() {
        TheMovieDBService.shared.fetchSimilarMovies(movie_id: movie_id, page: currentPage) { (info) in
                if let info = info {
                    similiarMovies.value.append(contentsOf: info.results!)
                }
            }
    }
    
    func fetchVideoMovies() {
        TheMovieDBService.shared.fetchVideoMovies(movie_id: movie_id) { (info) in
                if let info = info {
                    videoMovies.value.append(contentsOf: info.results!)
                }
            }
    }
    
}

