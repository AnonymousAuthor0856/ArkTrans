import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    displaySize: 28,
    headlineSize: 20,
    titleSize: 16,
    bodySize: 14,
    labelSize: 12,
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  },
};

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          Stack() {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(24)
              .height(24)
            Text('<')
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .padding({ left: AppTokens.Spacing.lg })
        .width(56)
        .height(56)

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        // Actions Icon (Right)
        Button() {
          Stack() {
            Circle()
              .fill(AppTokens.Colors.secondary)
              .width(24)
              .height(24)
            Text('?')
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .padding({ right: AppTokens.Spacing.lg })
        .width(56)
        .height(56)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column({ space: AppTokens.Spacing.xl }) {
        Blank()

        // Central Emoji Box
        Stack() {
          Circle()
            .fill(AppTokens.Colors.surface)
            .width(160)
            .height(160)
            .border({
              width: 2,
              color: AppTokens.Colors.outline,
              style: BorderStyle.Solid,
            })
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        // Sign In Button
        Button('Sign In')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.background, 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}