const PC = {
  C: {
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
    onSurface: '#082F49'
  }
}

@CustomDialog
struct PodcastPlayDialog {
  controller: CustomDialogController

  build() {
    Column() {
      Text('Playing Podcast')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(PC.C.onSurface)
        .margin({ bottom: 10 })

      Text('Streaming audio...')
        .fontSize(16)
        .fontColor(PC.C.onSurface)
        .opacity(0.75)
        .margin({ bottom: 22 })

      Button('OK')
        .type(ButtonType.Normal)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(PC.C.onSecondary)
        .backgroundColor(PC.C.secondary)
        .borderRadius(8)
        .width(96)
        .height(40)
        .onClick(() => {
          this.controller.close()
        })
    }
    .width(280)
    .padding(24)
    .backgroundColor(PC.C.surface)
    .borderRadius(18)
  }
}

@Entry
@Component
struct PodcastColdRoot {
  @State private selectedTab: number = 0
  @State private selectedPodcast: string = ''
  @State private scale: number = 1

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: PodcastPlayDialog(),
    autoCancel: true,
    customStyle: true
  })

  private s(value: number): number {
    return value * this.scale
  }

  build() {
    Column({ space: 0 }) {
      Blank()
        .height(this.s(25))

      Stack() {
        Text('Podcasts')
          .fontSize(this.s(28))
          .fontWeight(FontWeight.SemiBold)
          .fontColor(PC.C.onSurface)
      }
      .width('100%')
      .height(this.s(60))
      .backgroundColor(PC.C.background)

      Row({ space: this.s(10) }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: this.s(1) }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(this.s(13))
                  .fontWeight(FontWeight.Bold)
                  .fontColor(PC.C.onPrimary)
              }

              Text(tab)
                .fontSize(this.s(14))
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? PC.C.onPrimary : PC.C.onSurface)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .height('100%')
          }
          .type(ButtonType.Normal)
          .stateEffect(false)
          .width(this.s(112))
          .height(this.s(39))
          .backgroundColor(this.selectedTab === index ? PC.C.primary : PC.C.surface)
          .borderRadius(this.s(8))
          .border({
            width: this.s(1),
            color: PC.C.outline
          })
          .onClick(() => {
            this.selectedTab = index
          })
        }, (tab: string) => tab)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({
        left: this.s(16),
        right: this.s(16),
        top: this.s(15),
        bottom: this.s(15)
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [PC.C.surfaceVariant, 0.0],
          [PC.C.background, 1.0]
        ]
      })

      Scroll() {
        Column({ space: this.s(15) }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column({ space: this.s(5) }) {
                Text(podcast)
                  .fontSize(this.s(20))
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PC.C.onSurface)

                Text('30 min episode')
                  .fontSize(this.s(14))
                  .fontColor(PC.C.onSurface)
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .type(ButtonType.Normal)
                .stateEffect(false)
                .fontSize(this.s(14))
                .fontWeight(FontWeight.Medium)
                .fontColor(PC.C.onSecondary)
                .width(this.s(84))
                .height(this.s(39))
                .backgroundColor(PC.C.secondary)
                .borderRadius(this.s(8))
                .onClick(() => {
                  this.selectedPodcast = podcast
                  this.dialogController.open()
                })
            }
            .width('100%')
            .padding(this.s(16))
            .backgroundColor(PC.C.surface)
            .borderRadius(this.s(12))
          }, (podcast: string) => podcast)
        }
        .width('100%')
        .padding({
          left: this.s(16),
          right: this.s(16),
          top: this.s(12),
          bottom: this.s(12)
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(PC.C.background)

      Blank()
        .height(this.s(20))
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [PC.C.surfaceVariant, 0.0],
        [PC.C.background, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .onAreaChange((oldValue, newValue) => {
      const width = Number(newValue.width)
      const height = Number(newValue.height)

      if (width > 0 && height > 0) {
        this.scale = Math.min(width / 360.0, height / 640.0)
      }
    })
  }
}