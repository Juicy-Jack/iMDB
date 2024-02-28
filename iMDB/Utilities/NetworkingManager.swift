//
//  NetworkingManager.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func getMoviesByTitle(url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("cbeb71527dmsh9bcb576649d1186p11b4e2jsn7c2efe053461", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.addValue("get-movies-by-title", forHTTPHeaderField: "Type")

        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .eraseToAnyPublisher()
    }
    
    static func getMovieDetails(url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("cbeb71527dmsh9bcb576649d1186p11b4e2jsn7c2efe053461", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.addValue("get-movie-details", forHTTPHeaderField: "Type")
            
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            //print(error.localizedDescription)
            print(String(describing: error))
        }
    }
}
