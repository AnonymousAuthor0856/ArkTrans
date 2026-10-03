@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Stack() {
      Column() {
        // Header
        Text('Step Challenge')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding(12)
          .fontColor('#111827')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#E5E7EB')

        // Tab Bar Container
        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button(tab)
                .type(ButtonType.Normal)
                .backgroundColor(Color.Transparent)
                .width('33.33%')
                .height(44)
                .fontSize(16)
                .fontColor(this.selectedTabIndex === index ? '#111827' : '#6B7280')
                .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
                .borderWidth(this.selectedTabIndex === index ? 2 : 0)
                .borderColor('#111827')
                .borderRadius({ bottomLeft: 4, bottomRight: 4 })
                .onClick(() => {
                  this.selectedTabIndex = index
                })
            })
          }.width('100%')

          // Animated Indicator
          Rect()
            .width('33.33%')
            .height(2)
            .fill('#111827')
            .position({ x: `${this.selectedTabIndex * (100 / 3)}%`, y: 44 })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }.width('100%').backgroundColor('#FFFFFF')

        // Content Area
        Column() {
          if (this.selectedTabIndex === 0) {
            // Overview Tab
            Column() {
              Text("Today's Steps: 8452")
                .fontSize(20)
                .fontColor('#1F2937')
                .textAlign(TextAlign.Center)
                .margin({ top: 24, bottom: 24 })

              Button('Sync Device')
                .width('60%')
                .height(48)
                .backgroundColor('#111827')
                .fontColor('#FFFFFF')
                .borderRadius(24)
                .fontSize(16)
            }.width('100%').layoutWeight(1).justifyContent(FlexAlign.Start)
          } else if (this.selectedTabIndex === 1) {
            // Ranking Tab
            Column() {
              let rankingData: number[] = [0, 1, 2, 3, 4];
              ForEach(rankingData, (index: number) => {
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
                .backgroundColor('#F3F4F6')
                .borderRadius(8)
                .margin({ bottom: 8 })
              })
            }.width('100%').layoutWeight(1).padding(12)
          } else {
            // Stats Tab
            Column() {
              Text('Weekly Progress')
                .fontSize(20)
                .fontColor('#1F2937')
                .margin({ bottom: 16 })

              let statsData: number[] = [0, 1, 2, 3, 4, 5, 6];
              ForEach(statsData, (index: number) => {
                Row() {
                  Rect()
                    .width(`${30 + index * 10}%`)
                    .height(20)
                    .fill('#111827')
                    .borderRadius(4)
                  Blank()
                }
                .width('100%')
                .height(20)
                .backgroundColor('#F3F4F6')
                .borderRadius(4)
                .margin({ bottom: 8 })
              })
              Blank()
            }.width('100%').layoutWeight(1).padding(12)
          }
        }.width('100%').layoutWeight(1).backgroundColor('#FFFFFF')
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}