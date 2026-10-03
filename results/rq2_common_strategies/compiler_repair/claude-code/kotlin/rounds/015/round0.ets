@Entry
@Component
struct Index {
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
      // Top Bar
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .margin({ bottom: 12 })

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              VideoCard(item: item)
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#F0F9FF', 0.0], ['#E0F2FE', 1.0]]
    })
  }
}

class VideoItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

@Component
struct VideoCard {
  @ObjectLink item: VideoItem;

  build() {
    Column() {
      // Thumbnail placeholder
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F4999')
      }
      .width('100%')
      .height(120)
      .backgroundColor('#E0F2FE')
      .borderRadius(8)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#082F49')
        .margin({ top: 8 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#082F49B3')
        .margin({ top: 4 })

      Button('Play')
        .width('100%')
        .height(40)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001F2F')
        .backgroundColor('#38BDF8')
        .borderRadius(8)
        .margin({ top: 8 })
        .onClick(() => {})
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: '#1E000000',
      offsetY: 2
    })
  }
}
