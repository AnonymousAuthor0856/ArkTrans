// MARK: - AppTokens

interface FontStyle {
  size: number;
  weight: FontWeight;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#E6F0FF',
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
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
}

@Component
struct RootScreen {
  build() {
    Column() {
      // Top bar
      Row() {
        Button() {
          Stack() {
            Text('<')
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
          }
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
        }
        .margin({ left: AppTokens.Spacing.lg })
        .onClick(() => {})

        Blank()

        Text('Sleep Cycle')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Button() {
          Stack() {
            Text('?')
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
          }
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
        }
        .margin({ right: AppTokens.Spacing.lg })
        .onClick(() => {})
      }
      .height(56)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)

      // Main content area
      Column({ space: AppTokens.Spacing.xl }) {
        Blank()

        Stack() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(80)
        .border({ width: 2, color: AppTokens.Colors.outline })

        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        Button() {
          Text('Sign In')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(52)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .alignSelf(ItemAlign.Center)
        .onClick(() => {})

        Blank()
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
