@Entry
@Component
struct PodcastListen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  @Builder
  SegmentedButton(label: string, index: number) {
    Column() {
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
    }
    .width('100%')
    .height(36)
    .justifyContent(FlexAlign.Center)
    .borderRadius(8)
    .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
    .onClick(() => {
      this.selectedTab = index;
    })
  }

  @Builder
  PodcastCard(podcast: string) {
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
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play') {
        Text('Play')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
      }
      .type(ButtonType.Normal)
      .borderRadius(8)
      .backgroundColor('#0EA5E9')
      .height(36)
      .padding({ left: 16, right: 16 })
      .onClick(() => {
        this.showDialog = true;
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  build() {
    Stack() {
      Column() {
        // Top bar
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#082F49')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F0F9FF')

        Column() {
          // Segmented button row
          Row() {
            ForEach(this.tabs, (item: string, index: number) => {
              this.SegmentedButton(item, index)
            }, (item: string) => item)
          }
          .width('100%')
          .padding(4)
          .backgroundColor('#E0F2FE')
          .borderRadius(8)

          // Podcast list
          Column() {
            ForEach(this.podcasts, (item: string) => {
              this.PodcastCard(item)
            }, (item: string) => item)
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#F0F9FF', 0.0], ['#E0F2FE', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F9FF')

      // AlertDialog
      if (this.showDialog) {
        Stack() {
          Column() {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#082F49')
              .margin({ bottom: 12 })

            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#082F49')
              .opacity(0.8)
              .margin({ bottom: 20 })

            Row() {
              Blank()
              Text('OK')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#38BDF8')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .onClick(() => {
                  this.showDialog = false;
                })
            }
            .width('100%')
          }
          .width(280)
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.5)')
        .justifyContent(FlexAlign.Center)
        .alignContent(Alignment.Center)
        .onClick(() => {
          this.showDialog = false;
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}
