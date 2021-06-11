//
//  MovieCatalogView.swift
//  ios-challenge
//
//  Created by Caio Madeira on 10/06/21.
//
import SwiftUI

struct MovieCatalogView: View {
    
    @State var API = APIService()
    
    var eachMovie: MovieCatalog
    var body: some View {
        HStack{
                Image("Test")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            Text(eachMovie.title)
                    .frame(width: 100, height: 50, alignment: .leading)
        }
    }
}

let movieList: Array = [
    MovieCatalog(id: 1, title: "Fight Club", year: "1999", poster: "Aaa"),
    MovieCatalog(id: 2, title: "The Godfathers", year: "1999", poster: "Aaa"),
    MovieCatalog(id: 3, title: "The Godfathers", year: "1999", poster: "Aaa"),
    MovieCatalog(id: 4, title: "The Godfathers", year: "1999", poster: "Aaa"),
    MovieCatalog(id: 5, title: "The Godfathers", year: "1999", poster: "Aaa")
]

