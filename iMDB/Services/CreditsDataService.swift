//
//  CreditsDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 13.03.2024.
//

import Foundation
import Combine

class CreditsDataService {
    @Published var credits: Credits? = nil
    var videoSubscription: AnyCancellable?
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        getCredits()
    }
    
    func getCredits() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?language=en-US") else { return }
            
        videoSubscription = NetworkingManager.download(url: url)
            .decode(type: Credits.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCredits) in
                self?.credits = returnedCredits
                self?.videoSubscription?.cancel()
            })
    }
}
