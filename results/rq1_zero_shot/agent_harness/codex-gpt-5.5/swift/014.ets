@Entry
@Component
struct PodcastColdRoot {
  @State private selectedTab: number = 0;
  @State private showDialog: boolean = false;
  @State private selectedPodcast: string = '';

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  @Builder
  TabButton(label: string, index: number) {
    Button() {
      Row() {
        if (this.selectedTab === index) {
          Text('✓')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#001F2F')
            .margin({ right: 1 })
        }
        Text(label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === index ? '#001F2F' : '#082F49')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .width(112)
    .height(39)
    .backgroundColor(this.selectedTab === index ? '#38BDF8' : '#FFFFFF')
    .border({ width: 1, color: '#BFE0F4', radius: 8 })
    .borderRadius(8)
    .onClick(() => {
      this.selectedTab = index;
    })
  }

  @Builder
  PodcastCard(podcast: string) {
    Row() {
      Column() {
        Text(podcast)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
        Text('30 min episode')
          .fontSize(14)
          .fontColor('#B3082F49')
          .margin({ top: 5 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#0EA5E9')
        .width(84)
        .height(39)
        .borderRadius(8)
        .onClick(() => {
          this.selectedPodcast = podcast;
          this.showDialog = true;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ left: 16, right: 16, bottom: 15 })
  }

  @Builder
  PlayDialog() {
    if (this.showDialog) {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#66000000')
        Column() {
          Text('Playing Podcast')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#082F49')
          Text('Streaming audio...')
            .fontSize(14)
            .fontColor('#082F49')
            .margin({ top: 12 })
          Button('OK')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#0EA5E9')
            .height(36)
            .padding({ left: 24, right: 24 })
            .borderRadius(8)
            .margin({ top: 18 })
            .onClick(() => {
              this.showDialog = false;
            })
        }
        .width('78%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
      }
      .width('100%')
      .height('100%')
    }
  }

  build() {
    Stack() {
      Column() {
        Blank().height(25)
        Stack() {
          Rect()
            .width('100%')
            .height(60)
            .fill('#F0F9FF')
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#082F49')
        }
        .height(60)

        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            this.TabButton(tab, index)
              .margin({ right: 10 })
          }, (tab: string) => tab)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })
        .backgroundColor('#E0F2FE')

        Scroll() {
          Column() {
            ForEach(this.podcasts, (podcast: string) => {
              this.PodcastCard(podcast)
            }, (podcast: string) => podcast)
          }
          .width('100%')
          .padding({ top: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .backgroundColor('#F0F9FF')

        Blank().height(20)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F9FF')

      this.PlayDialog()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
