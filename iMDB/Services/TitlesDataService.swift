//
//  TitlesDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import Foundation
import Combine

class TitlesDataService {
    
    @Published var allTitles: [Movie] = []
    var titleSubscription: AnyCancellable?

    
    func getMovies(title: String) {
        guard let url = URL(string: "https://movies-tv-shows-database.p.rapidapi.com/?title=\(title)") else { return }
        
        titleSubscription = NetworkingManager.getMoviesByTitle(url: url)
            .decode(type: ResultsByTitle.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedMovies) in
                self?.allTitles = returnedMovies.movieResults ?? []
                self?.titleSubscription?.cancel()})
    }
}
