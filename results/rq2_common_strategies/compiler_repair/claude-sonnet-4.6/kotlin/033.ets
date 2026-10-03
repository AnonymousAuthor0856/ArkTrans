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
        // Current Spending Card
        Column({ space: 12 }) {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06B6D4')

          Text('$' + Math.floor(this.spending) + ' / $' + Math.floor(this.goal))
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')

          Progress({
            value: Math.min(Math.max(this.spending / this.goal, 0), 1) * 100,
            total: 100,
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
        .shadow({
          radius: 8,
          color: '#1E000000',
          offsetX: 0,
          offsetY: 4
        })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Start)

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
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4D3B82F6', 0.0],
        ['#F0F9FF', 0.5],
        ['#3306B6D4', 1.0]
      ]
    })
  }
}