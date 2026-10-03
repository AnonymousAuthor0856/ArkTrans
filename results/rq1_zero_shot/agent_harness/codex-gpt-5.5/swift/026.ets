@Entry
@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0;

  @Builder
  DocumentSurface() {
    Column() {
      Text('Document Reader')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
      ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
        Text('This is a sample line of text content number ' + index.toString() + '.')
          .fontSize(14)
          .fontColor('#1E1E1E')
          .margin({ top: 12 })
      }, (index: number) => index.toString())
      Blank()
    }
    .width('90%')
    .height(400)
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
    .translate({ y: this.scrollOffsetY / 5 })
    .onClick(() => {
      this.scrollOffsetY += 20;
    })
  }

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 36, bottom: 16 })
        .backgroundColor('#F1F5F9')

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#F1F5F9')
        this.DocumentSurface()
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F1F5F9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
