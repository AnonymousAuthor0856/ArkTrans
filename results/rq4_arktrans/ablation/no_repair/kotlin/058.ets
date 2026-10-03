@Entry
@Component
struct Index {
  @State currentTab: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      // Header
      Text('Step Challenge')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ bottom: 16 })

      // Tabs
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(18)
              .fontColor(this.currentTab === index ? '#111827' : '#6B7280')
              .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)
            
            if (this.currentTab === index) {
              Divider()
                .width('100%')
                .strokeWidth(4)
                .color('#111827')
                .margin({ top: 4 })
            }
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentTab = index
          })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // Content Area
      Column() {
        if (this.currentTab === 0) {
          // Overview Page
          Column() {
            Text("Today's Steps: 8452")
              .fontSize(28)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F2937')
              .margin({ top: 24, bottom: 24 })

            Button('Sync Device')
              .backgroundColor('#111827')
              .fontColor('#FFFFFF')
              .fontSize(18)
              .height(48)
              .borderRadius(24)
              .width('60%')
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .layoutWeight(1)
        } else if (this.currentTab === 1) {
          // Ranking Page
          Column() {
            ForEach([0, 1, 2], (it: number) => {
              Row() {
                Text(`User ${it + 1}`)
                  .fontColor('#1F2937')
                  .fontSize(16)
                
                Blank()
                
                Text(`${9000 - it * 500} steps`)
                  .fontColor('#1F2937')
                  .fontSize(16)
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#E5E7EB')
              .borderRadius(8)
              .margin({ bottom: 8 })
            })
          }
          .width('100%')
          .layoutWeight(1)
        } else {
          // Stats Page
          Column() {
            Text('Weekly Progress')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F2937')
              .margin({ bottom: 16 })

            Row() {
              Stack() {
                // Simulating the progress bar fill
                Row()
                  .width('100%')
                  .height(20)
                  .backgroundColor('#111827')
                  .borderRadius(10)
              }
              .width('100%')
              .height(20)
              .backgroundColor('#E5E7EB')
              .borderRadius(10)
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .layoutWeight(1)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}