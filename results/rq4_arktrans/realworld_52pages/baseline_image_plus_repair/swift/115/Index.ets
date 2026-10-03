import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

// Define data models to match the SwiftUI structure
export interface Movie {
  backdropPath?: string;
  id: number;
  overview?: string;
  posterPath?: string;
  releaseDate?: string;
  title?: string;
}

export interface Genre {
  id: number;
  name?: string;
}

interface MovieData {
  runtime: number;
  genres: Genre[];
}

// Mock API service
class MovieAPI {
  static async movie(id: number): Promise<MovieData> {
    // Simulate network delay
    await new Promise<void>(resolve => setTimeout(resolve, 100));
    return {
      runtime: 120,
      genres: [
        { id: 1, name: "Action" },
        { id: 2, name: "Adventure" }
      ]
    };
  }
}

const Constants = {
  imagesBaseUrl: "https://image.tmdb.org/t/p/original"
};

@Entry
@Component
struct MovieDetailsView {
  @State private item: Movie = {
    backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
    id: 0,
    overview: "An epic journey through space and time.",
    posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
    releaseDate: "2024-06-15",
    title: "The Awesome Movie"
  };
  
  @State private movieData: MovieData | null = null;
  @State private isLoading: boolean = true;
  
  aboutToAppear() {
    this.loadMovieData();
  }

  private async loadMovieData() {
    try {
      const data = await MovieAPI.movie(this.item.id);
      this.movieData = data;
      this.isLoading = false;
    } catch (error) {
      console.error("Failed to load movie data");
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          // Backdrop Image Section
          Row() {
            if (this.item.backdropPath && this.item.backdropPath.length > 0) {
              Image(`${Constants.imagesBaseUrl}${this.item.backdropPath}`)
                .width('100%')
                .height(getWindowHeight())
                .objectFit(ImageFit.Cover)
                .clip(true)
            } else {
              this.bannerPlaceholder()
                .width('100%')
                .height(getWindowHeight())
            }
          }
          .position({ x: 0, y: 0 })
          
          // Overlay Content
          Column({ space: 8 }) {
            // Header with back button
            Row() {
              Button() {
                Text("")
              }
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .width(40)
              .height(40)
              .borderRadius(20)
              .onClick(() => {
                router.back();
              })
              .margin({ left: 16, top: 40 })
              
              Image($r('app.media.ic_arrow_left'))
                .width(32)
                .height(32)
                .fillColor('#FFC107') // Yellow color
            
              Blank()
            }
            .width('100%')
            
            Blank()
            
            // Title
            Text(this.item.title ?? "Loading...")
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ left: 16, right: 16 })
              .opacity(this.isLoading ? 0.3 : 1)
            
            // Runtime or Skeleton
            if (this.isLoading) {
              this.skeletonLine()
                .margin({ left: 16, right: 16 })
            } else {
              Text(`${this.movieData?.runtime ?? 0} min`)
                .fontSize(15)
                .fontColor(Color.Gray)
                .margin({ left: 16, right: 16 })
            }
            
            // Genres or Skeleton
            if (this.isLoading) {
              this.skeletonLine()
                .width(180)
                .margin({ left: 16, right: 16 })
            } else {
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                ForEach(this.movieData?.genres ?? [], (genre: Genre) => {
                  Row() {
                    Text(genre.name ?? "")
                      .fontSize(15)
                      .fontColor(Color.Gray)
                    
                    if (genre !== this.movieData?.genres[this.movieData!.genres.length - 1]) {
                      Circle()
                        .width(5)
                        .height(5)
                        .fillColor('#FFC107') // Yellow color
                        .margin({ left: 8, right: 8 })
                    }
                  }
                })
              }
              .margin({ left: 16, right: 16 })
            }
            
            // Overview section
            if (this.isLoading) {
              this.skeletonBlock()
                .padding(16)
            } else {
              Text(this.item.overview ?? "")
                .fontColor(Color.Gray)
                .padding(16)
            }
            
            Blank()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .linearGradient({
            angle: 90,
            colors: [['#202124', 0], ['transparent', 1]]
          })
          .position({ x: 0, y: getWindowHeight() / 2 - 200 })
          .zIndex(1)
        }
        .width('100%')
        .height('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#202124') // Background color
    .ignoresSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  bannerPlaceholder() {
    Rectangle()
      .fill(Color.Gray)
      .opacity(0.3)
  }

  @Builder
  skeletonLine() {
    RoundedRectangle({ cornerRadius: 4 })
      .fill(Color.Gray)
      .opacity(0.3)
      .height(14)
  }

  @Builder
  skeletonBlock() {
    Column({ space: 8 }) {
      this.skeletonLine()
      this.skeletonLine().width('90%')
      this.skeletonLine().width('70%')
      this.skeletonLine().width('50%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// Helper function to get window height
function getWindowHeight(): number {
  let context = getContext(null) as common.UIAbilityContext;
  let windowClass = context.getWindowSync() as window.Window;
  return windowClass.getWindowProperties().windowRect.height;
}