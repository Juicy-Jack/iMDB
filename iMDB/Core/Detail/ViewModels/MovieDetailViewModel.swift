//
//  DetailViewModel.swift
//  iMDB
//
//  Created by Furkan Doğan on 26.02.2024.
//

import Foundation
import Combine
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var movieDetail: MovieDetail? = nil
    @Published var videos: Videos? = nil
    @Published var credits: Credits? = nil
    
    private let movieDetailsDataService: DetailDataService
    private let videoDataService: VideoDataService
    private let creditsDataService: CreditsDataService
    private var cancellables = Set<AnyCancellable>()
    
    let exampleCredits = Credits(id: 671, cast: [Cast(adult: false, gender: 2, id: 10980, knownForDepartment: "Acting", name: "Daniel Radcliffe", originalName: "Daniel Radcliffe", popularity: 64.135, profilePath: "/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg", castID: 27, character: "Harry Potter", creditID: "52fe4267c3a36847f801be91", order: 0)], crew: [Crew(adult: false, gender: 2, id: 10965, knownForDepartment: "Directing", name: "Chris Columbus", originalName: "Chris Columbus", popularity: 19.537, profilePath: "/yCyEz90NqjEXKZ7HYcEhDXlLlPc.jpg", creditID: "52fe4267c3a36847f801be05", department: "Directing", job: "Director")])
    
    init(movie: Movie) {
        self.movie = movie
        self.movieDetailsDataService = DetailDataService(movie: movie)
        self.videoDataService = VideoDataService(movie: movie)
        self.creditsDataService = CreditsDataService(movie: movie)
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
        
        creditsDataService.$credits
            .sink { [weak self] (returnedCredits) in
                self?.credits = returnedCredits
            }
            .store(in: &cancellables)
    }
}

