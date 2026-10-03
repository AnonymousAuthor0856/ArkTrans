@Entry
@Component
struct Index {
  @State currentPage: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      // Header
      Row() {
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      // Tab Bar
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentPage === index ? '#111827' : '#1F2937')
              .padding({ top: 12, bottom: 12, left: 16, right: 16 })
            Divider()
              .height(2)
              .backgroundColor(this.currentPage === index ? '#111827' : 'transparent')
          }
          .onClick(() => {
            this.currentPage = index
          })
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')

      // Page Content
      if (this.currentPage === 0) {
        this.OverviewPage()
      } else if (this.currentPage === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
    })
  }

  @Builder
  OverviewPage() {
    Column({ space: 12 }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')

      Blank().height(16)

      Button('Sync Device')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#111827')
        .borderRadius(16)
        .width('60%')
        .height(48)
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  RankingPage() {
    Column({ space: 8 }) {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text('User ' + (index + 1))
            .fontSize(14)
            .fontColor('#1F2937')
          Text((9000 - index * 500) + ' steps')
            .fontSize(14)
            .fontColor('#1F2937')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E5E7EB')
        .borderRadius(12)
        .padding(12)
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StatsPage() {
    Column({ space: 8 }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor('#E5E7EB')
            .borderRadius(8)

          Row()
            .width(((0.3 + index * 0.1) > 1.0 ? 1.0 : (0.3 + index * 0.1)) * 100 + '%')
            .height(20)
            .backgroundColor('#111827')
            .borderRadius(8)
        }
        .width('100%')
        .height(20)
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}