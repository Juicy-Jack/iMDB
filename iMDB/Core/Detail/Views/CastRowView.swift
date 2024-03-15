//
//  CastRowView.swift
//  iMDB
//
//  Created by Furkan Doğan on 13.03.2024.
//

import SwiftUI

struct CastRowView: View {
    let cast: Cast

    var body: some View {
        HStack(spacing: 5) {
            ProfileImage(imagePath: cast.profilePath ?? "")
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(cast.name!)
                Text(cast.character!)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Group {
        let hvm = HomeViewModel()
        let dvm = MovieDetailViewModel(movie: hvm.exampleMovie)
        CastRowView(cast: dvm.exampleCredits.cast![0])
    }
}
