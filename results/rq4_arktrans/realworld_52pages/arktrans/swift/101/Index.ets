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

          Blank()

          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#A68B5B')
          
          Text('Save')
            .fontColor('#A68B5B')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16 })

        Text('Edit Category')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 16, bottom: 24 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: 16 })

        Row() {
          Text('Thoughts')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .textAlign(TextAlign.Start)
            .layoutWeight(1)
            .margin({ left: 24 })
        }
        .width('90%')
        .height(60)
        .backgroundColor('#CCEAF5')
        .borderRadius(20)
        .border({ width: 4, color: '#9DD9F2' })
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
        .margin({ top: 10 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}