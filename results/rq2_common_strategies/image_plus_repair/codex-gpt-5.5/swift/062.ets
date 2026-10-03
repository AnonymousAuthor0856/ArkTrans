const PRIMARY: string = '#3B82F6'
const SECONDARY: string = '#06B6D4'
const ON_SURFACE: string = '#1E293B'
const SURFACE_VARIANT: string = '#E0F2FE'
const OUTLINE: string = '#CBD5E1'

@Entry
@Component
struct ThermoCurve {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  @Builder
  modeSelector(label: string, icon: string) {
    Column({ space: 8 }) {
      Text(icon)
        .fontSize(38)
        .fontColor(this.mode === label ? '#FFFFFF' : ON_SURFACE)
        .fontWeight(FontWeight.Normal)
      Text(label)
        .fontSize(18)
        .fontColor(this.mode === label ? '#FFFFFF' : ON_SURFACE)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)
    .backgroundColor(this.mode === label ? PRIMARY : SURFACE_VARIANT)
    .shadow({
      radius: 5,
      color: '#1E293B1A',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.mode = label
    })
  }

  build() {
    Column() {
      Row() {
        Text('♨')
          .fontSize(31)
          .fontColor(PRIMARY)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 14 })

        Blank()
          .layoutWeight(1)

        Text('ThermoCurve')
          .fontSize(38)
          .fontColor(ON_SURFACE)
          .fontWeight(FontWeight.Bold)

        Blank()
          .layoutWeight(1)

        Text('☀')
          .fontSize(37)
          .fontColor(SECONDARY)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 15 })
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          })
      }
      .width('100%')
      .height(112)
      .backgroundColor(SURFACE_VARIANT)

      Column({ space: 0 }) {
        Text('Target Temperature')
          .fontSize(36)
          .fontColor(ON_SURFACE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 177 })

        Text(`${this.targetTemp}°C`)
          .fontSize(96)
          .fontColor(PRIMARY)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 48 })

        Row({ space: 24 }) {
          Button('−', { type: ButtonType.Normal })
            .fontSize(32)
            .fontColor('#FFFFFF')
            .width(120)
            .height(120)
            .borderRadius(16)
            .backgroundColor(PRIMARY)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })

          Button('+', { type: ButtonType.Normal })
            .fontSize(32)
            .fontColor('#FFFFFF')
            .width(120)
            .height(120)
            .borderRadius(16)
            .backgroundColor(PRIMARY)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
        }
        .margin({ top: 58 })

        Divider()
          .width('80%')
          .height(1)
          .color(OUTLINE)
          .margin({ top: 53 })

        Text('Mode')
          .fontSize(36)
          .fontColor(ON_SURFACE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 52 })

        Row({ space: 36 }) {
          this.modeSelector('Cool', '≋')
          this.modeSelector('Heat', '☀')
        }
        .margin({ top: 52 })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(24)
          .fontColor(ON_SURFACE)
          .margin({ top: 54 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [0x2606B6D4, 0.0],
          [0x333B82F6, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
