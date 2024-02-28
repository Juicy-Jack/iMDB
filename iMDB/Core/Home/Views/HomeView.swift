//
//  HomeView.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedMovie: Movie? = nil
    @State private var showDetailsView: Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search Film", text: $vm.searchText)
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(.gray)
                    )
                Button {
                    vm.search()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            allMoviesList
        }
        .background(
            NavigationLink(
                destination: DetailsLoadingView(movie: $selectedMovie),
                isActive: $showDetailsView,
                label: { EmptyView() } )
        )
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    private var allMoviesList: some View {
        List {
            ForEach (vm.allMovies) { movie in
                MovieRowView(movie: movie)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(movie: movie)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(movie: Movie) {
        selectedMovie = movie
        showDetailsView.toggle()
    }
}
