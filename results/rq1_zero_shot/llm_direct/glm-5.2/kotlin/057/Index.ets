// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF60A5FA',
    background: '#FFF8FAFC',
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
    onSurface: '#FF1E293B'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
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

// Entry file: e.g., pages/Index.ets
import { AppTokens } from './AppTokens';

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Row() {
          Text('<')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.primary)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Action Icon
        Row() {
          Text('?')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.secondary)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Content Area
      Column() {
        // Profile Circle
        Column() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 2, color: AppTokens.Colors.outline })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Welcome Text
        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .margin({ top: AppTokens.Spacing.sm })

        // Sign In Button
        Button('Sign In') {
          Text('Sign In')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('80%')
        .height(52)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.xl })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.primary, 0.1]
        ]
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}