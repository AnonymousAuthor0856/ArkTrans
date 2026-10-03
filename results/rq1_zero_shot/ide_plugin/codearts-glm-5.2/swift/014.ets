class AppTokens {
  static readonly Colors = {
    primary: '#FF38BDF8',
    secondary: '#FF0EA5E9',
    tertiary: '#FF0284C7',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBFE0F4',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FF001F2F',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF082F49',
    onSurface: '#FF082F49',
    onSurface70: '#B3082F49'
  }
}

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  @State selectedPodcast: string = ''

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  build() {
    Column() {
      Stack() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row() {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .margin({ right: 1 })
              }
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            }
          }
          .width(112)
          .height(39)
          .borderRadius(8)
          .backgroundColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.selectedTab = index
          })
          .margin({ left: index === 0 ? 0 : 10 })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      Scroll() {
        Column() {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                Text('30 min episode')
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.onSurface70)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play') {
              }
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(84)
              .height(39)
              .borderRadius(8)
              .backgroundColor(AppTokens.Colors.secondary)
              .onClick(() => {
                this.selectedPodcast = podcast
                this.showDialog = true
              })
            }
            .width('100%')
            .padding(16)
            .borderRadius(12)
            .backgroundColor(AppTokens.Colors.surface)
            .margin({ left: 16, right: 16, bottom: 15 })
          })
        }
        .padding({ top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      if (this.showDialog) {
        Stack() {
          Column() {
            Text('Playing Podcast')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: 8 })
            Text('Streaming audio...')
              .fontSize(16)
              .fontColor(AppTokens.Colors.onSurface70)
              .margin({ bottom: 24 })
            Button('OK') {
            }
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(80)
            .height(40)
            .borderRadius(8)
            .backgroundColor(AppTokens.Colors.primary)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .padding(24)
          .borderRadius(16)
          .backgroundColor(AppTokens.Colors.surface)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}