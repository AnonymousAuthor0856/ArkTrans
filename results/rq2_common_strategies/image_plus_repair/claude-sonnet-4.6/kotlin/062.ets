@Entry
@Component
struct ThermoCurveApp {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Thermostat icon (text-based)
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

        // Sun icon button
        Text('☀')
          .fontSize(24)
          .fontColor('#06B6D4')
          .margin({ right: 12 })
          .onClick(() => {
            this.targetTemp++
          })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#E0F2FE')
      .alignItems(VerticalAlign.Center)

      // Main content
      Column() {
        // Target Temperature label
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ top: 26, bottom: 16 })

        // Temperature display
        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B82F6')
          .margin({ bottom: 26 })

        // +/- buttons
        Row() {
          Button('–')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#3B82F6')
            .width(120)
            .height(48)
            .borderRadius(24)
            .margin({ right: 12 })
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#3B82F6')
            .width(120)
            .height(48)
            .borderRadius(24)
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
          .color('#CBD5E180')
          .strokeWidth(1)
          .margin({ bottom: 26 })

        // Mode label
        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ bottom: 18 })

        // Mode buttons
        Row() {
          // Cool button
          Column() {
            Text('❄')
              .fontSize(32)
              .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
            Text('Cool')
              .fontSize(14)
              .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
              .margin({ top: 4 })
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E0F2FE')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ right: 18 })
          .onClick(() => {
            this.mode = 'Cool'
          })

          // Heat button
          Column() {
            Text('☀')
              .fontSize(32)
              .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
            Text('Heat')
              .fontSize(14)
              .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
              .margin({ top: 4 })
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E0F2FE')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.mode = 'Heat'
          })
        }
        .margin({ bottom: 26 })

        // Current mode text
        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor('#1E293B')
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#1806B6D4', 0.0], ['#333B82F6', 1.0]]
      })
      .padding(18)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}