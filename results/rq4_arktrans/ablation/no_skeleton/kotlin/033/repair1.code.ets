@Entry
@Component
struct BillCalendar {
  @State spending: number = 500
  private readonly goal: number = 1000

  build() {
    Column() {
      // Top Bar
      Text('Bill Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 16 })

      // Main Content Area
      Column({ space: 16 }) {
        // Spending Card
        Column({ space: 12 }) {
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

          Progress({
            value: this.spending,
            total: this.goal,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(8)
            .color('#06B6D4')
            .backgroundColor('#E0F2FE')
        }
        .width('100%')
        .height(160)
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })

        // Slider Section
        Column({ space: 16 }) {
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
            .textAlign(TextAlign.Center)
            .width('100%')

          Slider({
            value: this.spending,
            min: 0,
            max: 2000
          })
            .width('100%')
            .selectedColor('#06B6D4')
            .trackColor('#E0F2FE')
            .blockColor('#3B82F6')
        }
        .width('100%')

        // Reset Button
        Button('Reset')
          .width('100%')
          .height(48)
          .backgroundColor('#8B5CF6')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {
            this.spending = 0
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#06B6D4', 0.2],
        ['#F0F9FF', 0.5],
        ['#3B82F6', 0.3]
      ]
    })
  }
}