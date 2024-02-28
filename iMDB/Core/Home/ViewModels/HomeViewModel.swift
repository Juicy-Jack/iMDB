//
//  HomeViewModel.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allMovies: [Movie] = []
    @Published var searchText = ""
    let exampleTitle = Movie(title: "'Harry Potter': Behind the Magic", year: 2005, imdbID: "tt0497106")
    
    private let titleDataService = TitlesDataService()
    private var cancellables = Set<AnyCancellable> ()
    
    init() {
        addSubscribers()
    }
    
    func search() {
        titleDataService.getMovies(title: searchText)
    }
    
    func addSubscribers() {
        titleDataService.$allTitles
            .sink { [weak self] (returnedMovies) in
                self?.allMovies = returnedMovies
            }
            .store(in: &cancellables)
    }
}
