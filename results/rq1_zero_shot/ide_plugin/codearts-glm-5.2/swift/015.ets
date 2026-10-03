class AppTokens {
  static readonly Colors = {
    primary: '#FF38BDF8',
    secondary: '#FF0EA5E9',
    tertiary: '#FF0369A1',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBFE0F4',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FF001F2F',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF082F49',
    onSurface: '#FF082F49',
    onSurface70: '#B3082F49',
    onSurface60: '#99082F49'
  }
}

class VideoItem {
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

@Component
struct VideoCard {
  @Prop title: string
  @Prop duration: string
  @Prop cardIndex: number
  @State showDialog: boolean = false
  @State selectedVideo: string = ''

  build() {
    Column() {
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface60)
      }
      .width('100%')
      .height(120)
      .borderRadius(8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })

      Text(this.duration)
        .fontSize(13)
        .fontColor(AppTokens.Colors.onSurface70)
        .margin({ top: 4 })

      Button('Play') {
      }
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onPrimary)
      .width('100%')
      .height(32)
      .borderRadius(8)
      .backgroundColor(AppTokens.Colors.primary)
      .margin({ top: 8 })
      .onClick(() => {
        this.selectedVideo = this.title
        this.showDialog = true
      })
    }
    .layoutWeight(1)
    .padding(12)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct VideoLibraryRoot {
  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ]

  build() {
    Column() {
      Row()
        .height(30)

      Stack() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(70)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .alignContent(Alignment.Center)

      Column() {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Scroll() {
          Column() {
            Row() {
              VideoCard({ title: this.videos[0].title, duration: this.videos[0].duration, cardIndex: 0 })
                .margin({ right: 6 })
              VideoCard({ title: this.videos[1].title, duration: this.videos[1].duration, cardIndex: 1 })
                .margin({ left: 6 })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 12 })

            Row() {
              VideoCard({ title: this.videos[2].title, duration: this.videos[2].duration, cardIndex: 2 })
                .margin({ right: 6 })
              VideoCard({ title: this.videos[3].title, duration: this.videos[3].duration, cardIndex: 3 })
                .margin({ left: 6 })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 12 })

            Row() {
              VideoCard({ title: this.videos[4].title, duration: this.videos[4].duration, cardIndex: 4 })
                .margin({ right: 6 })
              VideoCard({ title: this.videos[5].title, duration: this.videos[5].duration, cardIndex: 5 })
                .margin({ left: 6 })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }
          .padding({ top: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}