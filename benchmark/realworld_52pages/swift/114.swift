

import SwiftUI

struct HomeView: View {
    @State private var featuredMovies: [Movie] = []
    @State private var popularMovies: [Movie] = []
    @State private var newReleases: [Movie] = []

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    FeaturedSection(movies: featuredMovies)
                    MovieListSection(title: "Popular", movies: popularMovies, layout: .horizontal)
                    MovieListSection(title: "New Releases", movies: newReleases, layout: .vertical)
                }
                .padding(.bottom)
            }
            .background(Color("background"))
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .all)
        }
        .task {
            featuredMovies = await MovieAPI.discover(sortBy: "popularity.desc")
            popularMovies = await MovieAPI.discover(sortBy: "popularity.desc")
            newReleases  = await MovieAPI.discover(sortBy: "release_date.desc")
        }
    }
}


struct FeaturedSection: View {
    let movies: [Movie]
    @State private var pageSelected: Int = 0

    var body: some View {
        ZStack {
            if !movies.isEmpty {
                TabView(selection: $pageSelected) {
                    ForEach(0..<min(4, movies.count), id: \.self) { index in
                        featuredCard(movies[index], index: index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }

            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Image(systemName: "play.circle")
                        .font(.system(size: 45))
                        .foregroundColor(Color("yellow"))
                        .shadow(color: Color.black, radius: 5)
                    Text("Movie")
                        .font(.title).fontWeight(.bold).foregroundColor(.white)
                        .padding(.leading, 8)
                    Text("App")
                        .font(.title).foregroundColor(.white)
                }
                .padding(.horizontal).padding(.top, 44)

                Spacer()

                HStack(alignment: .center) {
                    Spacer()
                    ForEach(0..<4) { index in
                        Capsule()
                            .frame(width: 22, height: 6)
                            .foregroundColor(pageSelected == index ? .yellow : .gray)
                    }
                }
                .padding().padding(.bottom, 30)
                .background(LinearGradient(gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)),
                    Color.clear
                ]), startPoint: .bottom, endPoint: .top))
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
    }

    @ViewBuilder
    private func featuredCard(_ item: Movie, index: Int) -> some View {
        NavigationLink(destination: MovieDetailsView(item: item)) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdropPath ?? "")")) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .tag(index)

                VStack(alignment: .leading) {
                    Text(item.title ?? "Loading...")
                        .font(.system(size: 19)).fontWeight(.bold)
                        .foregroundColor(.white)
                        .redacted(reason: item.title == nil ? .placeholder : .init())
                        .padding(.leading)
                    Text(item.releaseDate ?? "Loading...")
                        .font(.system(size: 17)).fontWeight(.bold)
                        .foregroundColor(.gray)
                        .redacted(reason: item.releaseDate == nil ? .placeholder : .init())
                        .padding(.leading)
                }
                .padding(.bottom, 40)
            }
        }
    }
}


enum MovieListLayout {
    case horizontal, vertical
}

struct MovieListSection: View {
    let title: String
    let movies: [Movie]
    var layout: MovieListLayout = .horizontal

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2).fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies.isEmpty ? placeholderMovies : movies) { item in
                        NavigationLink(destination: MovieDetailsView(item: item)) {
                            MovieCardView(item: item, layout: layout)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }

    private var placeholderMovies: [Movie] {
        Array(repeating: Movie(id: 0, overview: nil, title: nil), count: 10)
    }
}


struct MovieCardView: View {
    let item: Movie
    var layout: MovieListLayout = .horizontal

    private var imagePath: String? {
        layout == .horizontal ? item.backdropPath : item.posterPath
    }

    private var isHorizontal: Bool { layout == .horizontal }

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(imagePath ?? "")")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: isHorizontal ? 200 : 160, height: isHorizontal ? 120 : 240)
            .redacted(reason: item.posterPath == nil ? .placeholder : .init())
            .cornerRadius(8)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title ?? "Loading...")
                        .font(.system(size: isHorizontal ? 17 : 15)).fontWeight(.bold)
                        .foregroundColor(.white)
                        .redacted(reason: item.title == nil ? .placeholder : .init())
                    Text(item.overview ?? "Loading...")
                        .font(.system(size: isHorizontal ? 15 : 13)).lineLimit(2)
                        .foregroundColor(.gray)
                        .redacted(reason: item.overview == nil ? .placeholder : .init())
                }
                Spacer()
            }
        }
        .frame(width: isHorizontal ? 200 : 160)
    }
}


enum MovieAPI {
    static func discover(sortBy: String) async -> [Movie] {
        guard let url = URL(string: "\(Constants.baseURl)/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=\(sortBy)&include_adult=false&include_video=false&page=1") else {
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(DiscoverResponse.self, from: data)
            return response.results ?? []
        } catch {
            print("API error:", error)
            return []
        }
    }

    static func movie(id: Int) async -> Movie? {
        guard let url = URL(string: "\(Constants.baseURl)/movie/\(id)?api_key=\(Constants.apiKey)&language=en-US") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Movie.self, from: data)
        } catch {
            print("API error:", error)
            return nil
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
