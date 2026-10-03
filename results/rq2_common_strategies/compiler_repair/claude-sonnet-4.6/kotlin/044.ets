@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45

  build() {
    Column({ space: 16 }) {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')

      // Order Card
      Column({ space: 10 }) {
        Text('Order #25491')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .width('100%')

        Text('Estimated Delivery: 2 days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFB74D')
          .width('100%')

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

          Text(`${Math.floor(this.progress * 100)}%`)
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
      .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })

      // Adjust Progress Card
      Column({ space: 10 }) {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Center)

        Slider({
          value: this.progress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#FFE0B2')
          .selectedColor('#FF7043')
          .blockColor('#FF7043')
          .onChange((value: number) => {
            this.progress = value / 100
          })

        Button('Mark as Delivered')
          .width('100%')
          .height(48)
          .backgroundColor('#FF7043')
          .borderRadius(10)
          .fontColor('#FFFFFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.progress = 1.0
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF3E0')
    .alignItems(HorizontalAlign.Start)
  }
}