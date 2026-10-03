@Entry
@Component
struct RootScreen {
  @State private progressValue: number = 0.42;

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
      Progress({ value: this.progressValue, total: 1, type: ProgressType.Linear })
        .color('#FF7042')
        .backgroundColor('#FFE0B3')
        .width('100%')
        .height(10)
        .margin({ top: 10 })
      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFB84D')
        Blank()
        Text(Math.round(this.progressValue * 100).toString() + '%')
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
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  AdjustCard() {
    Column() {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3D2624')
        .width('100%')
        .textAlign(TextAlign.Center)
      Slider({ value: this.progressValue, min: 0, max: 1, step: 0.01 })
        .selectedColor('#FF7042')
        .trackColor('#FFE0B3')
        .width('100%')
        .margin({ top: 10 })
        .onChange((value: number) => {
          this.progressValue = value;
        })
      Button('Mark as Delivered')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF7042')
        .width('100%')
        .height(42)
        .borderRadius(10)
        .margin({ top: 10 })
        .onClick(() => {
          this.progressValue = 1.0;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D2624')
        .width('100%')
      this.OrderCard()
        .margin({ top: 16 })
      this.AdjustCard()
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF2E0')
  }
}
