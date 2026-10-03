@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 0.45

  build() {
    Column({ space: 16 }) {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')

      Column({ space: 10 }) {
        Text('Order #25491')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')

        Text('Estimated Delivery: 2 days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFB74D')

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(10)
          .color('#FF7043')
          .backgroundColor('#FFE0B2')

        Row() {
          Text('Processing')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFB74D')
          Text(Math.round(this.progress * 100).toString() + '%')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF7043')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)

      Column({ space: 10 }) {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor('#FF7043')
          .selectedColor('#FF7043')
          .trackColor('#FFE0B2')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value
          })

        Button('Mark as Delivered')
          .width('100%')
          .height(40)
          .backgroundColor('#FF7043')
          .borderRadius(10)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .onClick(() => {
            this.progress = 1
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF3E0')
  }
}
