@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          Text('Edit')
            .fontColor('#A68B5B')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)

          Blank()

          Button() {
            Text('×')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#9E9E9E')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 40 })

        Text('Select a Category')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 30 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: 20 })

        // General Category Chip
        Row() {
          Text('General')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          
          Blank()

          Circle()
            .width(16)
            .height(16)
            .borderWidth(2)
            .borderColor('#C4A47D')
            .fill(Color.Transparent)
        }
        .width(200)
        .height(60)
        .borderRadius(20)
        .linearGradient({
          angle: 90,
          colors: [['#FDFBF7', 0], ['#E3D5C1', 1]]
        })
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
        .margin({ left: 20 })

        Blank()

        // All notes Button
        Button() {
          Text('All notes')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width(180)
        .height(50)
        .borderRadius(25)
        .linearGradient({
          angle: 90,
          colors: [['#FFFFFF', 0], ['#EAEAEA', 1]]
        })
        .border({ width: 4, color: '#8C8C8C' })
        .shadow({ radius: 12, color: '#4D000000', offsetY: 6 })
        .margin({ bottom: 40 })
        
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}