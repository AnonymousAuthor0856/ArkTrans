const NAME = '086_SleepCycle_en'
const UI_TYPE = 'Health Auth'
const STYLE_THEME = 'Modern Blue'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Row() {
        Column() {
          Text('<')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width(24)
        .height(24)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)

        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Column() {
          Text('?')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width(24)
        .height(24)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(80)
        .border({ width: 2, color: AppTokens.Colors.outline })
        .justifyContent(FlexAlign.Center)

        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        Button('Sign In')
          .type(ButtonType.Normal)
          .width('80%')
          .height(52)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ top: AppTokens.Spacing.xl })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}