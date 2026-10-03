@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Text('Chambéry')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 60, left: 24 })

        Column() {
          Text('NOW')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
            .margin({ top: 24, bottom: 16 })

          Text('HOURLY')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
            .margin({ bottom: 16 })

          Text('THIS WEEK')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ left: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F2F2F7')
    }.width('100%').height('100%')
  }
}