//
//  HomeViewModel.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import Foundation
import Combine

/*
 {
       "adult": false,
       "backdrop_path": "/hziiv14OpD73u9gAak4XDDfBKa2.jpg",
       "genre_ids": [
         12,
         14
       ],
       "id": 671,
       "original_language": "en",
       "original_title": "Harry Potter and the Philosopher's Stone",
       "overview": "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame.",
       "popularity": 176.135,
       "poster_path": "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg",
       "release_date": "2001-11-16",
       "title": "Harry Potter and the Philosopher's Stone",
       "video": false,
       "vote_average": 7.915,
       "vote_count": 26168
     }
 */


class HomeViewModel: ObservableObject {
    
    @Published var allMovies: [Movie] = []
    @Published var searchText = ""
    let exampleMovie = Movie(adult: false, backdropPath: "/hziiv14OpD73u9gAak4XDDfBKa2.jpg", genreIDS: [12, 14], id: 671, originalLanguage: "en", originalTitle: "Harry Potter and the Philosopher's Stone", overview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame.", popularity: 176.135, posterPath: "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg", releaseDate: "2001-11-16", title: "Harry Potter and the Philosopher's Stone", video: false, voteAverage: 7.915, voteCount: 261168)
    
    private let titleDataService = MoviesDataService()
    private var cancellables = Set<AnyCancellable> ()
    
    init() {
        addSubscribers()
    }
    
    func search() {
        titleDataService.getMovies(query: searchText)
    }
    
    func addSubscribers() {
        titleDataService.$allTitles
            .sink { [weak self] (returnedMovies) in
                self?.allMovies = returnedMovies
            }
            .store(in: &cancellables)
    }
}
