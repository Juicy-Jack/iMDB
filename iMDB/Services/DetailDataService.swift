//
//  DetailDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 28.02.2024.
//

import Foundation
import Combine

class DetailDataService {
    @Published var detail: MovieDetail? = nil
    var detailSubscription: AnyCancellable?
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        getMovieDetails()
    }
    
    func getMovieDetails() {
        guard let url = URL(string:  "https://api.themoviedb.org/3/movie/\(movie.id)?language=en-US") else { return }
        
        detailSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDetail) in
                self?.detail = returnedDetail
                self?.detailSubscription?.cancel()
            })
                
    }
}
