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
    @Published var movieDetails: MovieDetails? = nil
    
    private let movieDetailsDataService: MovieDetailsDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.movie = movie
        self.movieDetailsDataService = MovieDetailsDataService(movie: movie)
        addSubscribers()
    }
    
    func addSubscribers() {
        movieDetailsDataService.$movieDetails
            .sink { [weak self] (returnedMovieDetails) in
                self?.movieDetails = returnedMovieDetails
            }
            .store(in: &cancellables)
        print("heyy")
    }
}
