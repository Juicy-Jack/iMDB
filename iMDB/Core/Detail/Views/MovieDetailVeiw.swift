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
            if (vm.videos != nil) {
                if !vm.videos!.results!.isEmpty {
                    let trailerKey = vm.videos?.results?[0].key
                    YTVideo(videoID: (trailerKey!))
                }
            }
            Text(vm.movieDetail?.overview ?? "")
            if let genres = vm.movieDetail?.genres {
                ForEach(genres, id: \.name) { genre in
                    Text(genre.name ?? "")
                }
            }

        }
        }
    }


#Preview {
    Group {
        let vm = HomeViewModel()
        MovieDetailVeiw(movie: vm.exampleMovie)
    }
}

