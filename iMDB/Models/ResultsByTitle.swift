//
//  Title.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//


import Foundation

struct ResultsByTitle: Codable {
    let movieResults: [Movie]?
    let searchResults: Int?
    let status, statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case searchResults = "search_results"
        case status
        case statusMessage = "status_message"
    }
}

struct Movie: Codable, Identifiable {
    let id = UUID()
    let title: String
    let year: Int
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case title, year, id
        case imdbID = "imdb_id"
    }
}
