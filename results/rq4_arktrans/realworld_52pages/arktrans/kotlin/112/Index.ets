@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Row({ space: 8 }) {
          Button() {
            Image($r('app.media.startIcon'))
          }
          Text('Settings').fontSize(22).fontWeight(FontWeight.Bold)
        }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 12, bottom: 12 })

        Blank().height(16)

        Column() {
          Column({ space: 8 }) {
            Text('Preferences').fontWeight(FontWeight.Medium)
            Text('Settings preferences will appear here').fontSize(12).fontColor('#757575')
          }.padding(16)
        }.backgroundColor('#F1F8E9').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')

        Blank().height(24)

        Divider().color('#E0E0E0')

        Blank().height(16)

        Row({ space: 16 }) {
          Image($r('app.media.startIcon')).width(24).height(24)
          Column({ space: 4 }) {
            Text('About').fontSize(14).fontWeight(FontWeight.Medium)
            Text('App version, Licence and more').fontSize(11).fontColor('#757575')
          }
        }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 12, bottom: 12 })

        Blank().height(32)
      }.padding({ left: 24, right: 24 }).width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFEBEE')
  }
}