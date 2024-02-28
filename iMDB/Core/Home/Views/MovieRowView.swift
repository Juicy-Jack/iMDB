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
        Text(movie.title)
    }
}

#Preview {
    Group {
        let vm = HomeViewModel()
        MovieRowView(movie: vm.exampleTitle)
    }
}
