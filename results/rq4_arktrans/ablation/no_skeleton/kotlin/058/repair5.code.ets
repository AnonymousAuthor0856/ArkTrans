@Entry
@Component
struct RootScreen {
  @State currentPage: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      // Header
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#E5E7EB')

      // Tabs
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentPage === index ? '#111827' : '#1F2937')
              .textAlign(TextAlign.Center)
            Divider()
              .width(this.currentPage === index ? '100%' : '0%')
              .color('#111827')
              .strokeWidth(4)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentPage = index
          })
        })
      }
      .width('100%')
      .height(48)
      .backgroundColor('#FFFFFF')

      // Content Area
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
      angle: 90,
      colors: [['#E5E7EB', 0], ['#FFFFFF', 1]]
    })
  }

  @Builder
  OverviewPage() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ top: 24 })

      Button('Sync Device')
        .width('60%')
        .height(48)
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .borderRadius(16)
        .margin({ top: 24 })
    }
    .width('100%')
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RankingPage() {
    Column() {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontColor('#1F2937')
          Blank()
          Text(`${9000 - index * 500} steps`)
            .fontColor('#1F2937')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(12)
        .backgroundColor('#E5E7EB')
        .borderRadius(12)
        .margin({ bottom: 8 })
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column() {
      Text("Weekly Progress")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ bottom: 16 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Row() {
          Row() {
            // Simulating the progress bar width based on index
            // Widths roughly corresponding to 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9
            let widthPercent = 0.3 + index * 0.1
            if (widthPercent > 1) widthPercent = 1
            
            Row()
              .width(`${Math.round(widthPercent * 100)}%`)
              .height(20)
              .backgroundColor('#111827')
              .borderRadius(8)
          }
          .width('100%')
          .height(20)
          .backgroundColor('#E5E7EB')
          .borderRadius(8)
        }
        .width('100%')
        .margin({ bottom: 8 })
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}