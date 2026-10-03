//
//  MoviesListView.swift
//  ModernMVVM
//
//  Created by Vadym Bulavin on 2/20/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI


struct MoviesListView: View {
    @State private var movies: [MovieItem] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Trending Movies")
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            movies = MovieItem.demoMovies
            isLoading = false
        }
    }

    @ViewBuilder
    private var content: some View {
        if isLoading {
            skeletonList
        } else {
            movieList
        }
    }

    private var movieList: some View {
        List(movies) { movie in
            NavigationLink {
                MovieDetailView(movieID: movie.id)
            } label: {
                MovieRow(movie: movie)
            }
        }
    }


    private var skeletonList: some View {
        List(0..<8, id: \.self) { _ in
            HStack(spacing: 12) {
                skeletonBlock(width: 100, height: 150)
                VStack(alignment: .leading, spacing: 8) {
                    skeletonLine(width: .infinity)
                    skeletonLine(width: 160)
                    skeletonLine(width: 100)
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func skeletonBlock(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.2))
            .frame(width: width, height: height)
    }

    private func skeletonLine(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 14)
            .frame(maxWidth: width == .infinity ? .infinity : width, alignment: .leading)
    }
}


struct MovieRow: View {
    let movie: MovieItem

    var body: some View {
        HStack(spacing: 12) {
            poster
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(movie.overview)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }

    @ViewBuilder
    private var poster: some View {
        AsyncImage(url: movie.posterURL) { phase in
            switch phase {
            case .empty:
                posterPlaceholder
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipped()
                    .cornerRadius(6)
            case .failure:
                posterPlaceholder
                    .overlay(Image(systemName: "photo").foregroundColor(.gray))
            @unknown default:
                posterPlaceholder
            }
        }
        .frame(width: 100, height: 150)
    }

    private var posterPlaceholder: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.2))
            .frame(width: 100, height: 150)
    }
}


struct MovieItem: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
}


extension MovieItem {
    static let demoMovies: [MovieItem] = [
        MovieItem(
            id: 550,
            title: "Fight Club",
            overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground fight clubs forming in every town.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg")
        ),
        MovieItem(
            id: 680,
            title: "Pulp Fiction",
            overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg")
        ),
        MovieItem(
            id: 238,
            title: "The Godfather",
            overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/3bhkrj58Vtu7enYsRolD1fZdja1.jpg")
        ),
        MovieItem(
            id: 278,
            title: "The Shawshank Redemption",
            overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/9cjIGRiQvEZsl40AYhYmINEYmfC.jpg")
        ),
        MovieItem(
            id: 155,
            title: "The Dark Knight",
            overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/qJ2tW6WMUDux911BytGLO2oqoVS.jpg")
        ),
        MovieItem(
            id: 13,
            title: "Forrest Gump",
            overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg")
        ),
        MovieItem(
            id: 497,
            title: "The Green Mile",
            overview: "A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/velWPhVMQeQKcxggNEU8YmIo52R.jpg")
        ),
        MovieItem(
            id: 122,
            title: "The Lord of the Rings: The Return of the King",
            overview: "As armies mass for a final battle, Frodo and Sam, guided by Gollum, continue their dangerous mission toward the fires of Mount Doom.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg")
        ),
        MovieItem(
            id: 769,
            title: "GoodFellas",
            overview: "The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/aKuFiU82s5ISJDxSdz4O5xwQnJr.jpg")
        ),
        MovieItem(
            id: 157336,
            title: "Interstellar",
            overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w342/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
        ),
    ]
}


#Preview {
    MoviesListView()
}
