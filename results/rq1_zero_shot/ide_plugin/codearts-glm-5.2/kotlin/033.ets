const NAME = '034BillCalendaren'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Gradient Flow'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  }
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Column() {
          Text('Current Spending')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)

          Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.sm })

          Progress({ value: Math.min(this.spending / this.goal, 1) * 100, total: 100, type: ProgressType.Linear })
            .style({ strokeWidth: 8 })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .margin({ top: AppTokens.Spacing.sm })
        }
        .width('100%')
        .height(160)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })

        Text('Adjust Spending')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1,
          style: SliderStyle.OutSet,
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.spending = value
          })

        Button('Reset')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .onClick(() => {
            this.spending = 0
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0.0], [AppTokens.Colors.background, 0.5], ['#3306B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}