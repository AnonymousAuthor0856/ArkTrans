@Entry
@Component
struct RootScreen {
  @State private selectedTab: number = 0

  private readonly tabs: string[] = ['Trending', 'Following', 'Recent']
  private readonly podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  build() {
    Column() {
      Text('Podcasts')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#082F49')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 34, bottom: 78 })

      Row() {
        ForEach(this.tabs, (label: string, index: number) => {
          Row() {
            if (this.selectedTab === index) {
              Text('✓')
                .fontSize(24)
                .fontColor('#001F2F')
                .margin({ right: 14 })
            }

            Text(label)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .height(78)
          .layoutWeight(1)
          .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
          .border({
            width: 1,
            color: '#BFE0F4',
            radius: 12
          })
          .onClick(() => {
            this.selectedTab = index
          })
        }, (label: string) => label)
      }
      .width('100%')
      .height(78)
      .margin({ bottom: 40 })

      Column({ space: 24 }) {
        ForEach(this.podcasts, (podcast: string) => {
          Row() {
            Column() {
              Text(podcast)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
                .margin({ bottom: 4 })

              Text('30 min episode')
                .fontSize(18)
                .fontWeight(FontWeight.Normal)
                .fontColor('rgba(8, 47, 73, 0.70)')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Play')
              .width(152)
              .height(80)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
              .onClick(() => {
                AlertDialog.show({
                  title: 'Playing Podcast',
                  message: 'Streaming audio...',
                  autoCancel: true,
                  alignment: DialogAlignment.Center,
                  confirm: {
                    value: 'OK',
                    fontColor: '#38BDF8',
                    action: () => {
                    }
                  }
                })
              })
          }
          .width('100%')
          .height(160)
          .padding({ left: 32, right: 32 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
        }, (podcast: string) => podcast)
      }
      .width('100%')
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
  }
}