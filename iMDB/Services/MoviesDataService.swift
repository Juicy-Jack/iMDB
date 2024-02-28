//
//  TitlesDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import Foundation
import Combine

class MoviesDataService {
    
    @Published var allTitles: [Movie] = []
    var movieSubscription: AnyCancellable?

    
    func getMovies(query: String) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&page=1") else { return }
        
        movieSubscription = NetworkingManager.download(url: url)
            .decode(type: Results.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedMovies) in
                self?.allTitles = returnedMovies.results ?? []
                self?.movieSubscription?.cancel()})
    }
}
