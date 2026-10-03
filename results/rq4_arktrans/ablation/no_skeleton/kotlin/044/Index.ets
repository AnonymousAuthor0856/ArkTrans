@Entry
@Component
struct OrderTracking {
  @State progress: number = 0.45

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .margin({ bottom: 16 })

      // Card 1: Order Info
      Column() {
        Text('Order #25491')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .margin({ bottom: 10 })

        Text('Estimated Delivery: 2 days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFB74D')
          .margin({ bottom: 10 })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(10)
          .color('#FF7043')
          .backgroundColor('#FFE0B2')
          .margin({ bottom: 10 })

        Row() {
          Text('Processing')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFB74D')
          
          Blank()
          
          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF7043')
        }.width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
      .margin({ bottom: 16 })

      // Card 2: Adjust Progress
      Column() {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 10 })

        Slider({ value: this.progress * 100, min: 0, max: 100 })
          .width('100%')
          .selectedColor('#FF7043')
          .trackColor('#FFE0B2')
          .margin({ bottom: 16 })

        Button('Mark as Delivered')
          .width('100%')
          .backgroundColor('#FF7043')
          .fontColor('#FFF')
          .borderRadius(10)
          .onClick(() => {
            this.progress = 1.0
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF3E0')
  }
}