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
        GeometryReader { geo in
            HStack {
                AsyncUIImage(movie: movie, imageType: .poster)
                    .frame(width: geo.size.width * 0.2)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(movie.voteAverage.asNumberString())
                    }
                }
            }
        }
    }
}

#Preview {
    Group {
        let vm = HomeViewModel()
            MovieRowView(movie: vm.exampleMovie)
    }
}

