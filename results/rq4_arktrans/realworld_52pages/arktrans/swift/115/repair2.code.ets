@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column({ space: 8 }) {
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#FFC107')
          }
          Blank()
        }.padding({ top: 40, left: 16, right: 16 })

        Blank()

        Text('The Awesome Movie')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .padding({ left: 16, right: 16 })

        Rect()
          .width('100%')
          .height(14)
          .borderRadius(4)
          .fill('#4D4D4D')
          .margin({ left: 16, right: 16 })

        Text('120 min')
          .fontSize(15)
          .fontColor('#9E9E9E')
          .padding({ left: 16, right: 16 })

        Rect()
          .width('100%')
          .height(14)
          .borderRadius(4)
          .fill('#4D4D4D')
          .margin({ left: 16, right: 16 })

        Row({ space: 8 }) {
          ForEach([
            { name: 'Action' },
            { name: 'Adventure' },
            { name: 'Sci-Fi' }
          ], (item: { name: string }) => {
            Row({ space: 8 }) {
              Text(item.name)
                .fontSize(15)
                .fontColor('#9E9E9E')
              Circle()
                .width(5)
                .height(5)
                .fill('#FFC107')
            }
          })
          Blank()
        }.padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [['#2C2F33', 0], ['#1A1B1E', 1]]
      })
    }.width('100%').height('100%')
  }
}