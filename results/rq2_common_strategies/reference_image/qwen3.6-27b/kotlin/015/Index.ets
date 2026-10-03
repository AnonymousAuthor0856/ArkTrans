// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct VideoLibraryPage {
  @State videos: VideoItem[] = [
    new VideoItem("Nature Documentary", "24:18"),
    new VideoItem("AI Explained", "18:52"),
    new VideoItem("Space Travel", "31:09"),
    new VideoItem("Modern Art Review", "15:45"),
    new VideoItem("Retro Music Visuals", "22:10"),
    new VideoItem("Daily News Recap", "12:34")
  ]

  build() {
    Column() {
      // Header Section
      Column() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 8 })

        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .alignItems(HorizontalAlign.Start)
          .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      // Grid Content
      GridContainer({ data: this.videos })
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E0F2FE') // SurfaceVariant as base to match gradient start
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
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
struct GridContainer {
  @Link data: VideoItem[];

  build() {
    Grid() {
      ForEach(this.data, (item: VideoItem) => {
        GridItem() {
          VideoCard(item)
        }
      }, (item: VideoItem) => item.title)
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .padding(16)
    .width('100%')
    .height('100%')
  }
}

@Component
struct VideoCard {
  private item: VideoItem;

  constructor(item: VideoItem) {
    this.item = item;
  }

  build() {
    Column() {
      // Thumbnail Placeholder
      Row() {
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
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .maxLines(2)
          .textOverflow({ overflowType: TextOverflow.Ellipsis })
          .margin({ top: 8, bottom: 4 })

        Text(this.item.duration)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor('#082F49')
          .opacity(0.7)
          .margin({ bottom: 8 })

        Button('Play', { type: ButtonType.Capsule })
          .width('100%')
          .height(40)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#001F2F')
          .backgroundColor('#38BDF8')
          .borderRadius(8)
      }
      .width('100%')
      .padding(12)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}