import { promptAction } from '@kit.ArkUI';

// Color tokens
const PC = {
  primary: '#38BDF8',
  secondary: '#0EA5E9',
  tertiary: '#0284C7',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BFE0F4',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#001F2F',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#082F49',
  onSurface: '#082F49',
};

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
        Rectangle()
          .fill(PC.background)
          .width('100%')
          .height(60)

        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC.onSurface)
      }
      .width('100%')
      .height(60)
      .margin({ top: 25 })

      // ===== Tab Selection =====
      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 1 }) {
              if (this.selectedTab === index) {
                Image($r('sys.media.ohos_ic_public_ok'))
                  .width(13)
                  .height(13)
                  .fillColor(this.selectedTab === index ? PC.onPrimary : PC.onSurface)
                  .fontWeight(FontWeight.Bold)
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
        colors: [[PC.surfaceVariant, 0.0], [PC.background, 1.0]],
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

                Text('30 min episode')
                  .fontSize(14)
                  .fontColor(PC.onSurface)
                  .opacity(0.7)
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
        .height(20)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[PC.surfaceVariant, 0.0], [PC.background, 1.0]],
    })
  }
}