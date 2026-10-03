// PodcastListenColdGradient.ets
// Place at: entry/src/main/ets/pages/PodcastListenColdGradient.ets
// Register it in entry/src/main/resources/base/profile/main_pages.json

// ---------------------------------------------------------------- Tokens
const PC_PRIMARY: string = '#38BDF8';
const PC_SECONDARY: string = '#0EA5E9';
const PC_TERTIARY: string = '#0284C7';
const PC_BACKGROUND: string = '#F0F9FF';
const PC_SURFACE: string = '#FFFFFF';
const PC_SURFACE_VARIANT: string = '#E0F2FE';
const PC_OUTLINE: string = '#BFE0F4';
const PC_SUCCESS: string = '#16A34A';
const PC_WARNING: string = '#F59E0B';
const PC_ERROR: string = '#DC2626';
const PC_ON_PRIMARY: string = '#001F2F';
const PC_ON_SECONDARY: string = '#FFFFFF';
const PC_ON_TERTIARY: string = '#FFFFFF';
const PC_ON_BACKGROUND: string = '#082F49';
const PC_ON_SURFACE: string = '#082F49';

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0;
  @State selectedPodcast: string = '';

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ];

  // -------------------------------------------------- Tab chip (Builder)
  @Builder
  TabChip(label: string, index: number) {
    Row({ space: 1 }) {
      if (this.selectedTab === index) {
        Text('✓')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(PC_ON_PRIMARY)
      }
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTab === index ? PC_ON_PRIMARY : PC_ON_SURFACE)
    }
    .justifyContent(FlexAlign.Center)
    .width(112)
    .height(39)
    .backgroundColor(this.selectedTab === index ? PC_PRIMARY : PC_SURFACE)
    .borderRadius(8)
    .border({ width: 1, color: PC_OUTLINE })
    .onClick(() => {
      this.selectedTab = index;
    })
  }

  // ------------------------------------------------- Play + dialog logic
  private handlePlay(podcast: string): void {
    this.selectedPodcast = podcast;
    AlertDialog.show({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      autoCancel: true,
      alignment: DialogAlignment.Center,
      confirm: {
        value: 'OK',
        fontColor: PC_SECONDARY,
        action: () => {
          this.selectedPodcast = '';
        }
      }
    });
  }

  // ------------------------------------------------------------ Podcast card
  @Builder
  PodcastCard(podcast: string) {
    Row() {
      Column({ space: 5 }) {
        Text(podcast)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC_ON_SURFACE)
        Text('30 min episode')
          .fontSize(14)
          .fontColor(PC_ON_SURFACE)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play', { type: ButtonType.Normal })
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(PC_ON_SECONDARY)
        .width(84)
        .height(39)
        .backgroundColor(PC_SECONDARY)
        .borderRadius(8)
        .onClick(() => {
          this.handlePlay(podcast);
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(PC_SURFACE)
    .borderRadius(12)
  }

  // ------------------------------------------------------------------ build
  build() {
    Column() {
      // ===== Top App Bar =====
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(PC_ON_SURFACE)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(60)
      .backgroundColor(PC_BACKGROUND)

      // ===== Tab Selection =====
      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          this.TabChip(tab, index);
        }, (tab: string) => tab)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        angle: 180,
        colors: [[PC_SURFACE_VARIANT, 0.0], [PC_BACKGROUND, 1.0]]
      })

      // ===== Podcast List =====
      List({ space: 15 }) {
        ForEach(this.podcasts, (podcast: string) => {
          ListItem() {
            this.PodcastCard(podcast);
          }
        }, (podcast: string) => podcast)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(PC_BACKGROUND)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[PC_SURFACE_VARIANT, 0.0], [PC_BACKGROUND, 1.0]]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}