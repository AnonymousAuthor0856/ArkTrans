@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('🌡')
          .fontSize(24)
          .fontColor('#3B82F6')
          .margin({ left: 12 })
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button({ type: ButtonType.Circle }) {
          Text('☀')
            .fontSize(20)
            .fontColor('#06B6D4')
        }
        .width(40)
        .height(40)
        .backgroundColor('#E0F2FE')
        .margin({ right: 8 })
        .onClick(() => {
          this.targetTemp++
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E0F2FE')
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Target Temperature Label
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ top: 26, bottom: 8 })

        // Temperature Display
        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B82F6')
          .margin({ bottom: 26 })

        // Control Buttons
        Row() {
          Button('–')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#3B82F6')
            .width(80)
            .height(44)
            .borderRadius(22)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#3B82F6')
            .width(80)
            .height(44)
            .borderRadius(22)
            .margin({ left: 12 })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++
              }
            })
        }
        .margin({ bottom: 26 })

        // Divider
        Divider()
          .width('80%')
          .color('#CBD5E1')
          .opacity(0.5)
          .margin({ bottom: 26 })

        // Mode Label
        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ bottom: 18 })

        // Mode Buttons
        Row() {
          // Cool Button
          Column() {
            Text('💨')
              .fontSize(32)
              .margin({ bottom: 4 })
            Text('Cool')
              .fontSize(14)
              .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E0F2FE')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.mode = 'Cool'
          })

          // Heat Button
          Column() {
            Text('☀')
              .fontSize(32)
              .margin({ bottom: 4 })
            Text('Heat')
              .fontSize(14)
              .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E0F2FE')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ left: 18 })
          .onClick(() => {
            this.mode = 'Heat'
          })
        }
        .margin({ bottom: 26 })

        // Current Mode
        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor('#1E293B')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(18)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#1606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}