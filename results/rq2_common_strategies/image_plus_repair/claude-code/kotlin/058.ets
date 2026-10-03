@Entry
@Component
struct StepChallengeApp {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 16, left: 16, right: 16 })
        .backgroundColor('#E5E7EB')

      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar(this.tabs[0])

        TabContent() {
          RankingPage()
        }
        .tabBar(this.tabs[1])

        TabContent() {
          StatsPage()
        }
        .tabBar(this.tabs[2])
      }
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .barBackgroundColor('#FFFFFF')
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}

@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(600)
        .fontColor('#1F2937')
        .margin({ top: 24, bottom: 16 })

      Blank()
        .height(16)

      Button('Sync Device', { type: ButtonType.Normal })
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#111827')
        .borderRadius(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RankingPage {
  private steps: number[] = [9000, 8500, 8000, 7500, 7000];

  build() {
    Column() {
      ForEach(this.steps, (item: number, index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontSize(14)
            .fontColor('#1F2937')

          Text(`${item} steps`)
            .fontSize(14)
            .fontColor('#1F2937')
        }
        .width('100%')
        .padding(12)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E5E7EB')
        .borderRadius(12)
        .margin({ bottom: 8 })
      }, (item: number, index: number) => `${index}`)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}

@Component
struct StatsPage {
  private progress: number[] = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

  build() {
    Column() {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(600)
        .fontColor('#1F2937')
        .margin({ bottom: 16 })

      ForEach(this.progress, (item: number, index: number) => {
        Row() {
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(20)
              .backgroundColor('#E5E7EB')
              .borderRadius(8)

            Row()
              .width(`${item * 100}%`)
              .height(20)
              .backgroundColor('#111827')
              .borderRadius(8)
          }
          .width('100%')
        }
        .width('100%')
        .margin({ bottom: 8 })
      }, (item: number, index: number) => `${index}`)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
