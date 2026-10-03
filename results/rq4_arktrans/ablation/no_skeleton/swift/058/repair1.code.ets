@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ["Overview", "Ranking", "Stats"]

  build() {
    Column() {
      // Header
      Text("Step Challenge")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .padding(16)
        .textAlign(TextAlign.Center)
        .width('100%')
        .backgroundColor('#E5E7EB')

      // Custom TabRow
      this.CustomTabRow()

      // Content Area (Simulating TabView with conditional rendering for stability)
      if (this.selectedTabIndex === 0) {
        this.OverviewPage()
      } else if (this.selectedTabIndex === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  CustomTabRow() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button(tab)
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .fontColor(this.selectedTabIndex === index ? '#111827' : '#1F2937')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .padding({ top: 12, bottom: 12 })
            .layoutWeight(1)
            .onClick(() => {
              this.selectedTabIndex = index
            })
        })
      }
      .width('100%')

      // Underline Indicator
      Row() {
        Blank()
        if (this.selectedTabIndex === 0) {
          Rectangle()
            .fill('#111827')
            .height(2)
            .layoutWeight(1)
        } else {
          Blank().layoutWeight(1)
        }
        
        if (this.selectedTabIndex === 1) {
          Rectangle()
            .fill('#111827')
            .height(2)
            .layoutWeight(1)
        } else {
          Blank().layoutWeight(1)
        }

        if (this.selectedTabIndex === 2) {
          Rectangle()
            .fill('#111827')
            .height(2)
            .layoutWeight(1)
        } else {
          Blank().layoutWeight(1)
        }
      }
      .width('100%')
    }
    .backgroundColor('#FFFFFF')
  }

  @Builder
  OverviewPage() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1F2937')
      
      Blank().height(16)

      Button("Sync Device")
        .type(ButtonType.Capsule)
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('60%')
        .height(48)

      Blank()
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  RankingPage() {
    Column() {
      List({ space: 8 }) {
        ForEach(Array.from({ length: 5 }, (_, i) => i), (index: number) => {
          ListItem() {
            Row() {
              Text(`User ${index + 1}`)
                .fontSize(14)
                .fontColor('#1F2937')
              
              Blank()

              Text(`${9000 - index * 500} steps`)
                .fontSize(14)
                .fontColor('#1F2937')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#E5E7EB')
            .borderRadius(12)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column() {
      Text("Weekly Progress")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1F2937')
      
      Column({ space: 8 }) {
        ForEach(Array.from({ length: 7 }, (_, i) => i), (index: number) => {
          Column() {
            // Background Bar
            Row() {
              // Foreground Bar
              Row() {
                Text("")
              }
              .width(`${Math.min(30 + index * 10, 100)}%`)
              .backgroundColor('#111827')
              .borderRadius(8)
            }
            .width('100%')
            .height(20)
            .backgroundColor('#E5E7EB')
            .borderRadius(8)
          }
        })
      }
      
      Blank()
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }
}