class AppTokens {
  static readonly Colors = {
    primary: '#FF3B82F6',
    secondary: '#FF06B6D4',
    tertiary: '#FF0EA5E9',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFCBD5E1',
    onPrimary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 18,
  }
  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26,
  }
}

@Component
struct ModeButton {
  @Prop label: string
  @Prop icon: string
  @Prop currentMode: string
  onSelect: (mode: string) => void = (mode: string) => {}

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
      Text(this.label)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    .borderRadius(50)
    .shadow({ radius: 5, color: '#1A000000', offsetY: 5 })
    .onClick(() => {
      this.onSelect(this.label)
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      Row() {
        Text('🌡')
          .fontSize(24)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('☀')
          .fontSize(24)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {
            this.targetTemp += 1
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Row({ space: AppTokens.Spacing.md }) {
          Button('–')
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
        }

        Column()
          .width('80%')
          .height(1)
          .backgroundColor('#80CBD5E1')

        Text('Mode')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({ label: 'Cool', icon: '❄', currentMode: this.mode, onSelect: (m: string) => { this.mode = m } })
          ModeButton({ label: 'Heat', icon: '☀', currentMode: this.mode, onSelect: (m: string) => { this.mode = m } })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}