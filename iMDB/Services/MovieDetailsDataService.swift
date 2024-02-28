//
//  MovieDetailsDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 26.02.2024.
//

import Foundation
import Combine

class MovieDetailsDataService {
    
    @Published var movieDetails: MovieDetails? = nil
    var detailsSubscription: AnyCancellable?
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        getMovieDetails()
    }
    func getMovieDetails() {
        guard let url = URL(string: "https://movies-tv-shows-database.p.rapidapi.com/?movieid=\(movie.imdbID)") else { return }
            
        detailsSubscription = NetworkingManager.getMovieDetails(url: url)
            .decode(type: MovieDetails.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDetails) in
                self?.movieDetails = returnedDetails
                self?.detailsSubscription?.cancel()
            })
    }
}
