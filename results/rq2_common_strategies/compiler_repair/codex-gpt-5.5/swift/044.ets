@Entry
@Component
struct Index {
  @State progress: number = 0.42

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(10)
        .radius(5)
        .fill('#FFE0B3')
      Rect()
        .width(`${Math.max(0, Math.min(100, this.progress * 100))}%`)
        .height(10)
        .radius(5)
        .fill('#FF7042')
    }
    .width('100%')
    .height(10)
  }

  @Builder
  OrderCard() {
    Column() {
      Text('Order #25491')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3D2624')
        .width('100%')

      Text('Estimated Delivery: 2 days')
        .fontSize(14)
        .fontColor('#FFB84D')
        .width('100%')
        .margin({ top: 10 })

      Column() {
        this.ProgressBar()
      }
      .width('100%')
      .margin({ top: 10 })

      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFB84D')
        Blank()
        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF7042')
      }
      .width('100%')
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
  }

  @Builder
  AdjustCard() {
    Column() {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3D2624')
        .textAlign(TextAlign.Center)
        .width('100%')

      Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
        .blockColor('#FF7042')
        .selectedColor('#FF7042')
        .trackColor('#FFE0B3')
        .width('100%')
        .margin({ top: 10 })
        .onChange((value: number) => {
          this.progress = value
        })

      Button('Mark as Delivered')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(42)
        .backgroundColor('#FF7042')
        .borderRadius(10)
        .margin({ top: 10 })
        .onClick(() => {
          this.progress = 1
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  build() {
    Stack() {
      Column() {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3D2624')
          .width('100%')

        Column() {
          this.OrderCard()
        }
        .margin({ top: 16 })

        Column() {
          this.AdjustCard()
        }
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF2E0')
  }
}
