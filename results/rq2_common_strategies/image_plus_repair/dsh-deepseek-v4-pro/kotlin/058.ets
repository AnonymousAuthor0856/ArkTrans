@Entry
@Component
struct StepChallengePage {
  @State currentIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private rankingIndices: number[] = [0, 1, 2, 3, 4]
  private barIndices: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column() {
      Row() {
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      Row() {
        ForEach(this.tabs, (title: string, idx: number) => {
          Column() {
            Text(title)
              .fontSize(14)
              .fontWeight(idx === this.currentIndex ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(idx === this.currentIndex ? '#111827' : '#1F2937')
              .textAlign(TextAlign.Center)
              .width('100%')
              .padding({ top: 12, bottom: 12 })
            Row() {}
              .width('100%')
              .height(2)
              .backgroundColor(idx === this.currentIndex ? '#111827' : '#00000000')
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentIndex = idx
          })
        }, (title: string) => title)
      }
      .width('100%')

      Swiper() {
        this.OverviewPage()
        this.RankingPage()
        this.StatsPage()
      }
      .index(this.currentIndex)
      .indicator(false)
      .loop(false)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#E5E7EB', 0], ['#FFFFFF', 1]]
    })
  }

  @Builder
  OverviewPage() {
    Column({ space: 12 }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F2937')

      Blank()
        .height(16)

      Button() {
        Text('Sync Device')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .width('60%')
      .height(48)
      .backgroundColor('#111827')
      .borderRadius(16)
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RankingPage() {
    Column({ space: 8 }) {
      ForEach(this.rankingIndices, (it: number) => {
        Row() {
          Text('User ' + (it + 1))
            .fontSize(14)
            .fontColor('#1F2937')
          Text((9000 - it * 500) + ' steps')
            .fontSize(14)
            .fontColor('#1F2937')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E5E7EB')
        .borderRadius(12)
        .padding(12)
      }, (it: number) => it.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column({ space: 8 }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F2937')

      ForEach(this.barIndices, (it: number) => {
        Row() {
          Row() {}
            .width((30 + it * 10) + '%')
            .height(20)
            .backgroundColor('#111827')
            .borderRadius(8)
        }
        .width('100%')
        .height(20)
        .backgroundColor('#E5E7EB')
        .borderRadius(8)
      }, (it: number) => it.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
