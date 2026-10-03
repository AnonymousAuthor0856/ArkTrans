class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF60A5FA',
    background: '#FFE6F0FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.primary)
          Text('<')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .margin({ left: AppTokens.Spacing.lg })

        Blank()

        Text('Sleep Cycle')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Stack() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.secondary)
          Text('?')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .margin({ right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      Column({ space: AppTokens.Spacing.xl }) {
        Blank()

        Stack() {
          Circle({ width: 160, height: 160 })
            .fill(AppTokens.Colors.surface)
            .border({ width: 2, color: AppTokens.Colors.outline })
          Text('😴')
            .fontSize(48)
        }

        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        Row() {
          Button('Sign In')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('80%')
            .height(52)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}