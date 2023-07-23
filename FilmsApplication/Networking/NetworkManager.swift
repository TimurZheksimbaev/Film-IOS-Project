//
//  NetworkManager.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 17.07.2023.
//

import Foundation


final class NetworkManger {
    
    static let shared = NetworkManger()
    
    func getTopMovies(completion: @escaping ((Result<TopFilms, Error>) -> Void)) {
        
        
        for i in 1...5 {
            
            let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS" + "&page=" + String(i)
            
            
            guard let url = URL(string: urlString) else { return }
            
            var getRequest = URLRequest(url: url)
            
            getRequest.addValue("c7f141a1-fac1-4b6b-a2bc-482353a76479", forHTTPHeaderField: "X-API-KEY")
            
            URLSession.shared.dataTask(with: getRequest) { data, response, error in
                
                let resp = response as? HTTPURLResponse
                
                

                if error == nil {
                    guard let data = data else { return }
                    do {
                        let similarMovies = try JSONDecoder().decode(TopFilms.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(similarMovies))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    guard let error = error else { return }
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    

    
    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(idMovie)"
        guard let url = URL(string: urlString) else { return }
        var getRequest = URLRequest(url: url)
        getRequest.addValue("c7f141a1-fac1-4b6b-a2bc-482353a76479", forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: getRequest) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let similarMovies = try JSONDecoder().decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(similarMovies))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }
}
