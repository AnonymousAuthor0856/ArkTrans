@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('Cancel')
            .fontColor('#A68257')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})

          Blank()

          Text('OK')
            .fontColor('#A68257')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 40, bottom: 10 })

        TextInput({ placeholder: 'Title your note...' })
          .placeholderColor('#C7C7CC')
          .placeholderFont({ size: 24, weight: FontWeight.Bold })
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .height(50)
          .margin({ left: 20, right: 20 })

        Divider()
          .color('#E5E5EA')
          .margin({ left: 20, right: 20, top: 10, bottom: 0 })

        Blank()

        Row() {
          Row() {
            Circle()
              .width(10)
              .height(10)
              .fill('#34B7F1')
            
            Text('Thoughts')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 8 })
          }

          Blank()

          Text('Change Category')
            .fontColor('#A68257')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 40 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}