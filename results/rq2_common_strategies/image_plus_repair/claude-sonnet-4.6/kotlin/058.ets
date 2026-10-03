@Entry
@Component
struct Index {
  @State selectedTab: number = 0

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
      .backgroundColor('#E5E7EB')

      // Tab Bar
      Row() {
        ForEach(['Overview', 'Ranking', 'Stats'], (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? '#111827' : '#1F2937')
              .padding({ top: 12, bottom: 12 })
            Divider()
              .strokeWidth(2)
              .color(this.selectedTab === index ? '#111827' : 'transparent')
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTab = index
          })
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 1 }, color: '#D1D5DB' })

      // Page Content
      if (this.selectedTab === 0) {
        this.OverviewPage()
      } else if (this.selectedTab === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E5E7EB')
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
    .backgroundColor('#F9FAFB')
  }

  @Builder
  RankingPage() {
    Column({ space: 8 }) {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontSize(14)
            .fontColor('#1F2937')
          Text(`${9000 - index * 500} steps`)
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
    .backgroundColor('#F9FAFB')
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
            .width(`${Math.min((0.3 + index * 0.1) * 100, 100)}%`)
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
    .backgroundColor('#F9FAFB')
  }
}