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
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("cbeb71527dmsh9bcb576649d1186p11b4e2jsn7c2efe053461", forHTTPHeaderField: "accept")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZTAzYTc3NjIxYjdhMWRhZmFjNTMxYmUzYzRkNzgxZSIsInN1YiI6IjY1ZGYyMzNlOGU4NzAyMDE4NDA0ZTVhOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fSJ1iS2d5yxcgbH2IV2T0dXEgqd-EG8_18S-B9Lg2-w", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
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
