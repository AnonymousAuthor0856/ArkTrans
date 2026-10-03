@Entry
@Component
struct Index {
  @State prevY: number = 0
  @State y: number = 0
  @State paymentProgress: number = 0
  @State syncProgress: number = 0.3
  @State fontSize: number = 24
  @State resetProgress: number = 0
  @State installmentPlan: string = "Installment Plan"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface equivalent
        Column() {
          Canvas().width('100%').height('100%')
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
        .height(240)
        .borderRadius(16) // AppTokens.Shapes.large approximation

        // Text: Payment Progress
        Text('Payment Progress')
          .fontSize(16) // titleMedium approximation
          .fontColor('#FFA500')

        // LinearProgressIndicator
        Progress({ value: this.paymentProgress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA500')
          .trackColor('#FFEED6')

        // Slider
        Slider({ value: this.paymentProgress, min: 0, max: 100 })
          .width('100%')
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        // Button: Reset Progress
        Button() {
          Text('Reset Progress')
            .fontSize(16) // titleMedium approximation
        }
        .width('100%')
        .height(48)
        .backgroundColor('#E0E0E0') // Tertiary color approximation
        .fontColor('#000000') // OnTertiary color approximation
        .borderRadius(8) // Medium shape approximation
        .onClick(() => {
          this.paymentProgress = 0
        })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0E0E0', 0.25], ['#FFFBF2', 0.5], ['#E0E0E0', 0.75]] // Approximation of gradient
      })

      // CenterAlignedTopAppBar equivalent
      Row() {
        Text(this.installmentPlan)
          .fontSize(32) // displayLarge approximation
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')
    }
    .width('100%')
    .height('100%')
  }
}