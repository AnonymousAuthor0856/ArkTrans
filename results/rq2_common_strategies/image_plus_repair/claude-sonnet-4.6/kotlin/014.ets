@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#082F49')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#F0F9FF')

        // Content
        Column({ space: 16 }) {
          // Segmented Tabs
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
                .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
                .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                .borderRadius(8)
                .border({ width: 1, color: '#BFE0F4' })
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedTab = index
                })
            })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#BFE0F4' })
          .clip(true)

          // Podcast List
          Column({ space: 12 }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                  Text('30 min episode')
                    .fontSize(14)
                    .fontColor('#082F49')
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button('Play')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#0EA5E9')
                  .borderRadius(8)
                  .padding({ top: 10, bottom: 10, left: 20, right: 20 })
                  .onClick(() => {
                    this.showDialog = true
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
        })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F9FF')

      // Dialog
      if (this.showDialog) {
        Column() {
          Column({ space: 12 }) {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#082F49')
            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#082F49')
              .opacity(0.8)
            Row() {
              Text('OK')
                .fontSize(14)
                .fontColor('#38BDF8')
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  this.showDialog = false
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .width('80%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.4)')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}