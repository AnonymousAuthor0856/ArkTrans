@Entry
@Component
struct Index {
  @State prevY: number = 0
  @State y: number = 0
  @State marketTrend: number = 0
  @State fontSize: number = 24
  @State syncProgress: number = 0.3
  @State stockKLine: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        // Surface equivalent
        Column() {
          Canvas().width('100%').height('100%')
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
        .height(260)

        Text('Market Trend')
          .fontColor('#2563EB')
          .fontSize(this.fontSize)

        Slider({ value: this.syncProgress, min: 0, max: 1 })
          .onChange((value: number) => {
            this.syncProgress = value
          })
          .width('100%')

        Progress({
          value: this.syncProgress,
          total: 1,
          type: ProgressType.Linear
        })
        .width('100%')
        .height(8)
        .color('#2563EB')
        .backgroundColor('#E2E8F0')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#E2E8F0', 0.0], // Approximating secondary with alpha
          ['#F8FAFC', 0.5], // Background
          ['#2563EB', 1.0]  // Approximating primary with alpha
        ]
      })

      // CenterAlignedTopAppBar equivalent using Row/Column structure
      Row() {
        Text('Stock K-Line')
          .fontColor('#0F172A')
          .fontSize(32) // DisplayLarge approx
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
  }
}