@Entry
@Component
struct Index {
  @State currentTab: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // Header
        Stack({ alignContent: Alignment.Center }) {
          Text('Step Challenge')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
        }
        .width('100%')
        .padding(16)

        // TabRow
        Row({ space: 0 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button() {
              Text(tab)
                .fontColor(this.currentTab === index ? '#6750A4' : '#1F2937')
                .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal)
            }
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.currentTab = index
            })
          })
        }
        .width('100%')
        .borderWidth({ bottom: 1 })
        .borderColor('#E5E7EB')

        // Content Area based on Tab
        if (this.currentTab === 0) {
          this.OverviewPage()
        } else if (this.currentTab === 1) {
          this.RankingPage()
        } else {
          this.StatsPage()
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  OverviewPage() {
    Column({ space: 12 }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F2937')

      Blank().height(16)

      Button('Sync Device')
        .width('60%')
        .height(48)
        .backgroundColor('#6750A4')
        .borderRadius(12)
        .onClick(() => {
          // Sync logic
        })
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  RankingPage() {
    Column({ space: 8 }) {
      List({ space: 8 }) {
        ForEach([0, 1, 2, 3, 4], (index: number) => {
          ListItem() {
            Row({ space: 0 }) {
              Text(`User ${index + 1}`)
                .fontColor('#1F2937')
                .layoutWeight(1)
              
              Text(`${9000 - index * 500} steps`)
                .fontColor('#1F2937')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 2, color: '#1F000000', offsetY: 1 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column({ space: 8 }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F2937')

      Column({ space: 8 }) {
        ForEach([0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], (value: number) => {
          Row({ space: 0 }) {
            Stack() {
              // Background track
              Rect()
                .fill('#E5E7EB')
                .borderRadius(4)
            }
            .width('100%')
            .height(20)
            
            // Foreground progress
            Row() {
              Rect()
                .fill('#6750A4')
                .borderRadius(4)
            }
            .width(`${value * 100}%`)
            .height(20)
          }
          .width('100%')
          .height(20)
          .clip(true)
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }
}