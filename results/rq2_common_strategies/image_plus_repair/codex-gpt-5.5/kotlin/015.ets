interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct MainPage {
  @State private activeVideo: string = '';

  private readonly videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  build() {
    Column() {
      Text('Video Library')
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor('#082F49')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 34, bottom: 64 });

      Column() {
        Text('Explore the latest videos')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
          .width('100%')
          .margin({ bottom: 24 });

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              this.videoCard(item);
            }
          }, (item: VideoItem) => item.title);
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(22)
        .rowsGap(22)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding({ left: 31, right: 31, bottom: 18 })
    .backgroundColor('#F0F9FF')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
    });
  }

  @Builder
  private videoCard(item: VideoItem) {
    Column() {
      Stack() {
        Text('Thumbnail')
          .fontSize(22)
          .fontColor('#587A92')
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .height(240)
      .borderRadius(15)
      .backgroundColor('#E0F2FE');

      Text(item.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#082F49')
        .lineHeight(38)
        .width('100%')
        .margin({ top: 17 });

      Text(item.duration)
        .fontSize(25)
        .fontColor('#587A92')
        .width('100%')
        .margin({ top: 12, bottom: 17 });

      Button('Play')
        .fontSize(22)
        .fontColor('#001F2F')
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#38BDF8')
        .height(80)
        .width('100%')
        .borderRadius(15)
        .onClick(() => {
          this.activeVideo = item.title;
        });
    }
    .width('100%')
    .padding(25)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 5,
      color: '#22082F49',
      offsetX: 0,
      offsetY: 2
    });
  }
}
