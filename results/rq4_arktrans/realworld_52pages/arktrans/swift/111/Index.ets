@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Image($r('app.media.startIcon'))
          .width(50)
          .height(50)
          .objectFit(ImageFit.Contain)
          .margin({ top: 100 })

        Text('Private notes are protected')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 24, bottom: 8 })

        Text('Unlock to enable access')
          .fontSize(16)
          .fontColor('#999999')
          .margin({ bottom: 32 })

        Button('Unlock')
          .backgroundColor(Color.Transparent)
          .fontColor('#A67C52')
          .fontSize(18)
          .borderWidth(0)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }.width('100%').height('100%')
  }
}