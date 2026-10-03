@Entry
@Component
struct PodcastListenPage {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  build() {
    Stack() {
      Column() {
        // Top bar (CenterAlignedTopAppBar)
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#082F49')
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F0F9FF')

        // Content column with vertical gradient background
        Column() {
          // SingleChoiceSegmentedButtonRow
          Row() {
            ForEach(this.tabs, (label: string, index: number) => {
              Text(label)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
                .textAlign(TextAlign.Center)
                .layoutWeight(1)
                .padding({ top: 10, bottom: 10, left: 8, right: 8 })
                .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
                .border({ width: 1, color: '#BFE0F4' })
                .borderRadius(8)
                .onClick(() => {
                  this.selectedTab = index;
                })
            })
          }
          .width('100%')

          // Podcast cards list
          Column() {
            ForEach(this.podcasts, (podcast: string, index: number) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                  Text('30 min episode')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#B3082F49')
                }
                .alignItems(HorizontalAlign.Start)

                Button('Play')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#0EA5E9')
                  .borderRadius(8)
                  .height(36)
                  .onClick(() => {
                    this.showDialog = true;
                  })
              }
              .width('100%')
              .margin({ top: index === 0 ? 0 : 12 })
              .padding(16)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
            })
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
        })
      }
      .width('100%')
      .height('100%')

      // AlertDialog overlay
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#082F49')
              .margin({ bottom: 12 })
            Text('Streaming audio...')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#CC082F49')
              .margin({ bottom: 20 })
            Text('OK')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#38BDF8')
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .onClick(() => {
                this.showDialog = false;
              })
          }
          .width('80%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#66000000')
        .onClick(() => {
          this.showDialog = false;
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
