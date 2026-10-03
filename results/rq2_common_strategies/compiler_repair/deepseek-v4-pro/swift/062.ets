@Entry
@Component
struct ThermoCurveApp {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Row({ space: 0 }) {
        Text('🌡️')
          .fontSize(24)
          .foregroundColor('#3B82F6')
          .padding({ left: 12 })
        Blank()
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#1E293B')
        Blank()
        Button() {
          Text('☀️')
            .fontSize(24)
            .foregroundColor('#06B6D4')
        }
        .padding({ right: 12 })
        .onClick(() => {
          this.targetTemp += 1
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E0F2FE')
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column({ space: 26 }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#1E293B')
          .width('100%')
          .textAlign(TextAlign.Center)

        Text(this.targetTemp + '°C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#3B82F6')
          .width('100%')
          .textAlign(TextAlign.Center)

        Row({ space: 12 }) {
          Button() {
            Text('–')
              .fontSize(20)
              .foregroundColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width(60)
              .height(60)
          }
          .width(60)
          .height(60)
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1
            }
          })

          Button() {
            Text('+')
              .fontSize(20)
              .foregroundColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width(60)
              .height(60)
          }
          .width(60)
          .height(60)
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()
          .width('80%')
          .height(1)
          .color('#CBD5E1')
          .opacity(0.5)

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#1E293B')
          .width('100%')
          .textAlign(TextAlign.Center)

        Row({ space: 18 }) {
          this.buildModeButton('Cool', '💨')
          this.buildModeButton('Heat', '☀️')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Text('Current Mode: ' + this.mode)
          .fontSize(12)
          .foregroundColor('#1E293B')
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .padding(18)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildModeButton(label: string, icon: string) {
    Button() {
      Column({ space: 0 }) {
        Text(icon)
          .fontSize(32)
          .foregroundColor(this.mode === label ? '#FFFFFF' : '#1E293B')
          .textAlign(TextAlign.Center)
          .width(100)
          .height(60)
        Text(label)
          .fontSize(12)
          .foregroundColor(this.mode === label ? '#FFFFFF' : '#1E293B')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width(100)
      .height(100)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(this.mode === label ? '#3B82F6' : '#E0F2FE')
    .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 5 })
    .onClick(() => {
      this.mode = label
    })
  }
}