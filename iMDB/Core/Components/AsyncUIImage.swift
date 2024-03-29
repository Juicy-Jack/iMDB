//
//  PosterUIImage.swift
//  iMDB
//
//  Created by Furkan Doğan on 1.03.2024.
//

import SwiftUI

struct AsyncUIImage: View {
    
    let movie: Movie
    let imageType: ImageType
    
    var body: some View {
        
        if imageType == .poster {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Image(systemName: "movieclapper.fill")
                            .resizable()
                            .scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "movieclapper.fill")
                    .resizable()
                    .scaledToFit()
                
            }
        } else {
            if let backdropPath = movie.backdropPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Image(systemName: "movieclapper.fill")
                            .resizable()
                            .scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "movieclapper.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    enum ImageType {
        case poster, backdrop, profile
    }
}

#Preview {
    Group {
        let vm = HomeViewModel()
        AsyncUIImage(movie: vm.exampleMovie, imageType: .poster)
    }
}
