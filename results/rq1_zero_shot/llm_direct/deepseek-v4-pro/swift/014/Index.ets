import { display } from '@kit.ArkUI';

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  @State selectedPodcast: string = '';

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ];

  // Color tokens
  private primary: string = '#38BDF8';
  private secondary: string = '#0EA5E9';
  private tertiary: string = '#0284C7';
  private background: string = '#F0F9FF';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#E0F2FE';
  private outline: string = '#BFE0F4';
  private onPrimary: string = '#001F2F';
  private onSecondary: string = '#FFFFFF';
  private onSurface: string = '#082F49';

  @Builder
  TabButton(index: number, label: string) {
    Button() {
      Row({ space: 2 }) {
        if (this.selectedTab === index) {
          Text('✓')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.selectedTab === index ? this.onPrimary : this.onSurface)
        }
        Text(label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === index ? this.onPrimary : this.onSurface)
      }
      .width(112)
      .height(39)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.selectedTab === index ? this.primary : this.surface)
      .borderRadius(8)
      .border({
        width: 1,
        color: this.outline,
        radius: 8
      })
    }
    .onClick(() => {
      this.selectedTab = index;
    })
  }

  @Builder
  PodcastListItem(podcast: string) {
    Row() {
      Column({ space: 5 }) {
        Text(podcast)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)
        Text('30 min episode')
          .fontSize(14)
          .fontColor('#082F49B3')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play') {
        this.selectedPodcast = podcast;
        this.showDialog = true;
      }
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.onSecondary)
      .width(84)
      .height(39)
      .backgroundColor(this.secondary)
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.surface)
    .borderRadius(12)
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[this.surfaceVariant, 0], [this.background, 1]]
        })

      Column({ space: 0 }) {
        // Top spacer
        Blank()
          .height(25)

        // Top App Bar
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.background)

        // Tab Selection
        Row({ space: 10 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            this.TabButton(index, tab)
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })
        .linearGradient({
          angle: 180,
          colors: [[this.surfaceVariant, 0], [this.background, 1]]
        })

        // Podcast List
        Scroll() {
          Column({ space: 15 }) {
            ForEach(this.podcasts, (podcast: string) => {
              this.PodcastListItem(podcast)
            })
          }
          .width('100%')
          .padding({ top: 12, bottom: 12, left: 16, right: 16 })
        }
        .layoutWeight(1)
        .backgroundColor(this.background)
        .scrollBar(BarState.Off)

        // Bottom spacer
        Blank()
          .height(20)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}