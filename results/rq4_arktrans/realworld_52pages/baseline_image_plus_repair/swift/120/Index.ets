// MovieDetailView.ets
import { router } from '@kit.ArkUI';

interface MovieDetailData {
  id: number;
  title: string;
  overview?: string;
  posterURL?: string;
  rating?: number;
  duration: string;
  genres: string[];
  releasedAt: string;
  language: string;
}

@Entry
@Component
struct MovieDetailView {
  @State movieID: number = 550;
  @State movie: MovieDetailData | null = null;
  @State isLoading: boolean = true;

  aboutToAppear() {
    // Simulate loading delay
    setTimeout(() => {
      this.movie = MovieDetail.lookup(this.movieID);
      this.isLoading = false;
    }, 800);
  }

  build() {
    Column() {
      if (this.isLoading) {
        this.skeletonDetail()
      } else if (this.movie) {
        this.movieDetail(this.movie)
      }
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  movieDetail(movie: MovieDetailData) {
    Scroll() {
      Column({ space: 16 }) {
        this.poster(movie)
        this.titleSection(movie)
        this.metadataBar(movie)
        this.genresBar(movie)
        this.ratingSection(movie)
        this.overviewSection(movie)
      }
      .padding({ bottom: 32 })
    }
    .width('100%')
  }

  @Builder
  poster(movie: MovieDetailData) {
    if (movie.posterURL) {
      Image(movie.posterURL)
        .width('100%')
        .height(400)
        .objectFit(ImageFit.Cover)
    } else {
      this.bannerPlaceholder()
    }
  }

  @Builder
  bannerPlaceholder() {
    Rectangle()
      .fillColor('#E0E0E0')
      .width('100%')
      .height(400)
  }

  @Builder
  titleSection(movie: MovieDetailData) {
    Text(movie.title)
      .fontSize(34)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
      .padding({ left: 16, right: 16 })
  }

  @Builder
  metadataBar(movie: MovieDetailData) {
    Row({ space: 8 }) {
      Text(movie.releasedAt)
        .fontSize(15)
        .fontColor(Color.Gray)
      Text("·")
        .fontSize(15)
        .fontColor(Color.Gray)
      Text(movie.language)
        .fontSize(15)
        .fontColor(Color.Gray)
      Text("·")
        .fontSize(15)
        .fontColor(Color.Gray)
      Text(movie.duration)
        .fontSize(15)
        .fontColor(Color.Gray)
    }
    .padding({ left: 16, right: 16 })
  }

  @Builder
  genresBar(movie: MovieDetailData) {
    Scroll() {
      Row({ space: 8 }) {
        ForEach(movie.genres, (genre: string) => {
          Text(genre)
            .fontSize(12)
            .padding({ left: 10, right: 10, top: 5, bottom: 5 })
            .border({ width: 1, color: Color.Gray, radius: 8 })
        })
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  ratingSection(movie: MovieDetailData) {
    if (movie.rating !== undefined) {
      Row() {
        Text(`⭐️ ${movie.rating.toFixed(1)}/10`)
          .fontSize(17)
        Blank()
      }
      .padding({ left: 16, right: 16 })
    }
  }

  @Builder
  overviewSection(movie: MovieDetailData) {
    if (movie.overview && movie.overview.length > 0) {
      Column({ space: 8 }) {
        Text("Overview")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        
        Text(movie.overview)
          .fontSize(17)
          .fontColor(Color.Black)
      }
      .padding({ left: 16, right: 16 })
    }
  }

  @Builder
  skeletonDetail() {
    Scroll() {
      Column({ space: 16 }) {
        this.bannerPlaceholder()
        
        Column({ space: 8 }) {
          this.skeletonLine('100%')
          this.skeletonLine(220)
          
          Row({ space: 8 }) {
            this.skeletonLine(80)
            this.skeletonLine(80)
            this.skeletonLine(60)
          }
          .padding({ top: 4 })
          
          Row({ space: 8 }) {
            this.skeletonBlock(60, 24)
            this.skeletonBlock(80, 24)
            this.skeletonBlock(50, 24)
          }
          .padding({ top: 4 })
          
          this.skeletonLine(60)
            .padding({ top: 8 })
          
          Column({ space: 6 }) {
            this.skeletonLine('100%')
            this.skeletonLine('100%')
            this.skeletonLine('100%')
            this.skeletonLine(200)
          }
          .padding({ top: 8 })
        }
        .padding({ left: 16, right: 16 })
      }
    }
  }

  @Builder
  skeletonBlock(width: number, height: number) {
    Capsule()
      .fillColor('#E0E0E0')
      .width(width)
      .height(height)
  }

  @Builder
  skeletonLine(width: Length) {
    Capsule()
      .fillColor('#E0E0E0')
      .height(14)
      .width(width)
  }
}

class MovieDetail {
  static lookup(id: number): MovieDetailData {
    return MovieDetail.database[id] || MovieDetail.database[550];
  }

  private static database: Record<number, MovieDetailData> = {
    550: {
      id: 550,
      title: "Fight Club",
      overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
      posterURL: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
      rating: 8.4,
      duration: "2h 19m",
      genres: ["Drama", "Thriller", "Comedy"],
      releasedAt: "1999-10-15",
      language: "English"
    },
    680: {
      id: 680,
      title: "Pulp Fiction",
      overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
      posterURL: "https://image.tmdb.org/t/p/original/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg",
      rating: 8.5,
      duration: "2h 34m",
      genres: ["Crime", "Thriller"],
      releasedAt: "1994-09-10",
      language: "English"
    },
    238: {
      id: 238,
      title: "The Godfather",
      overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch Vito Corleone barely survives an attempt on his life, his youngest son Michael steps in to take care of the would-be killers.",
      posterURL: "https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      rating: 8.7,
      duration: "2h 55m",
      genres: ["Drama", "Crime"],
      releasedAt: "1972-03-14",
      language: "English"
    },
    278: {
      id: 278,
      title: "The Shawshank Redemption",
      overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an unprincipled warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates.",
      posterURL: "https://image.tmdb.org/t/p/original/9cjIGRiQvEZsl40AYhYmINEYmfC.jpg",
      rating: 8.7,
      duration: "2h 22m",
      genres: ["Drama", "Crime"],
      releasedAt: "1994-09-23",
      language: "English"
    },
    155: {
      id: 155,
      title: "The Dark Knight",
      overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
      posterURL: "https://image.tmdb.org/t/p/original/qJ2tW6WMUDux911BytGLO2oqoVS.jpg",
      rating: 8.5,
      duration: "2h 32m",
      genres: ["Action", "Crime", "Drama"],
      releasedAt: "2008-07-16",
      language: "English"
    },
    13: {
      id: 13,
      title: "Forrest Gump",
      overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events — in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
      posterURL: "https://image.tmdb.org/t/p/original/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
      rating: 8.5,
      duration: "2h 22m",
      genres: ["Drama", "Romance", "Comedy"],
      releasedAt: "1994-07-06",
      language: "English"
    },
    497: {
      id: 497,
      title: "The Green Mile",
      overview: "A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments. When the cellblock's head guard, Paul Edgecomb, recognizes Coffey's miraculous gift, he tries desperately to help stave off the condemned man's execution.",
      posterURL: "https://image.tmdb.org/t/p/original/velWPhVMQeQKcxggNEU8YmIo52R.jpg",
      rating: 8.5,
      duration: "3h 9m",
      genres: ["Drama", "Crime", "Fantasy"],
      releasedAt: "1999-12-10",
      language: "English"
    },
    122: {
      id: 122,
      title: "The Lord of the Rings: The Return of the King",
      overview: "As armies mass for a final battle that will decide the fate of the world, Frodo and Sam, guided by Gollum, continue their dangerous mission toward the fires of Mount Doom to destroy the One Ring.",
      posterURL: "https://image.tmdb.org/t/p/original/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
      rating: 8.5,
      duration: "3h 21m",
      genres: ["Adventure", "Fantasy", "Action"],
      releasedAt: "2003-12-01",
      language: "English"
    },
    769: {
      id: 769,
      title: "GoodFellas",
      overview: "The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and goes on to become a big-time mobster, participating in a dizzying array of criminal activities before his eventual downfall.",
      posterURL: "https://image.tmdb.org/t/p/original/aKuFiU82s5ISJDxSdz4O5xwQnJr.jpg",
      rating: 8.5,
      duration: "2h 25m",
      genres: ["Drama", "Crime"],
      releasedAt: "1990-09-12",
      language: "English"
    },
    157336: {
      id: 157336,
      title: "Interstellar",
      overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.",
      posterURL: "https://image.tmdb.org/t/p/original/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      rating: 8.4,
      duration: "2h 49m",
      genres: ["Adventure", "Drama", "Science Fiction"],
      releasedAt: "2014-11-05",
      language: "English"
    }
  };
}