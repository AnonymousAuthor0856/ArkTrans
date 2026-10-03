@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private tabsIndexed: string[] = ['Podcasts', 'History', 'Downloads']
  private podcasts: string[] = ['Tech Talk', 'Daily News', 'Science Weekly']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content ===
      Column({ space: 16 }) {
        // === SingleChoiceSegmentedButtonRow ===
        Row({ space: 8 }) {
          ForEach(this.tabsIndexed, (label: string, index: number) => {
            Button(label)
              .width('33%')
              .height(36)
              .backgroundColor(this.selectedTab === index ? '#0EA5E9' : '#FFFFFF')
              .borderRadius(8)
              .onClick(() => {
                this.selectedTab = index
              })
          })
        }.width('100%')

        // === Podcast List ===
        Column({ space: 12 }) {
          ForEach(this.podcasts, (it: string) => {
            Column() {
              Row({ space: 0 }) {
                Column({ space: 4 }) {
                  Text(it)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                  Text('30 min episode')
                    .fontSize(14)
                    .fontColor('#082F49')
                }
                Blank()
                Button('Play')
                  .backgroundColor('#38BDF8')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .onClick(() => {
                    this.showDialog = true
                  })
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(16)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
          })
        }
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F0F9FF')

      // === AlertDialog ===
      if (this.showDialog) {
        Stack() {
          Column() {
            Text('Playing Podcast')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#082F49')
              .margin({ bottom: 8 })
            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#082F49')
              .margin({ bottom: 24 })
            Button('OK')
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .width(80)
              .height(40)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width('80%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .alignSelf(ItemAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
        .onClick(() => {
          this.showDialog = false
        })
      }

      // === CenterAlignedTopAppBar ===
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}