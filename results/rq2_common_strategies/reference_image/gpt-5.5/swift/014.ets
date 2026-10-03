const PRIMARY: ResourceColor = 0xFF38BDF8;
const SECONDARY: ResourceColor = 0xFF0EA5E9;
const BACKGROUND: ResourceColor = 0xFFF0F9FF;
const SURFACE: ResourceColor = 0xFFFFFFFF;
const SURFACE_VARIANT: ResourceColor = 0xFFE0F2FE;
const OUTLINE: ResourceColor = 0xFFBFE0F4;
const ON_PRIMARY: ResourceColor = 0xFF001F2F;
const ON_SECONDARY: ResourceColor = 0xFFFFFFFF;
const ON_SURFACE: ResourceColor = 0xFF082F49;
const ON_SURFACE_70: ResourceColor = 0xB3082F49;

@Entry
@Component
struct PodcastColdRoot {
  @State private selectedTab: number = 0;
  @State private selectedPodcast: string = '';

  private readonly tabs: string[] = ['Trending', 'Following', 'Recent'];
  private readonly podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ];

  private showPlayingDialog(podcast: string): void {
    this.selectedPodcast = podcast;
    AlertDialog.show({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      autoCancel: true,
      alignment: DialogAlignment.Center,
      confirm: {
        value: 'OK',
        action: () => {
        }
      }
    });
  }

  @Builder
  private TabItem(tab: string, index: number) {
    Row() {
      if (this.selectedTab === index) {
        Text('✓')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_PRIMARY)
          .margin({ right: 4 });
      }

      Text(tab)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTab === index ? ON_PRIMARY : ON_SURFACE);
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .layoutWeight(1)
    .height(39)
    .backgroundColor(this.selectedTab === index ? PRIMARY : SURFACE)
    .borderRadius(8)
    .border({ width: 1, color: OUTLINE })
    .onClick(() => {
      this.selectedTab = index;
    });
  }

  @Builder
  private PodcastCard(podcast: string) {
    Row() {
      Column({ space: 5 }) {
        Text(podcast)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis });

        Text('30 min episode')
          .fontSize(14)
          .fontColor(ON_SURFACE_70);
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1);

      Text('Play')
        .width(84)
        .height(39)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SECONDARY)
        .textAlign(TextAlign.Center)
        .backgroundColor(SECONDARY)
        .borderRadius(8)
        .onClick(() => {
          this.showPlayingDialog(podcast);
        });
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
    .borderRadius(12);
  }

  build() {
    Column() {
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(ON_SURFACE);
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(BACKGROUND);

      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          this.TabItem(tab, index);
        }, (tab: string) => tab);
      }
      .width('100%')
      .height(72)
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        angle: 180,
        colors: [
          [SURFACE_VARIANT, 0.0],
          [BACKGROUND, 1.0]
        ]
      });

      Scroll() {
        Column({ space: 15 }) {
          ForEach(this.podcasts, (podcast: string) => {
            this.PodcastCard(podcast);
          }, (podcast: string) => podcast);
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 });
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(BACKGROUND);

      Blank()
        .width('100%')
        .height(20)
        .backgroundColor(BACKGROUND);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [SURFACE_VARIANT, 0.0],
        [BACKGROUND, 1.0]
      ]
    });
  }
}