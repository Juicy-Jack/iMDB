//
//  MovieDetailVeiw.swift
//  iMDB
//
//  Created by Furkan Doğan on 26.02.2024.
//

import SwiftUI

struct DetailsLoadingView: View {
    
    @Binding var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie = movie {
                MovieDetailVeiw(movie: movie)
            }
        }
    }
}

struct MovieDetailVeiw: View {
    
    @State private var showFullDescription: Bool = false
    @StateObject private var vm: MovieDetailViewModel
    private var release: Date
    
    @State private var listType: ListType = .cast
    @State private var selectedPersonID: Int? = nil
    @State private var showPersonDetailView: Bool = false
    
    init(movie: Movie) {
        _vm = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
        release = Date(dateString: movie.releaseDate)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .top) {
                    VStack {
                        backdropImage
                            .frame(maxWidth: geo.size.width)
                        
                        Spacer()

                        movieOverview
                        
                        Spacer()
                        
                        if let genres = vm.movieDetail?.genres {
                            ForEach(genres, id: \.name) { genre in
                                Text(genre.name ?? "")
                            }
                        }
                        
                        Picker("", selection: $listType) {
                            ForEach(ListType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        if listType == .cast {
                            if let cast = vm.credits?.cast {
                                castList(cast: cast)
                            }
                        } else {
                            if let crew = vm.credits?.crew {
                                crewList(crew: crew)
                            }
                        }
                    }
                    
                    titleAndPoster
                        .padding(.horizontal)
                        .alignmentGuide(VerticalAlignment.top) { _ in -(geo.size.height / 9)}
                    
                    Spacer()
                }
            }
        }
        .background(
            NavigationLink(
                destination: PersonDetailsLoadingView(personID: $selectedPersonID),
                isActive: $showPersonDetailView,
                label: { EmptyView() } )
        )

    }
}

extension MovieDetailVeiw {
    
    private var backdropImage: some View {
        AsyncUIImage(movie: vm.movie, imageType: .backdrop)
            .ignoresSafeArea()
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    }
    
    private var titleAndPoster: some View {
        HStack {
            VStack {
                Text(vm.movie.title)
                    .font(.headline)
                    .foregroundStyle(.accent)
                
                HStack {
                    Text(release.asYearString())
                        .fontWeight(.light)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 4)
                        .opacity(0.5)
                    
                    Text("\(vm.movieDetail?.runtime ?? 0) mins")
                        .fontWeight(.light)
                    
                }
                .font(.callout)
                .foregroundStyle(.accent)
                
                if let videos = vm.videos {
                    if (!(videos.results.isEmpty)) {
                        if let trailerKey = videos.results[0].key {
                            videoButton(trailerKey: trailerKey)
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.black)
                    .opacity(0.1))
            
            Spacer()
            
            AsyncUIImage(movie: vm.movie, imageType: .poster)
                .frame(width: 100)
        }
    }
        
    private var movieOverview: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(vm.movieDetail?.overview ?? "")
                .padding(EdgeInsets(top: 30, leading: 8, bottom: 0, trailing: 8))
                .lineLimit(showFullDescription ? nil : 3)
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription.toggle()
                }
            } label: {
                Text(showFullDescription ? "Less" : "Read more...")
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.accent.opacity(((vm.movieDetail?.overview) != "") ? 1.0 : 0.0))
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 30, trailing: 0))
            .tint(.blue)
            
        }

    }
    
    private func videoButton(trailerKey: String) -> some View {
        Link(destination: URL(string: "https://youtu.be/\(trailerKey)")!, label: {
            HStack(spacing: 3) {
                Image(systemName: "play.fill")
                Text("Trailer")
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .padding(3)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(.black.opacity(0.8))
            )
        })
    }
    
    private func castList(cast: [Cast]) -> some View {
        ForEach(cast, id: \.creditID) { cast in
                CastRowView(cast: cast)
                .onTapGesture {
                    segue(personID: cast.id!)
                }
        }
    }
    
    private func crewList(crew: [Crew]) -> some View {
        ForEach(crew, id: \.creditID) { crew in
            CrewRowView(crew: crew)
                .onTapGesture {
                    segue(personID: crew.id!)
                }
        }
    }
    
    private func segue(personID: Int) {
        selectedPersonID = personID
        showPersonDetailView.toggle()
    }
}

enum ListType: String, Equatable, CaseIterable {
    case cast = "Cast"
    case crew = "Crew"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}



#Preview {
    Group {
        let vm = HomeViewModel()
        MovieDetailVeiw(movie: vm.exampleMovie)
    }
}

