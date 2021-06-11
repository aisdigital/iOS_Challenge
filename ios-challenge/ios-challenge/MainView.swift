//
//  ContentView.swift
//  ios-challenge
//
//  Created by Caio Madeira on 09/06/21.
//

// 1 - O App possui 3 telas: A principal, a de Detalhes e a de Procura

import SwiftUI

struct MainView: View {
    
    //var API = APIService()
//    @State var results: [MoviesData] = []
    var fetchMovies: [MovieCatalog]
    var body: some View {
        
        
        GeometryReader { superViewHeader in
            
            let supViewWidth = superViewHeader.size.width
            let supViewHeight = superViewHeader.size.height
            
            let navTitle = HeaderLabel(title: "Filmes em Cartaz", width: supViewWidth, height: supViewHeight)
            
            NavigationView{
                List(fetchMovies){
                    movie in MovieCatalogView(eachMovie: movie)
                }.navigationBarTitle(Text(navTitle.title))
            }
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(fetchMovies: movieList)
    }
}
