//
//  MovieDetailView.swift
//  ModernMVVMList
//
//  Created by Vadim Bulavin on 3/18/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let movieID: Int

    @State private var movie: MovieDetail?
    @State private var isLoading = true

    var body: some View {
        content
            .task {
                try? await Task.sleep(nanoseconds: 800_000_000)
                movie = MovieDetail.lookup(movieID)
                isLoading = false
            }
    }

    @ViewBuilder
    private var content: some View {
        if isLoading {
            skeletonDetail
        } else if let movie {
            movieDetail(movie)
        }
    }


    private func movieDetail(_ movie: MovieDetail) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                poster(movie)
                titleSection(movie)
                metadataBar(movie)
                genresBar(movie)
                ratingSection(movie)
                overviewSection(movie)
            }
            .padding(.bottom, 32)
        }
    }

    private func poster(_ movie: MovieDetail) -> some View {
        Group {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        bannerPlaceholder
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 400)
                            .clipped()
                    case .failure:
                        bannerPlaceholder
                            .overlay(Image(systemName: "photo").font(.largeTitle).foregroundColor(.gray))
                    @unknown default:
                        bannerPlaceholder
                    }
                }
            } else {
                bannerPlaceholder
            }
        }
    }

    private var bannerPlaceholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(maxWidth: .infinity)
            .frame(height: 400)
    }

    private func titleSection(_ movie: MovieDetail) -> some View {
        Text(movie.title)
            .font(.largeTitle)
            .bold()
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    private func metadataBar(_ movie: MovieDetail) -> some View {
        HStack(spacing: 8) {
            Text(movie.releasedAt)
            Text("·")
            Text(movie.language)
            Text("·")
            Text(movie.duration)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
        .padding(.horizontal)
    }

    private func genresBar(_ movie: MovieDetail) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(movie.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
        }
    }

    private func ratingSection(_ movie: MovieDetail) -> some View {
        Group {
            if let rating = movie.rating {
                HStack {
                    Text("⭐️ \(String(format: "%.1f", rating))/10")
                        .font(.body)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }

    private func overviewSection(_ movie: MovieDetail) -> some View {
        Group {
            if let overview = movie.overview, !overview.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                    Text(overview)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
            }
        }
    }

    private var skeletonDetail: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                bannerPlaceholder

                VStack(alignment: .leading, spacing: 8) {
                    skeletonLine(width: .infinity)
                    skeletonLine(width: 220)

                    HStack(spacing: 8) {
                        skeletonLine(width: 80)
                        skeletonLine(width: 80)
                        skeletonLine(width: 60)
                    }
                    .padding(.top, 4)

                    HStack(spacing: 8) {
                        skeletonBlock(width: 60, height: 24)
                        skeletonBlock(width: 80, height: 24)
                        skeletonBlock(width: 50, height: 24)
                    }
                    .padding(.top, 4)

                    skeletonLine(width: 60)
                        .padding(.top, 8)

                    VStack(spacing: 6) {
                        skeletonLine(width: .infinity)
                        skeletonLine(width: .infinity)
                        skeletonLine(width: .infinity)
                        skeletonLine(width: 200)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)
            }
        }
    }

    private func skeletonBlock(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
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

struct MovieDetail {
    let id: Int
    let title: String
    let overview: String?
    let posterURL: URL?
    let rating: Double?
    let duration: String
    let genres: [String]
    let releasedAt: String
    let language: String
}


extension MovieDetail {
    static func lookup(_ id: Int) -> MovieDetail {
        database[id] ?? database[550]!
    }

    private static let database: [Int: MovieDetail] = [
        550: MovieDetail(
            id: 550,
            title: "Fight Club",
            overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"),
            rating: 8.4,
            duration: "2h 19m",
            genres: ["Drama", "Thriller", "Comedy"],
            releasedAt: "1999-10-15",
            language: "English"
        ),
        680: MovieDetail(
            id: 680,
            title: "Pulp Fiction",
            overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"),
            rating: 8.5,
            duration: "2h 34m",
            genres: ["Crime", "Thriller"],
            releasedAt: "1994-09-10",
            language: "English"
        ),
        238: MovieDetail(
            id: 238,
            title: "The Godfather",
            overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch Vito Corleone barely survives an attempt on his life, his youngest son Michael steps in to take care of the would-be killers.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"),
            rating: 8.7,
            duration: "2h 55m",
            genres: ["Drama", "Crime"],
            releasedAt: "1972-03-14",
            language: "English"
        ),
        278: MovieDetail(
            id: 278,
            title: "The Shawshank Redemption",
            overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an unprincipled warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/9cjIGRiQvEZsl40AYhYmINEYmfC.jpg"),
            rating: 8.7,
            duration: "2h 22m",
            genres: ["Drama", "Crime"],
            releasedAt: "1994-09-23",
            language: "English"
        ),
        155: MovieDetail(
            id: 155,
            title: "The Dark Knight",
            overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/qJ2tW6WMUDux911BytGLO2oqoVS.jpg"),
            rating: 8.5,
            duration: "2h 32m",
            genres: ["Action", "Crime", "Drama"],
            releasedAt: "2008-07-16",
            language: "English"
        ),
        13: MovieDetail(
            id: 13,
            title: "Forrest Gump",
            overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events — in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg"),
            rating: 8.5,
            duration: "2h 22m",
            genres: ["Drama", "Romance", "Comedy"],
            releasedAt: "1994-07-06",
            language: "English"
        ),
        497: MovieDetail(
            id: 497,
            title: "The Green Mile",
            overview: "A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments. When the cellblock's head guard, Paul Edgecomb, recognizes Coffey's miraculous gift, he tries desperately to help stave off the condemned man's execution.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/velWPhVMQeQKcxggNEU8YmIo52R.jpg"),
            rating: 8.5,
            duration: "3h 9m",
            genres: ["Drama", "Crime", "Fantasy"],
            releasedAt: "1999-12-10",
            language: "English"
        ),
        122: MovieDetail(
            id: 122,
            title: "The Lord of the Rings: The Return of the King",
            overview: "As armies mass for a final battle that will decide the fate of the world, Frodo and Sam, guided by Gollum, continue their dangerous mission toward the fires of Mount Doom to destroy the One Ring.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg"),
            rating: 8.5,
            duration: "3h 21m",
            genres: ["Adventure", "Fantasy", "Action"],
            releasedAt: "2003-12-01",
            language: "English"
        ),
        769: MovieDetail(
            id: 769,
            title: "GoodFellas",
            overview: "The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and goes on to become a big-time mobster, participating in a dizzying array of criminal activities before his eventual downfall.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/aKuFiU82s5ISJDxSdz4O5xwQnJr.jpg"),
            rating: 8.5,
            duration: "2h 25m",
            genres: ["Drama", "Crime"],
            releasedAt: "1990-09-12",
            language: "English"
        ),
        157336: MovieDetail(
            id: 157336,
            title: "Interstellar",
            overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.",
            posterURL: URL(string: "https://image.tmdb.org/t/p/original/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"),
            rating: 8.4,
            duration: "2h 49m",
            genres: ["Adventure", "Drama", "Science Fiction"],
            releasedAt: "2014-11-05",
            language: "English"
        ),
    ]
}


#Preview {
    MovieDetailView(movieID: 550)
}
