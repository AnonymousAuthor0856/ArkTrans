import { promptAction } from '@kit.ArkUI';

// Color tokens
class PCColors {
  primary: string = '#38BDF8';
  secondary: string = '#0EA5E9';
  tertiary: string = '#0284C7';
  background: string = '#F0F9FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E0F2FE';
  outline: string = '#BFE0F4';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#DC2626';
  onPrimary: string = '#001F2F';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#082F49';
  onSurface: string = '#082F49';
}

const PC = new PCColors();

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
    'Design Flow',
  ];

  build() {
    Column({ space: 0 }) {
      // ===== Top App Bar =====
      Stack() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC.onSurface)
      }
      .width('100%')
      .height(60)
      .backgroundColor(PC.background)
      .alignContent(Alignment.Center)

      // ===== Tab Selection =====
      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 4 }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.selectedTab === index ? PC.onPrimary : PC.onSurface)
              }
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? PC.onPrimary : PC.onSurface)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width(112)
          .height(39)
          .backgroundColor(this.selectedTab === index ? PC.primary : PC.surface)
          .borderRadius(8)
          .borderWidth(1)
          .borderColor(PC.outline)
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
      .justifyContent(FlexAlign.SpaceBetween)

      // ===== Podcast List =====
      Scroll() {
        Column({ space: 15 }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column({ space: 5 }) {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PC.onSurface)
                  .textAlign(TextAlign.Start)
                  .width('100%')

                Text('30 min episode')
                  .fontSize(14)
                  .fontColor('#82A8C0')
                  .textAlign(TextAlign.Start)
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(PC.onSecondary)
                .width(84)
                .height(39)
                .backgroundColor(PC.secondary)
                .borderRadius(8)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  promptAction.showDialog({
                    title: 'Playing Podcast',
                    message: 'Streaming audio...',
                    buttons: [
                      {
                        text: 'OK',
                        color: PC.primary,
                      },
                    ],
                  }).then(() => {
                    this.showDialog = false;
                  });
                })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(PC.surface)
            .borderRadius(12)
            .alignItems(VerticalAlign.Center)
            .margin({ left: 16, right: 16 })
          }, (podcast: string) => podcast)
        }
        .width('100%')
        .padding({ top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(PC.background)
      .scrollBar(BarState.Off)

      // ===== Bottom Spacer =====
      Row()
        .width('100%')
        .height(20)
        .backgroundColor(PC.background)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
    })
    .padding({ top: 44 })
  }
}