// AppTokens
class AppTokens {
  static readonly Colors = {
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
    onSurface: '#1E293B'
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.primary)
            Text('<')
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
        }
        .padding({ left: AppTokens.Spacing.lg })
        .backgroundColor(Color.Transparent)

        // Spacer
        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        // Spacer
        Blank()

        // Actions Icon (Right)
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.secondary)
            Text('?')
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
        }
        .padding({ right: AppTokens.Spacing.lg })
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Column() {
        // Spacer
        Blank()

        // Central Emoji Box
        Stack() {
          Circle({ width: 160, height: 160 })
            .fill(AppTokens.Colors.surface)
            .border({ width: 2, color: AppTokens.Colors.outline })
          
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .margin({ top: AppTokens.Spacing.sm })

        // Sign In Button
        Button('Sign In') {
          Text('Sign In')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.xl })

        // Spacer
        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.background, 1.0]]
      })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}