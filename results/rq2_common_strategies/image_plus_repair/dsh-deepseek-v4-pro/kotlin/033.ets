@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  private progressValue(): number {
    let p: number = this.spending / this.goal * 100
    if (p < 0) {
      return 0
    }
    if (p > 100) {
      return 100
    }
    return p
  }

  build() {
    Column() {
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

      Column() {
        Column() {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06B6D4')

          Text('$' + Math.floor(this.spending).toString() + ' / $' + Math.floor(this.goal).toString())
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')

          Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#06B6D4')
            .backgroundColor('#E0F2FE')
        }
        .width('100%')
        .height(160)
        .padding(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(20)

        Text('Adjust Spending')
          .margin({ top: 16 })
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')

        Slider({ value: this.spending, min: 0, max: 2000, style: SliderStyle.OutSet })
          .margin({ top: 16 })
          .blockColor('#3B82F6')
          .trackColor('#E0F2FE')
          .selectedColor('#06B6D4')
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.spending = value
          })

        Button('Reset')
          .margin({ top: 16 })
          .type(ButtonType.Normal)
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
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0], ['#F0F9FF', 0.5], ['#3306B6D4', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
