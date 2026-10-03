const NAME = '105_ChargingProgress_en'
const UI_TYPE = 'SmartHome Dashboard'
const STYLE_THEME = 'Retro Flat'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B',
  }

  static TypographyTokens = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45

  build() {
    Column() {
      Row() {
        Text('🚗')
          .fontSize(24)
          .margin({ left: 8 })

        Text('Charging Progress')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.accent)
      }
      .width('100%')
      .height(56)
      .padding({ right: 8 })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('🔋')
          .fontSize(72)
          .fontColor(AppTokens.Colors.primary)

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.sm })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .style({ strokeWidth: 14 })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surface)
          .width('80%')
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(7)
          .margin({ top: AppTokens.Spacing.lg })

        Button('Simulate Charge')
          .type(ButtonType.Normal)
          .borderRadius(22)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .margin({ top: AppTokens.Spacing.xl })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1) this.progress = 0
          })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(this.progress < 1 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.xl })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}