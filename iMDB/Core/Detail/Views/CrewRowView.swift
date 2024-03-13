//
//  CrewRowView.swift
//  iMDB
//
//  Created by Furkan Doğan on 13.03.2024.
//

import SwiftUI

struct CrewRowView: View {
    let crew: Crew
    
    var body: some View {
        HStack(spacing: 5) {
            AsyncCrewProfileImage(crew: crew)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(crew.name!)
                Text(crew.job!)
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
        let dvm = DetailViewModel(movie: hvm.exampleMovie)
        CrewRowView(crew: dvm.exampleCredits.crew![0])
    }
}
