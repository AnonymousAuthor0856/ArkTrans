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
        // Surface / Chart Card
        Column() {
          Canvas(this.getUIContext()).width('100%').height('100%')
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
        .width('100%')
        .height(260)

        // Text "Market Trend"
        Text('Market Trend')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')

        // Slider
        Slider({ value: this.syncProgress, min: 0, max: 1 })
          .width('100%')
          .trackColor({ active: '#60A5FA', inactive: '#E2E8F0' })
          .selectedColor('#2563EB')
          .blockColor('#2563EB')
          .onChange((value: number) => {
            this.syncProgress = value
          })

        // Linear Progress Indicator
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
      }
      .alignItems(HorizontalAlign.Center)
      .verticalCenter(VerticalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        angle: 90,
        colors: [['#DBEAFE', 0], ['#F8FAFC', 0.5], ['#DBEAFE', 1]]
      })

      // Top App Bar (Absolute positioned at top)
      Row() {
        Text('Stock K-Line')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}