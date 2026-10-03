@Entry
@Component
struct BillCalendarPage {
  @State spending: number = 500;
  private goal: number = 1000;

  build() {
    Column() {
      Text("Bill Calendar")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor("#0F172A")
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor("#F0F9FF")

      Column() {
        Column() {
          Text("Current Spending")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor("#06B6D4")
            .width('100%')

          Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor("#0F172A")
            .width('100%')
            .margin({ top: 8 })

          Progress({ value: (this.spending / this.goal) * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color("#06B6D4")
            .backgroundColor("#E0F2FE")
            .borderRadius(4)
            .margin({ top: 8 })
        }
        .width('100%')
        .height(160)
        .padding(16)
        .backgroundColor("rgba(255, 255, 255, 0.9)")
        .borderRadius(20)
        .justifyContent(FlexAlign.SpaceBetween)
        .shadow({
          radius: 8,
          color: "rgba(0, 0, 0, 0.18)",
          offsetY: 4
        })

        Text("Adjust Spending")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0F172A")
          .margin({ top: 16 })

        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor("#3B82F6")
          .trackColor("#E0F2FE")
          .selectedColor("#06B6D4")
          .onChange((value: number) => {
            this.spending = value;
          })
          .margin({ top: 8 })

        Button("Reset")
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#FFFFFF")
          .backgroundColor("#8B5CF6")
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.spending = 0;
          })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ["rgba(6, 182, 212, 0.2)", 0.0],
          ["#F0F9FF", 0.5],
          ["rgba(59, 130, 246, 0.3)", 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F0F9FF")
  }
}
