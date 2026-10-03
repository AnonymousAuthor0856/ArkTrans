@Entry
@Component
struct VideoLibraryApp {
  @State videos: VideoItem[] = [
    { title: "Nature Documentary", duration: "24:18" },
    { title: "AI Explained", duration: "18:52" },
    { title: "Space Travel", duration: "31:09" },
    { title: "Modern Art Review", duration: "15:45" },
    { title: "Retro Music Visuals", duration: "22:10" },
    { title: "Daily News Recap", duration: "12:34" }
  ];

  // AppTokens Colors
  private readonly primary: string = '#38BDF8';
  private readonly secondary: string = '#0EA5E9';
  private readonly tertiary: string = '#0369A1';
  private readonly background: string = '#F0F9FF';
  private readonly surface: string = '#FFFFFF';
  private readonly surfaceVariant: string = '#E0F2FE';
  private readonly outline: string = '#BFE0F4';
  private readonly onPrimary: string = '#001F2F';
  private readonly onSurface: string = '#082F49';

  @Builder
  TopBar() {
    Row() {
      Text('Video Library')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(this.background)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  VideoCard(item: VideoItem) {
    Column({ space: 8 }) {
      // Thumbnail placeholder
      Column() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
      }
      .width('100%')
      .height(120)
      .backgroundColor(this.surfaceVariant)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)

      Text(item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3082F49')

      Button('Play')
        .width('100%')
        .height(40)
        .backgroundColor(this.primary)
        .fontColor(this.onPrimary)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .borderRadius(8)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: 12 }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)

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
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[this.surfaceVariant, 0.0], [this.background, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}

interface VideoItem {
  title: string;
  duration: string;
}