@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Image($r('app.media.startIcon'))
          .width(50)
          .height(50)
          .objectFit(ImageFit.Contain)
          .fillColor('#9CA3AF')
          .margin({ bottom: 16 })

        Text('No Results')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 8 })

        Text('Check the spelling, try a new search or choose another category.')
          .fontSize(16)
          .fontColor('#9CA3AF')
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }.width('100%').height('100%')
  }
}