//
//  FilmModel.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 17.07.2023.
//

import Foundation

struct TopFilms: Hashable, Decodable {
    let pagesCount: Int
    let films: [Film]
}

extension TopFilms {
    static let example = TopFilms(pagesCount: 1, films: [Film(kinopoiskId: 1, nameEn: "Black Panther", filmLength: "01:04", genres: [Genre(genre: "Action")], posterUrl: "BlackPanther", year: 2013), Film(kinopoiskId: 2, nameEn: "Avengers", filmLength: "02:06", genres: [Genre(genre: "Action")], posterUrl: "Avengers", year: 2011), Film(kinopoiskId: 3, nameEn: "Shrek", filmLength: "02:34", genres: [Genre(genre: "Multik")], posterUrl: "Shrek", year: 2056)])
    
}


struct Film: Hashable, Decodable {
    let kinopoiskId: Int
    let nameEn: String
    let filmLength: String
    let genres: [Genre]
    let posterUrl: String
    let year: Int
    
    
}

extension Film {
    static let example = Film(kinopoiskId: 1, nameEn: "Some", filmLength: "03:09", genres: [Genre(genre: "action")],  posterUrl: "", year: 1892)
}

struct Genre: Hashable, Decodable {
    let genre: String
}


