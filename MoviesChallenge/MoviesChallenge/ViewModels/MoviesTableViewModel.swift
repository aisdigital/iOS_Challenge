//
//  MoviesTableViewModel.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import RxCocoa
import RxSwift

class MoviesTableViewModel {
    
    var resultMovies = BehaviorRelay<ResultMovies?>(value: nil)
    var moviesList = BehaviorRelay<[Movie]>(value: [])
    var currentPage = 1
    weak var coordinator: MainCoordinator?
    private var disposeBag = DisposeBag()
    
    func loadMovies() {
        API.getMovies(page: currentPage).filter { $0.totalPages >= self.currentPage }
            .subscribe(onNext: { [unowned self] result in
            self.currentPage += 1
            let newValue = self.moviesList.value + result.movies
            self.moviesList.accept(newValue)
            
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    func showDetailsMovie(id: Int) {
        API.getDetailsMovie(id: id)
            .subscribe(onNext: { [unowned self] movie in
                self.coordinator?.goToDetailsMovie(movie: movie)
            }, onError: { error in
                print(error)
                
            }).disposed(by: disposeBag)
    }
    
}
