import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let kinopoiskID: Int?
    let imdbID: String?
    let nameOriginal: String?
    let nameRu: String?
    let shortDescription: String?
    let posterURL, posterURLPreview: String?
    let reviewsCount: Int?
    let ratingGoodReviewVoteCount: Int?
    let ratingKinopoiskVoteCount: Int?
    let ratingImdb: Double?
    let ratingImdbVoteCount: Int?
    let ratingFilmCriticsVoteCount: Int?
    let ratingAwaitCount: Int?
    let ratingRFCriticsVoteCount: Int?
    let webUrl: String?
    let year, filmLength: Int?
    let isTicketsAvailable: Bool?
    let type: String?
    let countries: [Country]?
    let genres: [Genre]?
}

// MARK: - Country
struct Country: Codable {
    let country: String?
}




