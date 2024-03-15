//
//  AsyncProfileImage.swift
//  iMDB
//
//  Created by Furkan Doğan on 13.03.2024.
//

import SwiftUI

struct ProfileImage: View {
    let imagePath: String
    
    var body: some View {
        if !imagePath.isEmpty {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(imagePath)")) { phase in
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
        let dvm = MovieDetailViewModel(movie: hvm.exampleMovie)
        ProfileImage(imagePath: dvm.exampleCredits.cast![0].profilePath!)
    }
}
