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
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                    .foregroundStyle(vm.searchText.isEmpty ? Color.secondary : Color.accentColor)

                TextField("Search Film", text: $vm.searchText)
                    .foregroundStyle(.white)
                    .padding()
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .opacity(vm.searchText.isEmpty ? 0 : 1)
                            .onTapGesture {
                                vm.searchText = ""
                            }
                        ,alignment: .trailing)
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.gray)
            )
            .padding()

            
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
        GeometryReader { geo in
            List {
                ForEach (vm.allMovies) { movie in
                    MovieRowView(movie: movie)
                        .frame(height: geo.size.height * 0.2)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(movie: movie)
                        }
                        .padding(.vertical)
                }
            }
            .listStyle(.plain)
        }
    }
    
    private func segue(movie: Movie) {
        selectedMovie = movie
        showDetailsView.toggle()
    }
}
