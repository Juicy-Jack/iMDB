//
//  ProfilePicture.swift
//  iMDB
//
//  Created by Furkan Doğan on 15.03.2024.
//

import SwiftUI

struct ProfilePicture: View {
    let profilePath: String
    
    var body: some View {
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
        }
    }


#Preview {
    Group {
        let hvm = HomeViewModel()
        let dvm = DetailViewModel(movie: hvm.exampleMovie)
        ProfilePicture(profilePath: dvm.exampleCredits.cast![0].profilePath!)
    }
}
