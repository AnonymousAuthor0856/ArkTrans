@Entry
@Component
struct StepChallenge {
  @State selectedTab: number = 0

  tabs: string[] = ['Overview', 'Ranking', 'Stats']
  weeklyProgress: number[] = [30, 40, 50, 60, 70, 80, 90]

  build() {
    Column() {
      this.Header()
      this.TabBar()

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
    .linearGradient({
      angle: 180,
      colors: [
        ['#E5E7EB', 0.0],
        ['#FFFFFF', 1.0]
      ]
    })
  }

  @Builder
  Header() {
    Row() {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
    }
    .width('100%')
    .height(65)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#E5E7EB')
  }

  @Builder
  TabBar() {
    Column() {
      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Stack({ alignContent: Alignment.Center }) {
            Text(title)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? '#111827' : '#1F2937')

            if (this.selectedTab === index) {
              Blank()
                .width('100%')
                .height(3)
                .backgroundColor('#111827')
                .align(Alignment.Bottom)
            }
          }
          .width('33.3333%')
          .height('100%')
          .onClick(() => {
            this.selectedTab = index
          })
        }, (title: string) => title)
      }
      .width('100%')
      .height(48)
      .backgroundColor('#FFFFFF')

      Divider()
        .width('100%')
        .height(1)
        .color('#D1D5DB')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  OverviewPage() {
    Column() {
      Text('Today\'s Steps: 8452')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F2937')
        .margin({ top: 16 })

      Blank()
        .height(40)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Sync Device')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .width('60%')
      .height(48)
      .borderRadius(16)
      .backgroundColor('#111827')
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .alignItems(HorizontalAlign.Center)
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
        .padding(12)
        .borderRadius(12)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E5E7EB')
      }, (index: number) => index.toString())
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
        .margin({ bottom: 4 })

      ForEach(this.weeklyProgress, (value: number, index: number) => {
        Row() {
          Blank()
            .height('100%')
            .width(`${value}%`)
            .borderRadius(8)
            .backgroundColor('#111827')
        }
        .width('100%')
        .height(20)
        .borderRadius(8)
        .backgroundColor('#E5E7EB')
      }, (value: number, index: number) => `${index}-${value}`)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
