class VideoItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

class LibraryColors {
  static primary: string = '#38BDF8';
  static secondary: string = '#0EA5E9';
  static tertiary: string = '#0369A1';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BFE0F4';
  static onPrimary: string = '#001F2F';
  static onSurface: string = '#082F49';
}

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
  ];

  @Builder
  VideoCard(item: VideoItem) {
    Column({ space: 8 }) {
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
          .lineHeight(15)
      }
      .width('100%')
      .height(120)
      .backgroundColor(LibraryColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(LibraryColors.onSurface)
        .lineHeight(22)
      Text(item.duration)
        .fontSize(13)
        .fontColor('#B3082F49')
        .lineHeight(18)
      Button('Play')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(LibraryColors.onPrimary)
        .backgroundColor(LibraryColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(LibraryColors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Video Library')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor(LibraryColors.onSurface)
        .lineHeight(32)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(LibraryColors.background)

      Column({ space: 12 }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(LibraryColors.onSurface)
          .lineHeight(22)

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
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(LibraryColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LibraryColors.background)
  }
}
