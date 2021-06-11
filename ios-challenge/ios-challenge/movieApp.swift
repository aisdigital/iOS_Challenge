//
//  ios_challengeApp.swift
//  ios-challenge
//
//  Created by Caio Madeira on 09/06/21.
//

import SwiftUI

@main
struct movieApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(fetchMovies: movieList)
        }
    }
}
