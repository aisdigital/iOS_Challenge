//
//  Service.swift
//  ios-challenge
//
//  Created by Caio Madeira on 10/06/21.
//

import Foundation

class APIService{

    
    private let apiKeyV3 = "fc7b558bc5ed606ada8b90b526bb85ee"
//    private let apiHost = "https://api.themoviedb.org/3"
    private var urlSession: URLSessionDataTask?
    
    // Categorias do site
    private let upcoming: String = "upcoming"
    private let popular: String = "popular"
    private let top_rated: String = "top_rated"
    private let now_playing: String = "now_playing"

    public func getMovies(completion: @escaping (Result<MoviesData, Error>) -> Void){
        
        //let urlExample = "https://api.themoviedb.org/3/movie/\(now_playing)?api_key=\(apiKeyV3)&language=pt-BR"
        let urlExample = "https://api.themoviedb.org/3/movie/\(now_playing)?api_key=\(apiKeyV3)&language=pt-BR"
        guard let url = URL(string: urlExample) else {return}
        
        urlSession = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // General Erros
            if let error = error {
                completion(.failure(error))
                print("error: \(String(describing: error.localizedDescription))")
                return
            }
            
            // Responses vazias
            guard let response = response as? HTTPURLResponse else {
                
                print("Resposta vazia.")
                return
                
            }
            print("Status Code: \(response.statusCode)")
            
            guard let data = data else {
                // Dados vazios
                print("Dados vazios.")
                return
            }
            do{
                // Decodificando dados
                let decoder = JSONDecoder()
                let jsonDec = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonDec))
                }
            }catch let error {
                completion(.failure(error))
            }

        }
        urlSession?.resume()


    }


}
