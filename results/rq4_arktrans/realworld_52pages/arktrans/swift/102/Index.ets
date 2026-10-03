@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('Cancel')
            .fontColor('#A68B5B')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 20, top: 40 })

          Blank()

          Text('OK')
            .fontColor('#A68B5B')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .padding({ right: 20, top: 40 })
        }.width('100%')

        Text('Create New Category')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 20, bottom: 20 })
          .textAlign(TextAlign.Start)
          .width('100%')
          .padding({ left: 20 })

        Row() {
          TextInput({ placeholder: 'Name your category...' })
            .placeholderColor('#999999')
            .backgroundColor('#D1D1D6')
            .borderRadius(20)
            .height(50)
            .layoutWeight(1)
            .margin({ left: 20, right: 10 })
            .borderWidth(0)
            .padding({ left: 15 })

          Image($r('app.media.startIcon'))
            .width(40)
            .height(40)
            .margin({ right: 20 })
        }.width('100%').margin({ top: 10 })

        Blank()
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}