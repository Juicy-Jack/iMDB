//
//  PersonDetailView.swift
//  iMDB
//
//  Created by Furkan Doğan on 15.03.2024.
//

import SwiftUI

struct PersonDetailsLoadingView: View {
    @Binding var personID: Int?
    
    var body: some View {
        ZStack {
            if let personID = personID {
                PersonDetailView(personID: personID)
            }
        }
    }

}

struct PersonDetailView: View {
    let personID: Int

    @StateObject private var vm: PersonDetailViewModel
    @State private var showFullBiography: Bool = false
    
    init(personID: Int) {
        self.personID = personID
        _vm = StateObject(wrappedValue: PersonDetailViewModel(personID: personID))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        ProfileImage(imagePath: vm.person?.profilePath ?? "")
                            .frame(height: 300)
                            .padding(.leading, 4)
                        VStack(alignment: .leading) {
                            Text("Born \(Date(dateString: vm.person?.birthday ?? "").asShortDateFormatterString())")
                                .fontWeight(.heavy)
                            Text(vm.person?.placeOfBirth ?? "")
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                        .font(.caption)
                    }
                    VStack(alignment: .leading, spacing: 3) {
                        Text(vm.person?.biography ?? "")
                            .lineLimit(showFullBiography ? Int.max : 5)
                        Text(showFullBiography ? "Less" : "Read more...")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundStyle(.accent.opacity(vm.person?.biography == nil ? 0 : 1))
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showFullBiography.toggle()
                                }
                            }
                    }
                    .padding()
                }
                .navigationTitle((vm.person?.name ?? ""))
            }
        }
    }
}

#Preview {
    Group {
        let hvm = HomeViewModel()
        let dvm = MovieDetailViewModel(movie: hvm.exampleMovie)
        PersonDetailView(personID: dvm.exampleCredits.cast![0].id!)
    }
}
