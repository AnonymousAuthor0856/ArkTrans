@Entry
@Component
struct PodcastListenColdGradientApp {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  @State selectedPodcast: string = ""

  private tabs: string[] = ["Trending", "Following", "Recent"]
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ]

  build() {
    Column() {
      // === Top App Bar ===
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      // === Tab Selection ===
      Row({ space: 10 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 1 }) {
              if (this.selectedTab === index) {
                Image($r('app.media.startIcon'))
                  .width(13)
                  .height(13)
                  .fillColor(this.selectedTab === index ? '#001F2F' : '#082F49')
              }
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width(112)
          .height(39)
          .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#BFE0F4' })
          .onClick(() => {
            this.selectedTab = index
          })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })

      // === Podcast List ===
      List({ space: 15 }) {
        ForEach(this.podcasts, (podcast: string) => {
          ListItem() {
            Row() {
              Column({ space: 5 }) {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#082F49')
                  .textAlign(TextAlign.Start)
                
                Text('30 min episode')
                  .fontSize(14)
                  .fontColor('#082F49')
                  .opacity(0.7)
                  .textAlign(TextAlign.Start)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Button() {
                Text('Play')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
              }
              .width(84)
              .height(39)
              .backgroundColor('#0EA5E9')
              .borderRadius(8)
              .onClick(() => {
                this.selectedPodcast = podcast
                this.showDialog = true
              })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 12, bottom: 12 })
      .backgroundColor('#F0F9FF')

      // === Bottom Spacer ===
      Blank().height(20)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
    })
    .dialogController(new CustomDialogController({
      builder: DialogContent(),
      autoCancel: true
    }))
  }
}

@Component
struct DialogContent {
  build() {
    Column() {
      Text('Playing Podcast')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })
      
      Text('Streaming audio...')
        .fontSize(14)
        .margin({ bottom: 20 })
      
      Button() {
        Text('OK')
          .fontColor('#0EA5E9')
      }
      .width('100%')
      .height(40)
      .backgroundColor('#F0F9FF')
      .borderRadius(8)
    }
    .width('80%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }
}