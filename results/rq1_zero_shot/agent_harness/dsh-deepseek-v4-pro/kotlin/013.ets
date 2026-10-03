const Colors = {
  primary: '#EF476F',
  secondary: '#FFD166',
  tertiary: '#06D6A0',
  background: '#FFFCF2',
  surface: '#FFF8E1',
  surfaceVariant: '#FCE7E7',
  outline: '#BDBDBD',
  success: '#06D6A0',
  warning: '#FFA600',
  error: '#D62828',
  onPrimary: '#FFFFFF',
  onSecondary: '#1F1F1F',
  onTertiary: '#1F1F1F',
  onBackground: '#1F1F1F',
  onSurface: '#1F1F1F'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State knobX: number = 300
  @State knobY: number = 300

  build() {
    Column() {
      Row() {
        Text('Retro Music Player')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.background)

      Column({ space: Spacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle().width(240).height(240).stroke(Colors.secondary).strokeWidth(12)
          Circle().width(40).height(40).fill(Colors.primary).position({ x: this.knobX, y: this.knobY })
        }
        .width(280)
        .height(280)
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .border({ width: 3, color: Colors.outline })
        .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
          this.knobX = event.offsetX
          this.knobY = event.offsetY
        }))

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Row() {
          Button('Play', { type: ButtonType.Normal })
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .width(120)
            .height(48)
            .borderRadius(12)
            .onClick(() => {})

          Button('Pause', { type: ButtonType.Normal })
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(18)
            .width(120)
            .height(48)
            .borderRadius(12)
            .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Text('Knob X:' + Math.floor(this.knobX) + ' Y:' + Math.floor(this.knobY))
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.tertiary)

        Blank().height(Spacing.xxl)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
