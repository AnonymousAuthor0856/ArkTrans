@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }
          Blank().width(8)
          Text('About').fontWeight(FontWeight.Bold).fontSize(22).fontColor('#000000')
        }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 12, bottom: 12 })

        Blank().height(40)

        Column() {
          Image($r('app.media.startIcon')).width(64).height(64).objectFit(ImageFit.Contain)
        }.backgroundColor('#F8C3D5').borderRadius(16).shadow({ radius: 4, color: '#1A000000' }).width(64).height(64).justifyContent(FlexAlign.Center)

        Blank().height(12)

        Text('Audio Notes').fontWeight(FontWeight.Bold).fontSize(14).fontColor('#000000')

        Blank().height(4)

        Text('v0.1.5.2(02052023)').fontSize(12).fontColor('#757575')

        Blank().height(24)

        Divider().color('#E0E0E0').strokeWidth(1)

        Blank().height(24)

        Column() {
          Column({ space: 0 }) {
            Text('Attributions & Licence').fontWeight(FontWeight.Bold).fontSize(16).fontColor('#000000')
            Blank().height(8)
            Text('Licenced under Apache Licence, Version 2.0').fontSize(12).fontColor('#757575')
          }.padding(16)
        }.backgroundColor('#F8C3D5').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')

        Blank().height(32)
      }.alignItems(HorizontalAlign.Center).padding({ left: 24, right: 24 }).width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFF0F5')
  }
}