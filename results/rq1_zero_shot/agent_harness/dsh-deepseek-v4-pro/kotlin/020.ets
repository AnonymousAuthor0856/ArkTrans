const Colors = {
  primary: '#FF7A00',
  secondary: '#FFC300',
  tertiary: '#FFF3C0',
  background: '#FFF8E7',
  surface: '#FFFFFF',
  surfaceVariant: '#FFEBC8',
  outline: '#BCA789',
  success: '#28A745',
  warning: '#FFC107',
  error: '#DC3545',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
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
  @State knobX: number = 0
  @State knobY: number = 0
  @State powerOn: boolean = false

  build() {
    Column() {
      Row() {
        Text('Retro Remote Control')
          .fontSize(28)
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
          Circle().width(400).height(400).fill(Colors.secondary).opacity(0.2)
          Circle().width(48).height(48).fill(Colors.primary).position({ x: this.knobX, y: this.knobY })
        }
        .width(280)
        .height(280)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(24)
        .shadow({ radius: 4, color: '#14000000', offsetY: 2 })
        .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
          this.knobX = event.offsetX
          this.knobY = event.offsetY
        }))

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? Colors.success : Colors.error)

        Row() {
          Button(this.powerOn ? 'Off' : 'On', { type: ButtonType.Circle })
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .width(80)
            .height(80)
            .onClick(() => { this.powerOn = !this.powerOn })

          Button('Reset', { type: ButtonType.Circle })
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(18)
            .width(80)
            .height(80)
            .onClick(() => { this.knobX = 0; this.knobY = 0 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Progress({ value: Math.round(((this.knobX + this.knobY) % 400 / 400) * 100), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
