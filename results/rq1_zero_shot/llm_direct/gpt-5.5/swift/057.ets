class TypographyStyle {
  size: number
  weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#38BDF8'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#E6F0FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#1E293B'
}

class AppTypographyTokens {
  static readonly display: TypographyStyle = new TypographyStyle(28, FontWeight.Bold)
  static readonly headline: TypographyStyle = new TypographyStyle(20, FontWeight.SemiBold)
  static readonly title: TypographyStyle = new TypographyStyle(16, FontWeight.Medium)
  static readonly body: TypographyStyle = new TypographyStyle(14, FontWeight.Regular)
  static readonly label: TypographyStyle = new TypographyStyle(12, FontWeight.Medium)
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppTokens {
  static readonly Colors: typeof AppColors = AppColors
  static readonly TypographyTokens: typeof AppTypographyTokens = AppTypographyTokens
  static readonly Shapes: typeof AppShapes = AppShapes
  static readonly Spacing: typeof AppSpacing = AppSpacing
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Stack() {
        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Row() {
          Stack() {
            Text('<')
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.lg })
          .onClick(() => {
          })

          Blank()

          Stack() {
            Text('?')
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ right: AppTokens.Spacing.lg })
          .onClick(() => {
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      Column({ space: AppTokens.Spacing.xl }) {
        Stack() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(AppTokens.Colors.surface)
        .border({
          width: 2,
          color: AppTokens.Colors.outline
        })

        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        Stack() {
          Text('Sign In')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('80%')
        .height(52)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.primary)
        .onClick(() => {
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}