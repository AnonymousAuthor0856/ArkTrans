
import SwiftUI

struct MovieDetailsView: View {
    let item: Movie

    @State private var movie: Movie?
    @Environment(\.dismiss) private var dismiss

    private var isLoading: Bool { movie == nil }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                backdropImage
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
                    .overlay(headerOverlay)
                if isLoading {
                    skeletonBlock
                        .padding()
                } else {
                    Text(movie?.overview ?? "")
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .all)
        .task {
            movie = await MovieAPI.movie(id: item.id)
        }
    }

    @ViewBuilder
    private var backdropImage: some View {
        if let path = item.backdropPath, !path.isEmpty {
            AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(path)")) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                bannerPlaceholder
            }
        } else {
            bannerPlaceholder
        }
    }


    private var bannerPlaceholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
    }


    private var headerOverlay: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 32))
                        .foregroundColor(Color("yellow"))
                }
                Spacer()
            }
            .padding(.horizontal).padding(.top, 40)

            Spacer()

            Text(item.title ?? "Loading...")
                .font(.title).fontWeight(.bold)
                .foregroundColor(.white)
                .redacted(reason: item.title == nil ? .placeholder : .init())
                .padding(.horizontal)

            if isLoading {
                skeletonLine
                    .padding(.horizontal)
            } else {
                Text("\(movie?.runtime ?? 0) min")
                    .font(.system(size: 15)).foregroundColor(.gray)
                    .padding(.horizontal)
            }

            if isLoading {
                skeletonLine
                    .frame(width: 180)
                    .padding(.horizontal)
            } else {
                HStack(spacing: 8) {
                    ForEach(movie?.genres ?? [], id: \.id) { genre in
                        Text(genre.name ?? "")
                            .font(.system(size: 15)).foregroundColor(.gray)
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(Color("yellow"))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)),
            Color.clear
        ]), startPoint: .bottom, endPoint: .top))
    }


    private var skeletonLine: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.3))
            .frame(height: 14)
    }

    private var skeletonBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            skeletonLine
            skeletonLine
                .frame(width: UIScreen.main.bounds.width * 0.9)
            skeletonLine
                .frame(width: UIScreen.main.bounds.width * 0.7)
            skeletonLine
                .frame(width: UIScreen.main.bounds.width * 0.5)
        }
    }
}



struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(item: Movie(
            backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
            id: 0,
            overview: "An epic journey through space and time.",
            posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
            releaseDate: "2024-06-15",
            title: "The Awesome Movie"
        ))
    }
}
