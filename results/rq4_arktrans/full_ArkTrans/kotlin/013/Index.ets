@Entry
@Component
struct Index {
  @State knobPosition: number = 300

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // Header
        Text('Retro Music Player')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 40, bottom: 20 })

        // Vinyl Record Container
        Stack({ alignContent: Alignment.Center }) {
          // Outer Beige Box with Border
          Row() {
            // Inner Yellow Ring
            Row() {
              // Center Red Dot
              Row()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor('#E94560')
            }
            .width(240)
            .height(240)
            .borderRadius(120)
            .borderWidth(8)
            .borderColor('#FFD166')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width(280)
          .height(280)
          .borderRadius(32)
          .borderWidth(4)
          .borderColor('#C4C4C4')
          .backgroundColor('#FFF8E7')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }

        // Track Info
        Text('Track: Summer Nights')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')
          .textAlign(TextAlign.Center)

        // Controls
        Row({ space: 24 }) {
          Button('Play')
            .width(120)
            .height(48)
            .backgroundColor('#E94560')
            .borderRadius(16)
            .fontColor('#FFFFFF')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Button('Pause')
            .width(120)
            .height(48)
            .backgroundColor('#FFD166')
            .borderRadius(16)
            .fontColor('#1F1F1F')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')

        // Knob Position Debug Text
        Text(`Knob X:${this.knobPosition} Y:${this.knobPosition}`)
          .fontSize(16)
          .fontColor('#06D6A0')
          .textAlign(TextAlign.Center)
          .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFCF2')
    }
    .width('100%')
    .height('100%')
  }
}