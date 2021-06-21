//
//  Observable.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ object: T) {
        value = object
    }
}
