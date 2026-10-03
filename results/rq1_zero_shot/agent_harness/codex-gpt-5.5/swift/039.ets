@Entry
@Component
struct RootScreen {
  @State private paymentProgress: number = 0.3;

  @Builder
  SurfaceWithCanvas() {
    Stack() {
      Rect()
        .width('100%')
        .height(240)
        .fill('#E6FFFFFF')
        .radius(20)
      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8], (i: number) => {
          Rect()
            .width(20)
            .height(34 + Math.abs(Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI)) * 145)
            .fill('#FFA500')
            .radius(4)
            .margin({ left: 5, right: 5 })
        }, (i: number) => i.toString())
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(240)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFBF2')

      Column() {
        this.SurfaceWithCanvas()
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')
          .margin({ top: 16 })
        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .color('#FFA500')
          .backgroundColor('#FFEED6')
          .width('100%')
          .height(8)
          .margin({ top: 16 })
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .selectedColor('#FFA500')
          .trackColor('#FFEED6')
          .width('100%')
          .margin({ top: 16 })
          .onChange((value: number) => {
            this.paymentProgress = value;
          })
        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .backgroundColor('#FFE066')
          .width('100%')
          .height(48)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#FFFBF2')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
