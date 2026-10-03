@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  @State selectedPodcast: string = ''
  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  build() {
    Column({ space: 0 }) {
      // === Top Spacer ===
      Blank().height(25)

      // === Top App Bar ===
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%').height(60)
          .backgroundColor('#F0F9FF')
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
      }.width('100%').height(60)

      // === Tab Selection ===
      Row({ space: 10 }) {
        // Tab 0
        Button() {
          Row({ space: 1 }) {
            if (this.selectedTab == 0) {
              Text('✓')
                .fontSize(13)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.selectedTab == 0 ? '#001F2F' : '#082F49')
            }
            Text(this.tabs[0])
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab == 0 ? '#001F2F' : '#082F49')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width(112).height(39)
        .backgroundColor(this.selectedTab == 0 ? '#38BDF8' : '#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#BFE0F4' })
        .onClick(() => {
          this.selectedTab = 0
        })

        // Tab 1
        Button() {
          Row({ space: 1 }) {
            if (this.selectedTab == 1) {
              Text('✓')
                .fontSize(13)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.selectedTab == 1 ? '#001F2F' : '#082F49')
            }
            Text(this.tabs[1])
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab == 1 ? '#001F2F' : '#082F49')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width(112).height(39)
        .backgroundColor(this.selectedTab == 1 ? '#38BDF8' : '#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#BFE0F4' })
        .onClick(() => {
          this.selectedTab = 1
        })

        // Tab 2
        Button() {
          Row({ space: 1 }) {
            if (this.selectedTab == 2) {
              Text('✓')
                .fontSize(13)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.selectedTab == 2 ? '#001F2F' : '#082F49')
            }
            Text(this.tabs[2])
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab == 2 ? '#001F2F' : '#082F49')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width(112).height(39)
        .backgroundColor(this.selectedTab == 2 ? '#38BDF8' : '#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#BFE0F4' })
        .onClick(() => {
          this.selectedTab = 2
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .padding({ top: 15, bottom: 15 })
      .backgroundColor('#E0F2FE') // simplified gradient

      // === Podcast List ===
      List({ space: 15 }) {
        // Podcast 0
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 5 }) {
              Text('AI Insights')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
              Text('30 min episode')
                .fontSize(14)
                .fontColor('#082F49')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

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
              this.selectedPodcast = 'AI Insights'
              this.showDialog = true
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }

        // Podcast 1
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 5 }) {
              Text('Mindful Moments')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
              Text('30 min episode')
                .fontSize(14)
                .fontColor('#082F49')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

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
              this.selectedPodcast = 'Mindful Moments'
              this.showDialog = true
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }

        // Podcast 2
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 5 }) {
              Text('History Flash')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
              Text('30 min episode')
                .fontSize(14)
                .fontColor('#082F49')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

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
              this.selectedPodcast = 'History Flash'
              this.showDialog = true
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }

        // Podcast 3
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 5 }) {
              Text('Tech Hour')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
              Text('30 min episode')
                .fontSize(14)
                .fontColor('#082F49')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

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
              this.selectedPodcast = 'Tech Hour'
              this.showDialog = true
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }

        // Podcast 4
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 5 }) {
              Text('Design Flow')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
              Text('30 min episode')
                .fontSize(14)
                .fontColor('#082F49')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

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
              this.selectedPodcast = 'Design Flow'
              this.showDialog = true
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
      }
      .padding({ top: 12, bottom: 12 })
      .backgroundColor('#F0F9FF')
      .width('100%')
      .layoutWeight(1)

      // === Bottom Spacer ===
      Blank().height(20)

      // === Dialog overlay ===
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          // Semi-transparent background
          Column()
            .width('100%').height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false
            })

          // Dialog box
          Column({ space: 12 }) {
            Text('Playing Podcast')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Text('Streaming audio...')
              .fontSize(16)
              .fontColor('#666666')
            Button() {
              Text('OK')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width(80).height(40)
            .backgroundColor('#38BDF8')
            .borderRadius(8)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#4D000000' })
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
    .padding(0)
  }
}