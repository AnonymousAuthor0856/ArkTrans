const Colors = {
  primary: '#3B82F6',
  secondary: '#06B6D4',
  tertiary: '#0EA5E9',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#CBD5E1',
  onPrimary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B',
}

const Spacing = {
  sm: 8,
  md: 12,
  lg: 18,
  xl: 26,
}

@Component
struct ModeButton {
  @Prop label: string = ''
  @Prop icon: string = ''
  @Prop current: string = ''
  onSelect: (label: string) => void = () => {}

  build() {
    Button() {
      Column({ space: Spacing.sm }) {
        Text(this.icon)
          .fontSize(32)
          .fontColor(this.label === this.current ? Colors.onPrimary : Colors.onSurface)
        Text(this.label)
          .fontSize(14)
          .fontColor(this.label === this.current ? Colors.onPrimary : Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .type(ButtonType.Normal)
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(this.label === this.current ? Colors.primary : Colors.surfaceVariant)
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
        Text('🌡')
          .fontSize(24)
          .fontColor(Colors.primary)
          .padding({ left: 12 })
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('☀')
          .fontSize(24)
          .fontColor(Colors.secondary)
          .padding({ right: 12 })
          .onClick(() => {
            this.targetTemp++
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      Column({ space: Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Text(this.targetTemp.toString() + '°C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
        Row({ space: Spacing.md }) {
          Button('–')
            .fontSize(20)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--
              }
            })
          Button('+')
            .fontSize(20)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++
              }
            })
        }
        .alignItems(VerticalAlign.Center)

        Divider()
          .color(Colors.outline)
          .strokeWidth(1)
          .width('80%')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)

        Row({ space: Spacing.lg }) {
          ModeButton({ label: 'Cool', icon: '🌀', current: this.mode, onSelect: (s: string) => { this.mode = s } })
          ModeButton({ label: 'Heat', icon: '☀', current: this.mode, onSelect: (s: string) => { this.mode = s } })
        }

        Text('Current Mode: ' + this.mode)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['rgba(6,182,212,0.15)', 0], ['rgba(59,130,246,0.2)', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
