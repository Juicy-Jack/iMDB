//
//  DetailViewModel.swift
//  iMDB
//
//  Created by Furkan Doğan on 26.02.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var movieDetail: MovieDetail? = nil
    @Published var videos: Videos? = nil
    
    private let movieDetailsDataService: DetailDataService
    private let videoDataService: VideoDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.movie = movie
        self.movieDetailsDataService = DetailDataService(movie: movie)
        self.videoDataService = VideoDataService(movie: movie)
        addSubscribers()
    }
    
    func addSubscribers() {
        movieDetailsDataService.$detail
            .sink { [weak self] (returnedMovieDetails) in
                self?.movieDetail = returnedMovieDetails
            }
            .store(in: &cancellables)
        
        videoDataService.$videos
            .sink { [weak self] (returnedVideos) in
                self?.videos = returnedVideos
            }
            .store(in: &cancellables)
    }
}

