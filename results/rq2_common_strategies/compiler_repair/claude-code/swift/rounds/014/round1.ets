import promptAction from '@ohos.promptAction';

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0;
  @State selectedPodcast: string = '';
  @State viewWidth: number = 360;
  @State viewHeight: number = 640;

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ];

  private get scale(): number {
    return Math.min(this.viewWidth / 360, this.viewHeight / 640);
  }

  build() {
    Column() {
      // Top App Bar
      Stack() {
        Text('Podcasts')
          .fontSize(28 * this.scale)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(60 * this.scale)
      .backgroundColor('#F0F9FF')

      // Tab Selection
      Row({ space: 10 * this.scale }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 1 * this.scale }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(13 * this.scale)
                  .fontWeight(FontWeight.Bold)
              }
              Text(tab)
                .fontSize(14 * this.scale)
                .fontWeight(FontWeight.Medium)
            }
            .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
          }
          .layoutWeight(1)
          .height(39 * this.scale)
          .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
          .borderRadius(8 * this.scale)
          .border({ width: 1 * this.scale, color: '#BFE0F4' })
          .onClick(() => {
            this.selectedTab = index;
          })
        }, (tab: string, index: number) => tab + index.toString())
      }
      .width('100%')
      .padding({ left: 16 * this.scale, right: 16 * this.scale, top: 15 * this.scale, bottom: 15 * this.scale })
      .linearGradient({
        colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]],
        direction: GradientDirection.Bottom
      })

      // Podcast List
      Scroll() {
        Column({ space: 15 * this.scale }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(20 * this.scale)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#082F49')
                Text('30 min episode')
                  .fontSize(14 * this.scale)
                  .fontColor('rgba(8, 47, 73, 0.7)')
                  .margin({ top: 5 * this.scale })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Button('Play')
                .fontSize(14 * this.scale)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
                .width(84 * this.scale)
                .height(39 * this.scale)
                .backgroundColor('#0EA5E9')
                .borderRadius(8 * this.scale)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  this.showPlayDialog();
                })
            }
            .width('100%')
            .padding(16 * this.scale)
            .backgroundColor('#FFFFFF')
            .borderRadius(12 * this.scale)
          }, (podcast: string) => podcast)
        }
        .width('100%')
        .padding({ top: 12 * this.scale, bottom: 12 * this.scale, left: 16 * this.scale, right: 16 * this.scale })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F0F9FF')
      .scrollBar(BarState.Off)

      // Bottom spacer
      Blank()
        .height(20 * this.scale)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]],
      direction: GradientDirection.Bottom
    })
    .onAreaChange((oldVal: Area, newVal: Area) => {
      this.viewWidth = newVal.width as number;
      this.viewHeight = newVal.height as number;
    })
  }

  private showPlayDialog(): void {
    promptAction.showDialog({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      buttons: [{
        text: 'OK',
        color: '#0EA5E9'
      }]
    });
  }
}
