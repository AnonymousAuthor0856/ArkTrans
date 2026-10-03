const NAME = '033TransferWizarden'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Warm Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 0,
    medium: 0,
    large: 0,
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
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4

  build() {
    Column() {
      Row() {
        Text('Transfer Wizard')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Stack() {
        Column()
          .width(520)
          .height(520)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(260)

        Column()
          .width(40)
          .height(40)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(20)
          .position({ x: 160, y: 280 })

        Column() {
          Text('Transfer Progress')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .style({ strokeWidth: 8 })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('80%')
            .margin({ top: AppTokens.Spacing.lg })

          Row() {
            Button('+')
              .type(ButtonType.Normal)
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1)
              })

            Button('-')
              .type(ButtonType.Normal)
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ left: AppTokens.Spacing.md })
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0)
              })
          }
          .margin({ top: AppTokens.Spacing.lg })
        }
        .alignItems(HorizontalAlign.Center)
        .position({ x: 0, y: 420 })
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .alignContent(Alignment.Center)
      .linearGradient({
        angle: 180,
        colors: [['#33FFC300', 0.0], [AppTokens.Colors.background, 0.5], ['#33FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}