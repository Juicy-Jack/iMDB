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
    private var release: Date
    
    init(movie: Movie) {
        _vm = StateObject(wrappedValue: DetailViewModel(movie: movie))
        release = Date(dateString: movie.releaseDate)
    }
    
    var body: some View {
        
        ScrollView {
            ZStack (alignment: .topTrailing) {
                VStack {
                    AsyncUIImage(movie: vm.movie, imageType: .backdrop)
                        .ignoresSafeArea()
                        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                    
                    Spacer()
                    
                    Text(vm.movieDetail?.overview ?? "")
                        .padding()
                    
                    //YoutubeVideo(videos: vm.videos)
                    
                    if let genres = vm.movieDetail?.genres {
                        ForEach(genres, id: \.name) { genre in
                            Text(genre.name ?? "")
                        }
                    }
                }
                
                HStack {
                    VStack {
                        Text(vm.movie.title)
                            .font(.headline)
                            .foregroundStyle(.accent)
                        
                        HStack {
                            Text(release.asShortDateString())
                                .fontWeight(.light)
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 4)
                                .opacity(0.5)
                            
                            Text("\(vm.movieDetail?.runtime ?? 0) min.")
                                .fontWeight(.light)
                            
                        }
                        .font(.callout)
                        .foregroundStyle(.accent)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.black)
                            .opacity(0.1))
                    
                    Spacer()
                    
                    AsyncUIImage(movie: vm.movie, imageType: .poster)
                        .frame(width: 100)
                }
                .padding(.horizontal)
                .alignmentGuide(VerticalAlignment.top) { _ in -100}
                
                Spacer()
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

