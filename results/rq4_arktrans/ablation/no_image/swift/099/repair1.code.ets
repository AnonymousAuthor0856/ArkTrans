@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column() {
          Blank().height(48)
          Text('MATCHA RITUAL')
            .fontColor('#999999')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(4)
            .fontSize(14)
          Blank().height(8)
          Text('Ceremonial Grade')
            .fontColor('#000000')
            .fontWeight(FontWeight.Lighter)
            .fontSize(28)
        }

        Column() {
          // Canvas placeholder - using a simple colored rectangle to represent the visual area
          // In a real app, this would be a custom drawing component or Image
          Row() {
            Text('Canvas Area')
          }.width('100%').height(200).backgroundColor('#F0F0F0')

          Blank().height(40)

          Row() {
            Blank()
            Column() {
              Text('label')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
              Blank().height(4)
              Text('value')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
            }
            Blank()
            Column() {
              Text('label')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
              Blank().height(4)
              Text('value')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
            }
            Blank()
            Column() {
              Text('label')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
              Blank().height(4)
              Text('value')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
            }
            Blank()
          }.width('100%')
        }

        Column() {
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill('#F5F5F5')
              Text('number')
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
                .fontSize(12)
            }
            Blank().width(16)
            Text('text')
              .fontColor('#CCCCCC') // Approximation of Color(white: 0.3) on light bg
              .fontSize(14)
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(12)

          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill('#F5F5F5')
              Text('number')
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
                .fontSize(12)
            }
            Blank().width(16)
            Text('text')
              .fontColor('#CCCCCC')
              .fontSize(14)
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(32)

          Button() {
            Text('Button')
          }
          .width('100%')
          .type(ButtonType.Capsule)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')

          Blank().height(24)
        }.width('100%')

      }.width('100%').padding(24)
    }.width('100%').height('100%')
  }
}