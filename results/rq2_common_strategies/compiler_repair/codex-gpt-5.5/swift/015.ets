class VideoItem {
  id: number
  title: string
  duration: string

  constructor(id: number, title: string, duration: string) {
    this.id = id
    this.title = title
    this.duration = duration
  }
}

@Entry
@Component
struct Index {
  @State showDialog: boolean = false
  @State selectedVideo: string = ''

  private cPrimary: string = '#38BDF8'
  private cSecondary: string = '#0EA5E9'
  private cBackground: string = '#F0F9FF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E0F2FE'
  private cText: string = '#082F49'
  private videos: VideoItem[] = [
    new VideoItem(1, 'Nature Documentary', '24:18'),
    new VideoItem(2, 'AI Explained', '18:52'),
    new VideoItem(3, 'Space Travel', '31:09'),
    new VideoItem(4, 'Modern Art Review', '15:45'),
    new VideoItem(5, 'Retro Music Visuals', '22:10'),
    new VideoItem(6, 'Daily News Recap', '12:34')
  ]

  @Builder
  VideoCard(video: VideoItem) {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height(120)
          .radius(8)
          .fill(this.cSurfaceVariant)
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
      }
      .width('100%')
      .height(120)

      Text(video.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cText)
        .width('100%')
        .maxLines(2)
        .margin({ top: 8 })

      Text(video.duration)
        .fontSize(13)
        .fontColor('#B3082F49')
        .width('100%')
        .margin({ top: 8 })

      Button('Play')
        .width('100%')
        .height(32)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001F2F')
        .backgroundColor(this.cPrimary)
        .borderRadius(8)
        .margin({ top: 8 })
        .onClick(() => {
          this.selectedVideo = video.title
          this.showDialog = true
        })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.cSurface)
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
  }

  @Builder
  PlayingDialog() {
    if (this.showDialog) {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#66000000')
        Column() {
          Text('Playing Video')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
            .textAlign(TextAlign.Center)
            .width('100%')
          Text('Now playing: ' + this.selectedVideo)
            .fontSize(14)
            .fontColor(this.cText)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 12, bottom: 20 })
          Button('OK')
            .width(120)
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(this.cSecondary)
            .borderRadius(8)
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width(280)
        .padding(20)
        .backgroundColor(this.cSurface)
        .borderRadius(16)
      }
      .width('100%')
      .height('100%')
    }
  }

  build() {
    Stack() {
      Column() {
        Blank().height(30)
        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height(70)
            .fill(this.cSurfaceVariant)
          Text('Video Library')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
        }
        .width('100%')
        .height(70)

        Column() {
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })

          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  this.VideoCard(video)
                }
              }, (video: VideoItem) => video.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          }
          .layoutWeight(1)
        }
        .layoutWeight(1)
        .backgroundColor(this.cBackground)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBackground)

      this.PlayingDialog()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
