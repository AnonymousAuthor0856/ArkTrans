@Entry
@Component
struct InstallmentPlanApp {
  @State paymentProgress: number = 0.3

  build() {
    Column() {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFBF2')

      // Content Area
      Column({ space: 16 }) {
        // Surface with Canvas
        Stack() {
          // Background Surface
          Column()
            .width('100%')
            .height(240)
            .borderRadius(20)
            .backgroundColor('#FFFFFF')
            .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })

          // Canvas Drawing
          Canvas(this.canvasRenderingContext2D)
            .padding(16)
            .width('100%')
            .height(240)
        }
        .width('100%')
        .height(240)

        // Payment Progress Label
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')
          .width('100%')
          .textAlign(TextAlign.Center)

        // Custom Linear Progress Indicator
        Row() {
          // Track
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor('#FFEED6')

          // Progress Fill
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor('#FFA500')
        }
        .width('100%')
        .position({ x: 0, y: 0 })
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.Start)
        .clip(true)

        // Custom Slider
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .trackColor('#FFEED6')
          .selectedColor('#FFA500')
          .blockColor('#FFC107')
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        // Reset Button
        Button() {
          Text('Reset Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FFE066')
        .borderRadius(12)
        .onClick(() => {
          this.paymentProgress = 0.0
        })
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [
          ['#FFC107', 0.25],
          ['#FFFBF2', 0.5],
          ['#FFA500', 0.25]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }

  private canvasRenderingContext2D = new CanvasRenderingContext2D()
}