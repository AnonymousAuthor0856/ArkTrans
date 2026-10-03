@Entry
@Component
struct MainPage {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private readonly tabs: string[] = ['Trending', 'Following', 'Recent']
  private readonly podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  build() {
    Stack() {
      Column() {
        Text('Podcasts')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 28, bottom: 72 })

        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Stack() {
              Row() {
                if (index === 0 && this.selectedTab === 0) {
                  Text('✓')
                    .fontSize(30)
                    .fontColor('#001F2F')
                    .margin({ right: 18 })
                }
                Text(tab)
                  .fontSize(29)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(index === this.selectedTab ? '#001F2F' : '#082F49')
              }
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .height('100%')

              .onClick(() => {
                this.selectedTab = index
              })
            }
            .width('33.333%')
            .height(78)
            .backgroundColor(index === this.selectedTab ? '#38BDF8' : '#FFFFFF')
            .border({
              width: 2,
              color: '#BFE0F4'
            })
            .borderRadius(14)
          })
        }
        .width('100%')
        .height(78)
        .margin({ bottom: 40 })

        Column() {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(36)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#082F49')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text('30 min episode')
                  .fontSize(28)
                  .fontColor('#537188')
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .fontSize(29)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .backgroundColor('#0EA5E9')
                .borderRadius(15)
                .width(152)
                .height(80)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .height(160)
            .padding({ left: 32, right: 32 })
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .margin({ bottom: 24 })
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 32, right: 32 })
      .linearGradient({
        angle: 180,
        colors: [
          ['#E0F2FE', 0.0],
          ['#F0F9FF', 1.0]
        ]
      })
      .justifyContent(FlexAlign.Start)

      if (this.showDialog) {
        Column() {
          Text('Playing Podcast')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#082F49')
            .margin({ bottom: 12 })
          Text('Streaming audio...')
            .fontSize(17)
            .fontColor('#537188')
            .margin({ bottom: 20 })
          Button('OK')
            .fontSize(16)
            .fontColor('#0EA5E9')
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width(300)
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .shadow({
          radius: 18,
          color: '#55000000',
          offsetX: 0,
          offsetY: 6
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}
