class VideoItem {
  id: number;
  title: string;
  duration: string;

  constructor(id: number, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct VideoLibraryRoot {
  @State private showDialog: boolean = false;
  @State private selectedVideo: string = '';

  private videos: VideoItem[] = [
    new VideoItem(1, 'Nature Documentary', '24:18'),
    new VideoItem(2, 'AI Explained', '18:52'),
    new VideoItem(3, 'Space Travel', '31:09'),
    new VideoItem(4, 'Modern Art Review', '15:45'),
    new VideoItem(5, 'Retro Music Visuals', '22:10'),
    new VideoItem(6, 'Daily News Recap', '12:34')
  ];

  @Builder
  VideoCard(video: VideoItem) {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(120)
          .fill('#E0F2FE')
          .radius(8)
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
        .fontColor('#082F49')
        .width('100%')
        .maxLines(2)
        .margin({ top: 8 })
      Text(video.duration)
        .fontSize(13)
        .fontColor('#B3082F49')
        .margin({ top: 8 })
      Button('Play')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001F2F')
        .backgroundColor('#38BDF8')
        .width('100%')
        .height(32)
        .borderRadius(8)
        .margin({ top: 8 })
        .onClick(() => {
          this.selectedVideo = video.title;
          this.showDialog = true;
        })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  PlayDialog() {
    if (this.showDialog) {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#66000000')
        Column() {
          Text('Playing Video')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#082F49')
          Text('Now playing: ' + this.selectedVideo)
            .fontSize(14)
            .fontColor('#082F49')
            .textAlign(TextAlign.Center)
            .margin({ top: 12 })
          Button('OK')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#0EA5E9')
            .height(36)
            .padding({ left: 24, right: 24 })
            .borderRadius(8)
            .margin({ top: 18 })
            .onClick(() => {
              this.showDialog = false;
            })
        }
        .width('78%')
        .padding(24)
        .backgroundColor('#FFFFFF')
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
        Stack() {
          Rect()
            .width('100%')
            .height(70)
            .fill('#E0F2FE')
          Text('Video Library')
            .fontSize(26)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#082F49')
        }
        .height(70)

        Column() {
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#082F49')
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
        .backgroundColor('#F0F9FF')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F9FF')

      this.PlayDialog()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
