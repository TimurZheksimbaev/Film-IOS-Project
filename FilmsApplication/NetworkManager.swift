//
//  NetworkManager.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 17.07.2023.
//

import Foundation




class NetworkManger {
    
    static let shared = NetworkManger()
    
    
    
    //    func getTopMovies() {
    //
    //        let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/top")
    //
    //        guard let url = url else {
    //            print("Error in url")
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.addValue("289806c7-3653-4b76-80a7-1684dda9cf80", forHTTPHeaderField: "Authorization")
    //        URLSession.shared.dataTask(with: request) { data, response, _ in
    //
    //
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode != 200 else {
    //                print("Error in response")
    //                return
    //            }
    //
    //            guard let films = data else {
    //                print("Error with data")
    //                return
    //            }
    //
    //
    //            do {
    //                let topFilms = try JSONSerialization.jsonObject(with: films)
    //                //                print(topFilms.filmId)
    //                print(topFilms)
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //
    //
    //        }.resume()
    //    }
    //
    
    func getTopMovies(completion: @escaping ((Result<TopFilms, Error>) -> Void)) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top"
        guard let url = URL(string: urlString) else { return }
        var getRequest = URLRequest(url: url)
        getRequest.addValue("c7f141a1-fac1-4b6b-a2bc-482353a76479", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: getRequest) { data, _, error in
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
