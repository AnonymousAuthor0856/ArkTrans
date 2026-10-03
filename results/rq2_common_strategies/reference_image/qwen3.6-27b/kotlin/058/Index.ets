@Entry
@Component
struct StepChallengeApp {
  @State currentPage: number = 0
  private tabs: string[] = ["Overview", "Ranking", "Stats"]

  build() {
    Column() {
      // Header
      Text("Step Challenge")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 24, bottom: 16 })
        .backgroundColor('#E5E7EB')

      // Tab Row
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontWeight(this.currentPage === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.currentPage === index ? '#111827' : '#1F2937')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            
            if (this.currentPage === index) {
              Divider()
                .color('#111827')
                .width('100%')
                .strokeWidth(3)
            }
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentPage = index
          })
        })
      }
      .width('100%')
      .backgroundColor(Color.White)

      // Content Area
      Column() {
        if (this.currentPage === 0) {
          OverviewPage()
        } else if (this.currentPage === 1) {
          RankingPage()
        } else {
          StatsPage()
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1F2937')
        .margin({ top: 24, bottom: 32 })
      
      Button("Sync Device")
        .type(ButtonType.Capsule)
        .backgroundColor('#111827')
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('60%')
        .height(48)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .padding(16)
  }
}

@Component
struct RankingPage {
  build() {
    Column() {
      ForEach([1, 2, 3, 4, 5], (index: number) => {
        Row() {
          Text(`User ${index}`)
            .fontColor('#1F2937')
            .fontSize(14)
          
          Blank().layoutWeight(1)
          
          Text(`${9000 - (index - 1) * 500} steps`)
            .fontColor('#1F2937')
            .fontSize(14)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#E5E7EB')
        .borderRadius(12)
        .margin({ bottom: 8 })
      })
    }
    .width('100%')
    .padding(16)
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text("Weekly Progress")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1F2937')
        .margin({ bottom: 16 })
      
      ForEach([0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], (progress: number) => {
        Row() {
          Row() {
            // Progress bar fill
          }
          .width(`${progress * 100}%`)
          .height(20)
          .backgroundColor('#111827')
          .borderRadius(8)
        }
        .width('100%')
        .height(20)
        .backgroundColor('#E5E7EB')
        .borderRadius(8)
        .margin({ bottom: 8 })
      })
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .padding(16)
  }
}