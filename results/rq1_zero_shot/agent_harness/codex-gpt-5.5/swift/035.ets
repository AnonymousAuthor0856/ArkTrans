@Entry
@Component
struct RootScreen {
  @State private progressValue: number = 0.5;

  @Builder
  ChartSurface() {
    Stack() {
      Rect()
        .width('100%')
        .height(260)
        .fill('#FFFFFF')
        .radius(16)
      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], (i: number) => {
          Rect()
            .width(18)
            .height(30 + Math.abs(Math.sin(i * Math.PI / 4 + this.progressValue * Math.PI)) * 150)
            .fill('#2563EB')
            .radius(4)
            .margin({ left: 4, right: 4 })
        }, (i: number) => i.toString())
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(260)
    .shadow({ radius: 8, color: '#2E0F172A', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(56)
          .fill('#F8FAFC')
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .height(56)

      Column() {
        this.ChartSurface()
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .margin({ top: 14 })
        Slider({ value: this.progressValue, min: 0, max: 1, step: 0.01 })
          .selectedColor('#2563EB')
          .trackColor('#E2E8F0')
          .width('100%')
          .height(44)
          .margin({ top: 14 })
          .onChange((value: number) => {
            this.progressValue = value;
          })
        Progress({ value: this.progressValue, total: 1, type: ProgressType.Linear })
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
          .width('100%')
          .height(8)
          .margin({ top: 14 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
