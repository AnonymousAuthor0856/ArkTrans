const NAME = '101_ThermoCurve_en'
const UI_TYPE = 'SmartHome Form'
const STYLE_THEME = 'Cold Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 18,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26,
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
          .margin({ left: 12 })

        Text('ThermoCurve')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('☀')
          .fontSize(24)
          .onClick(() => {
            this.targetTemp++
          })
      }
      .width('100%')
      .height(56)
      .padding({ right: 12 })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('Target Temperature')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.sm })

        Row() {
          Button('–')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(20)
            .onClick(() => {
              if (this.targetTemp > 10) this.targetTemp--
            })

          Button('+')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(20)
            .margin({ left: AppTokens.Spacing.md })
            .onClick(() => {
              if (this.targetTemp < 35) this.targetTemp++
            })
        }
        .margin({ top: AppTokens.Spacing.md })
        .alignItems(VerticalAlign.Center)

        Column()
          .width('80%')
          .height(1)
          .backgroundColor('#80CBD5E1')
          .margin({ top: AppTokens.Spacing.xl })

        Text('Mode')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        Row() {
          Column() {
            Text('💨')
              .fontSize(32)
            Text('Cool')
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Cool' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.mode = 'Cool'
          })

          Column() {
            Text('☀')
              .fontSize(32)
            Text('Heat')
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          }
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Heat' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .margin({ left: AppTokens.Spacing.lg })
          .onClick(() => {
            this.mode = 'Heat'
          })
        }
        .margin({ top: AppTokens.Spacing.md })
        .alignItems(VerticalAlign.Center)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
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