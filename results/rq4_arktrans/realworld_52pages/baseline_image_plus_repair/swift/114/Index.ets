// entry/src/main/ets/model/Movie.ts
export interface Movie {
  id: number;
  title?: string;
  overview?: string;
  releaseDate?: string;
  backdropPath?: string;
  posterPath?: string;
}

// entry/src/main/ets/constants/Constants.ts
export class Constants {
  static readonly baseURl = "https://api.themoviedb.org/3";
  static readonly imagesBaseUrl = "https://image.tmdb.org/t/p/w500";
  static readonly apiKey = "YOUR_API_KEY_HERE"; // Replace with your actual API key
}

// entry/src/main/ets/components/FeaturedSection.ets
import { Movie } from '../model/Movie';
import { Constants } from '../constants/Constants';

@Component
export struct FeaturedSection {
  @State movies: Movie[] = [];
  @State pageSelected: number = 0;

  build() {
    Column() {
      if (this.movies.length > 0) {
        Swiper() {
          ForEach(this.movies.slice(0, Math.min(4, this.movies.length)), (item: Movie, index: number) => {
            this.featuredCard(item, index)
          })
        }
        .autoPlay(true)
        .indicator(false)
        .onChange((index: number) => {
          this.pageSelected = index;
        })
      }

      Column() {
        Row() {
          Image($r('app.media.play_circle')) // You need to add a play circle icon resource
            .width(45)
            .height(45)
            .fillColor('#FFD700')
            .shadow({ radius: 5, color: '#000000' })
          
          Text("Movie")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 8 })
          
          Text("App")
            .fontSize(28)
            .fontColor(Color.White)
        }
        .padding({ top: 44, left: 16, right: 16 })

        Blank()

        Row() {
          ForEach([0, 1, 2, 3], (index: number) => {
            this.indicatorCapsule(index)
          })
        }
        .justifyContent(FlexAlign.End)
        .padding({ bottom: 30 })
        .linearGradient({
          angle: 90,
          colors: [['#1F2329', 0], ['transparent', 1]]
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .height('55%') // Approximate equivalent of UIScreen.main.bounds.height / 1.8
    .position({ x: 0, y: 0 })
    .width('100%')
  }

  @Builder
  indicatorCapsule(index: number) {
    Capsule()
      .width(22)
      .height(6)
      .fillColor(this.pageSelected === index ? '#FFD700' : '#808080')
      .margin({ right: 8 })
  }

  @Builder
  featuredCard(item: Movie, index: number) {
    Stack({ alignContent: Alignment.BottomStart }) {
      Image(`${Constants.imagesBaseUrl}${item.backdropPath || ''}`)
        .objectFit(ImageFit.Cover)
        .width('100%')
        .height('100%')

      Column() {
        Text(item.title || "Loading...")
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 16 })
        
        Text(item.releaseDate || "Loading...")
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ left: 16 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 40 })
    }
    .onClick(() => {
      // Navigation logic would go here
    })
  }
}

// entry/src/main/ets/components/MovieListSection.ets
import { Movie } from '../model/Movie';

export enum MovieListLayout {
  HORIZONTAL,
  VERTICAL
}

@Component
export struct MovieListSection {
  title: string = "";
  movies: Movie[] = [];
  layout: MovieListLayout = MovieListLayout.HORIZONTAL;

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        
        Blank()
      }
      .padding({ left: 16, right: 16 })

      Scroll() {
        Row() {
          ForEach(this.movies.length > 0 ? this.movies : this.placeholderMovies, (item: Movie) => {
            MovieCardView({ item: item, layout: this.layout })
              .margin({ right: 15 })
          })
        }
        .padding({ left: 16, right: 16 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

      Blank()
    }
  }

  get placeholderMovies(): Movie[] {
    const placeholders: Movie[] = [];
    for (let i = 0; i < 10; i++) {
      placeholders.push({
        id: 0,
        overview: undefined,
        title: undefined
      });
    }
    return placeholders;
  }
}

// entry/src/main/ets/components/MovieCardView.ets
import { Movie } from '../model/Movie';
import { Constants } from '../constants/Constants';
import { MovieListLayout } from './MovieListSection';

@Component
export struct MovieCardView {
  item: Movie = {} as Movie;
  layout: MovieListLayout = MovieListLayout.HORIZONTAL;

  get imagePath(): string | undefined {
    return this.layout === MovieListLayout.HORIZONTAL ? this.item.backdropPath : this.item.posterPath;
  }

  get isHorizontal(): boolean {
    return this.layout === MovieListLayout.HORIZONTAL;
  }

  build() {
    Column() {
      Image(`${Constants.imagesBaseUrl}${this.imagePath || ''}`)
        .objectFit(ImageFit.Cover)
        .width(this.isHorizontal ? 200 : 160)
        .height(this.isHorizontal ? 120 : 240)
        .borderRadius(8)

      Row() {
        Column() {
          Text(this.item.title || "Loading...")
            .fontSize(this.isHorizontal ? 17 : 15)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          
          Text(this.item.overview || "Loading...")
            .fontSize(this.isHorizontal ? 15 : 13)
            .maxLines(2)
            .fontColor(Color.Gray)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(HorizontalAlign.Start)
        .spacing(4)
        
        Blank()
      }
    }
    .width(this.isHorizontal ? 200 : 160)
  }
}

// entry/src/main/ets/pages/HomePage.ets
import { Movie } from '../model/Movie';
import { FeaturedSection } from '../components/FeaturedSection';
import { MovieListSection, MovieListLayout } from '../components/MovieListSection';
import { Constants } from '../constants/Constants';
import { http } from '@kit.BasicServicesKit';

@Entry
@Component
struct HomePage {
  @State featuredMovies: Movie[] = [];
  @State popularMovies: Movie[] = [];
  @State newReleases: Movie[] = [];

  aboutToAppear() {
    this.loadData();
  }

  async loadData() {
    try {
      const promises = [
        this.discoverMovies("popularity.desc"),
        this.discoverMovies("popularity.desc"),
        this.discoverMovies("release_date.desc")
      ];
      
      const results = await Promise.all(promises);
      
      this.featuredMovies = results[0];
      this.popularMovies = results[1];
      this.newReleases = results[2];
    } catch (error) {
      console.error('Error loading data:', error);
    }
  }

  async discoverMovies(sortBy: string): Promise<Movie[]> {
    const url = `${Constants.baseURl}/discover/movie?api_key=${Constants.apiKey}&language=en-US&sort_by=${sortBy}&include_adult=false&include_video=false&page=1`;
    
    try {
      const request = http.createHttp();
      const response = await request.request(url, {
        method: http.RequestMethod.GET,
        expectDataType: http.HttpDataType.JSON
      });
      
      if (response.responseCode === 200) {
        const result = response.result as Record<string, unknown>;
        const resultsArray = result['results'] as Array<Record<string, unknown>> | undefined;
        
        if (!resultsArray) {
          return [];
        }

        const movies: Movie[] = [];
        for (const res of resultsArray) {
          const movie: Movie = {
            id: res['id'] as number || 0,
            title: res['title'] as string | undefined,
            overview: res['overview'] as string | undefined,
            releaseDate: res['release_date'] as string | undefined,
            backdropPath: res['backdrop_path'] as string | undefined,
            posterPath: res['poster_path'] as string | undefined
          };
          movies.push(movie);
        }
        return movies;
      } else {
        throw new Error(`HTTP error: ${response.responseCode}`);
      }
    } catch (error) {
      console.error('API error:', error);
      return [];
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          FeaturedSection({ movies: this.featuredMovies })
          
          MovieListSection({
            title: "Popular",
            movies: this.popularMovies,
            layout: MovieListLayout.HORIZONTAL
          })
          
          MovieListSection({
            title: "New Releases",
            movies: this.newReleases,
            layout: MovieListLayout.VERTICAL
          })
        }
        .padding({ bottom: 16 })
      }
      .scrollBar(BarState.Off)
    }
    .backgroundColor('#1F2329')
    .width('100%')
    .height('100%')
  }
}