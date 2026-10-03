@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

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

      // Main Content
      Column({ space: 16 }) {
        // Spending Card
        Column({ space: 12 }) {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06B6D4')

          Text(`$${Math.floor(this.spending)} / $${this.goal}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor('#E0F2FE')

            Row()
              .width(`${Math.min(this.spending / this.goal, 1) * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor('#06B6D4')
          }
          .width('100%')
        }
        .width('100%')
        .height(160)
        .padding(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 })

        // Adjust Spending Label
        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')

        // Slider
        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#E0F2FE')
          .selectedColor('#06B6D4')
          .blockColor('#3B82F6')
          .onChange((value: number) => {
            this.spending = value
          })

        // Reset Button
        Button('Reset')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#8B5CF6')
          .borderRadius(12)
          .onClick(() => {
            this.spending = 0
          })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(59,130,246,0.3)', 0.0],
          ['#F0F9FF', 0.5],
          ['rgba(6,182,212,0.2)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}