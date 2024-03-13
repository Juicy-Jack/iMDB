//
//  AsyncProfileImage.swift
//  iMDB
//
//  Created by Furkan Doğan on 13.03.2024.
//

import SwiftUI

struct AsyncCastProfileImage: View {
    let cast: Cast
    
    var body: some View {
        if let profilePath = cast.profilePath {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(profilePath)")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Image couldn't downloaded.")
                } else {
                    ProgressView()
                }
            }
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    Group {
        let hvm = HomeViewModel()
        let dvm = DetailViewModel(movie: hvm.exampleMovie)
        AsyncCastProfileImage(cast: dvm.exampleCredits.cast![0])
    }
}
