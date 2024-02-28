//
//  MovieDetailVeiw.swift
//  iMDB
//
//  Created by Furkan Doğan on 26.02.2024.
//

import SwiftUI

struct DetailsLoadingView: View {
    
    @Binding var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie = movie {
                MovieDetailVeiw(movie: movie)
            }
        }
    }
}

struct MovieDetailVeiw: View {
    
    @StateObject private var vm: DetailViewModel
    
    init(movie: Movie) {
        _vm = StateObject(wrappedValue: DetailViewModel(movie: movie))
    }
    
    var body: some View {
        VStack {
            Text(vm.movieDetails?.description ?? "")
            if let genres = vm.movieDetails?.genres {
                ForEach(genres, id: \.self) { genre in
                    Text(genre)
                }
            }
        }
        }
    }


#Preview {
    Group {
        let vm = HomeViewModel()
        MovieDetailVeiw(movie: vm.exampleTitle)
    }
}
