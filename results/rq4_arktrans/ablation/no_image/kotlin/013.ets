interface KnobPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  @State knobPosition: KnobPosition = { x: 0, y: 0 }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // Box equivalent using Stack with Center alignment
        Stack({ alignContent: Alignment.Center }) {
          // Canvas placeholder - in real app would draw the knob
          Canvas().width('100%').height('100%')
        }
        .width(280)
        .height(280)
        .backgroundColor('#FFFFFF')
        .border({ width: 3, color: '#E0E0E0', radius: 16 })

        Text('Track: Summer Nights')
          .fontSize(16)
          .fontColor('#1F1F1F')
          .margin({ top: 16 })

        Row({ space: 0 }) {
          Button() {
            Text('Play')
              .fontSize(16)
              .fontColor('#FFFFFF')
          }
          .width(120)
          .height(48)
          .backgroundColor('#6750A4')
          .borderRadius(8)
          .onClick(() => {
            // Play action
          })

          Button() {
            Text('Pause')
              .fontSize(16)
              .fontColor('#FFFFFF')
          }
          .width(120)
          .height(48)
          .backgroundColor('#9C27B0')
          .borderRadius(8)
          .onClick(() => {
            // Pause action
          })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 16 })

        Text(`Knob X:${this.knobPosition.x} Y:${this.knobPosition.y}`)
          .fontSize(14)
          .fontColor('#06D6A0')
          .margin({ top: 8 })

        Blank().height(16)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFCF2')

      // Top App Bar equivalent
      Row() {
        Text('Retro Music Player')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFCF2')
    }
    .width('100%')
    .height('100%')
  }
}