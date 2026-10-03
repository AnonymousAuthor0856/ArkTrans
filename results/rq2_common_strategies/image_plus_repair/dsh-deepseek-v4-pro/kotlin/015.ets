interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibraryPage {
  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  @Builder
  VideoCard(item: VideoItem) {
    Column({ space: 8 }) {
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .opacity(0.6)
      }
      .width('100%')
      .height(120)
      .backgroundColor('#E0F2FE')
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#082F49')

      Text(item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#082F49')
        .opacity(0.7)

      Button('Play')
        .width('100%')
        .height(40)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001F2F')
        .backgroundColor('#38BDF8')
        .borderRadius(8)
        .onClick(() => {})
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  build() {
    Column() {
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      Column({ space: 12 }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              this.VideoCard(item)
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({ angle: 180, colors: [['#E0F2FE', 0], ['#F0F9FF', 1]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
