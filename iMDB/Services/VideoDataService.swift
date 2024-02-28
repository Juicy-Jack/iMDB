//
//  VideoDataService.swift
//  iMDB
//
//  Created by Furkan Doğan on 28.02.2024.
//

import Foundation
import Combine

class VideoDataService {
    @Published var videos: Videos? = nil
    var videoSubscription: AnyCancellable?
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        getTrailer()
    }
    
    func getTrailer() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/videos?language=en-US") else { return }
            
        videoSubscription = NetworkingManager.download(url: url)
            .decode(type: Videos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedVideos) in
                self?.videos = returnedVideos
                self?.videoSubscription?.cancel()
            })
    }
}
