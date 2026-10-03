@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 0.42

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .margin({ top: 16, bottom: 16 })

      // Card 1: Order Info
      Row() {
        Column() {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .margin({ bottom: 8 })

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontColor('#FFB74D')
            .margin({ bottom: 12 })

          // Progress Bar
          Row() {
            Stack() {
              Rect()
                .width('100%')
                .height(10)
                .borderRadius(5)
                .backgroundColor('#FFE0B2')

              Rect()
                .width(`${this.progress * 100}%`)
                .height(10)
                .borderRadius(5)
                .backgroundColor('#FF7043')
            }
          }
          .width('100%')
          .margin({ bottom: 8 })

          // Status Row
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
          }
          .width('100%')
        }
        .padding(16)
        .width('100%')
      }
      .width('100%')
      .borderRadius(16)
      .backgroundColor(Color.White)
      .shadow({ radius: 8, color: '#0000001A', offsetY: 4 })
      .margin({ bottom: 16 })

      // Card 2: Adjust Progress
      Column() {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 16 })

        Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .trackThickness(10)
          .selectedColor('#FF7043')
          .inactiveColor('#FFE0B2')
          .blockColor('#FF7043')
          .onChange((value: number) => {
            this.progress = value
          })
          .margin({ bottom: 16 })

        Button('Mark as Delivered')
          .type(ButtonType.Normal)
          .backgroundColor('#FF7043')
          .fontColor(Color.White)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .width('100%')
          .onClick(() => {
            this.progress = 1
          })
      }
      .padding(16)
      .width('100%')
      .borderRadius(16)
      .backgroundColor(Color.White)
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF3E0')
  }
}