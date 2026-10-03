@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background Column
      Column() {
        // Segmented Buttons Row
        Row() {
          ForEach(this.tabs, (label: string, index: number) => {
            Button(label)
              .width('33%')
              .height(40)
              .margin({ right: index < this.tabs.length - 1 ? 8 : 0 })
              .borderRadius(12)
              .backgroundColor(this.selectedTab === index ? '#0EA5E9' : '#FFFFFF')
              .fontColor(this.selectedTab === index ? '#FFFFFF' : '#082F49')
              .onClick(() => {
                this.selectedTab = index
              })
          }, (item: string) => item)
        }
        .width('100%')
        .margin({ top: 60, bottom: 16 })

        // Podcast List
        List({ space: 12 }) {
          ForEach(this.podcasts, (title: string) => {
            ListItem() {
              Column() {
                Row() {
                  Column() {
                    Text(title)
                      .fontWeight(FontWeight.Medium)
                      .fontSize(20)
                      .fontColor('#082F49')
                    
                    Text('30 min episode')
                      .fontSize(16)
                      .fontColor('#64748B')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Button('Play')
                    .backgroundColor('#0EA5E9')
                    .fontColor('#FFFFFF')
                    .borderRadius(12)
                    .width(80)
                    .height(40)
                    .onClick(() => {
                      this.showDialog = true
                    })
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
          }, (item: string) => item)
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })

      // Top App Bar
      Column() {
        Text('Podcasts')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)

      // Dialog Overlay
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Playing Podcast')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#082F49')
              .margin({ bottom: 8 })

            Text('Streaming audio...')
              .fontSize(16)
              .fontColor('#082F49')
              .margin({ bottom: 24 })

            Button('OK')
              .width('100%')
              .height(40)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#0EA5E9' })
              .borderRadius(8)
              .fontColor('#0EA5E9')
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width(300)
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 10, color: '#00000033' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}