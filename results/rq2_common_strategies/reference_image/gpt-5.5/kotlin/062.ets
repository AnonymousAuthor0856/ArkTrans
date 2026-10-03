const NAME: string = '101_ThermoCurve_en'
const UI_TYPE: string = 'SmartHome Form'
const STYLE_THEME: string = 'Cold Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const PRIMARY: string = '#3B82F6'
const SECONDARY: string = '#06B6D4'
const BACKGROUND: string = '#F0F9FF'
const SURFACE_VARIANT: string = '#E0F2FE'
const OUTLINE: string = '#CBD5E1'
const ON_PRIMARY: string = '#FFFFFF'
const ON_SURFACE: string = '#1E293B'
const GRADIENT_TOP: string = '#D2F0FC'
const GRADIENT_BOTTOM: string = '#C6DDFC'

@Component
struct ThermometerIcon {
  build() {
    Stack() {
      Column() {
      }
      .width(10)
      .height(32)
      .borderRadius(5)
      .backgroundColor(PRIMARY)
      .position({ x: 19, y: 5 })

      Column() {
      }
      .width(4)
      .height(18)
      .borderRadius(2)
      .backgroundColor(SURFACE_VARIANT)
      .position({ x: 22, y: 9 })

      Circle()
        .width(22)
        .height(22)
        .fill(PRIMARY)
        .position({ x: 13, y: 29 })
    }
    .width(48)
    .height(52)
  }
}

@Component
struct SunIcon {
  @Prop color: string = SECONDARY
  @Prop size: number = 30

  build() {
    Text('☀')
      .fontSize(this.size)
      .fontColor(this.color)
      .fontWeight(FontWeight.Bold)
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
  }
}

@Component
struct ModeButton {
  @Prop label: string = ''
  @Prop icon: string = ''
  @Prop current: string = ''
  onSelect: (value: string) => void = () => {
  }

  private isSelected(): boolean {
    return this.label === this.current
  }

  build() {
    Column() {
      Text(this.icon)
        .fontSize(34)
        .fontColor(this.isSelected() ? ON_PRIMARY : ON_SURFACE)
        .fontWeight(FontWeight.Bold)
        .height(42)
        .textAlign(TextAlign.Center)

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected() ? ON_PRIMARY : ON_SURFACE)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(50)
    .backgroundColor(this.isSelected() ? PRIMARY : SURFACE_VARIANT)
    .border({
      width: this.isSelected() ? 0 : 0.5,
      color: OUTLINE
    })
    .shadow({
      radius: 5,
      color: '#22000000',
      offsetX: 0,
      offsetY: 2
    })
    .onClick(() => {
      this.onSelect(this.label)
    })
  }
}

@Entry
@Component
struct Index {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      Row() {
        Row() {
          ThermometerIcon()
        }
        .width(64)
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text('ThermoCurve')
          .layoutWeight(1)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .textAlign(TextAlign.Center)

        Row() {
          SunIcon({ color: SECONDARY, size: 32 })
        }
        .width(64)
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.targetTemp++
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor(SURFACE_VARIANT)
      .alignItems(VerticalAlign.Center)

      Column({ space: 26 }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)

        Row({ space: 12 }) {
          Column() {
            Text('–')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_PRIMARY)
          }
          .width(62)
          .height(40)
          .borderRadius(20)
          .backgroundColor(PRIMARY)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp--
            }
          })

          Column() {
            Text('+')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_PRIMARY)
          }
          .width(62)
          .height(40)
          .borderRadius(20)
          .backgroundColor(PRIMARY)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp++
            }
          })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color(OUTLINE)
          .opacity(0.5)

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)

        Row({ space: 18 }) {
          ModeButton({
            label: 'Cool',
            icon: '✣',
            current: this.mode,
            onSelect: (value: string) => {
              this.mode = value
            }
          })

          ModeButton({
            label: 'Heat',
            icon: '☀',
            current: this.mode,
            onSelect: (value: string) => {
              this.mode = value
            }
          })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(ON_SURFACE)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 18,
        right: 18,
        top: 18,
        bottom: 18
      })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [GRADIENT_TOP, 0.0],
          [GRADIENT_BOTTOM, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}