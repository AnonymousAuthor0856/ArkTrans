import { promptAction } from '@kit.ArkUI';

// Color tokens
const PC_C_PRIMARY = '#38BDF8';
const PC_C_SECONDARY = '#0EA5E9';
const PC_C_BACKGROUND = '#F0F9FF';
const PC_C_SURFACE = '#FFFFFF';
const PC_C_SURFACE_VARIANT = '#E0F2FE';
const PC_C_OUTLINE = '#BFE0F4';
const PC_C_ON_PRIMARY = '#001F2F';
const PC_C_ON_SECONDARY = '#FFFFFF';
const PC_C_ON_SURFACE = '#082F49';

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
    'Design Flow',
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC_C_ON_SURFACE)
      }
      .width('100%')
      .height(60)
      .backgroundColor(PC_C_BACKGROUND)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Tab Selection
      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 4 }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.selectedTab === index ? PC_C_ON_PRIMARY : PC_C_ON_SURFACE)
              }
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? PC_C_ON_PRIMARY : PC_C_ON_SURFACE)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width(112)
          .height(39)
          .backgroundColor(this.selectedTab === index ? PC_C_PRIMARY : PC_C_SURFACE)
          .borderRadius(8)
          .borderWidth(1)
          .borderColor(PC_C_OUTLINE)
          .onClick(() => {
            this.selectedTab = index;
          })
        }, (tab: string) => tab)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
      })

      // Podcast List
      Scroll() {
        Column({ space: 15 }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column({ space: 5 }) {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PC_C_ON_SURFACE)
                Text('30 min episode')
                  .fontSize(14)
                  .fontColor(PC_C_ON_SURFACE)
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(PC_C_ON_SECONDARY)
                .width(84)
                .height(39)
                .backgroundColor(PC_C_SECONDARY)
                .borderRadius(8)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  promptAction.showDialog({
                    title: 'Playing Podcast',
                    message: 'Streaming audio...',
                    buttons: [{ text: 'OK', color: PC_C_SECONDARY }],
                  }).then(() => {
                  }).catch(() => {
                  });
                })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(PC_C_SURFACE)
            .borderRadius(12)
            .alignItems(VerticalAlign.Center)
          }, (podcast: string) => podcast)
        }
        .padding({ top: 12, bottom: 12, left: 16, right: 16 })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(PC_C_BACKGROUND)
      .scrollBar(BarState.Off)

      // Bottom spacer
      Row()
        .height(20)
        .width('100%')
        .backgroundColor(PC_C_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
    })
  }
}