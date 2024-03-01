//
//  MoviePosterView.swift
//  iMDB
//
//  Created by Furkan Doğan on 1.03.2024.
//

import SwiftUI

struct MoviePosterView: View {
    let movie: Movie
    var body: some View {
        Text(movie.title)
    }
}

#Preview {
    Group {
        let vm = HomeViewModel()
        MoviePosterView(movie: vm.exampleMovie)
    }
}
