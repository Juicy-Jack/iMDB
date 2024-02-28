//
//  TitleRowView.swift
//  iMDB
//
//  Created by Furkan Doğan on 21.02.2024.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    var body: some View {
        HStack {
            if let posterPath = movie.posterPath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/original\(posterPath)"),
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 70)
                    }, placeholder: {
                        ProgressView()
                    })
            }
            Text(movie.title ?? "")
        }
    }
}

#Preview {
    Group {
        let vm = HomeViewModel()
        MovieRowView(movie: vm.exampleMovie)
    }
}

