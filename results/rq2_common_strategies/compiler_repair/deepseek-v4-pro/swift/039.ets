@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3

  build() {
    Column({ space: 0 }) {
      // Top Bar (equivalent to CenterAlignedTopAppBar)
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#FF1E1E1E')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFFFBF2')

      // Main content
      Column({ space: 16 }) {
        // Surface Canvas (simulated with a Stack)
        Stack() {
          // Background of canvas (simulating wave)
          Column() { }
            .width('100%')
            .height('100%')
            .backgroundColor('#FFFFA500')
            .borderRadius(20)
            .opacity(0.2)
        }
        .width('100%')
        .height(240)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 })

        // Title
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FFFFA500')

        // Linear progress indicator
        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFFFA500')
          .backgroundColor('#FFFFEED6')
          .borderRadius(4)

        // Slider
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .height(48)
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        // Reset button
        Button() {
          Text('Reset Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF1E1E1E')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FFFFE066')
        .borderRadius(12)
        .onClick(() => {
          this.paymentProgress = 0.0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .linearGradient({
        colors: [['rgba(255,193,7,0.25)', 0], ['#FFFFFBF2', 0.5], ['rgba(255,165,0,0.25)', 1]],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFBF2')
  }
}