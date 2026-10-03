@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private readonly goal: number = 1000

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      // Main Content Area
      Column() {
        // Surface Card
        Column({ space: 16 }) {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06B6D4')
            .alignSelf(ItemAlign.Start)

          Text(`$${this.spending} / $${this.goal}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .alignSelf(ItemAlign.Start)

          // Linear Progress Indicator
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Rect().fill('#E0F2FE').borderRadius(4).width('100%').height(8)
            // Progress
            Rect()
              .fill('#06B6D4')
              .borderRadius(4)
              .width(`${(this.spending / this.goal) * 100}%`)
              .height(8)
          }.width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFF')
        .borderRadius(20)
        .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })

        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
          .margin({ top: 16, bottom: 16 })

        // Slider
        Slider({ value: this.spending, min: 0, max: 2000 })
          .width('100%')
          .trackColor('#E0F2FE')
          .selectedColor('#06B6D4')
          .blockColor('#FFF')

        // Button
        Button() {
          Text('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFF')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#8B5CF6')
        .borderRadius(12)
        .margin({ top: 16 })
        .onClick(() => {
          this.spending = 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 90,
        colors: [
          ['#3B82F6', 0.3],
          ['#F0F9FF', 0.5],
          ['#06B6D4', 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}