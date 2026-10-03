// AppTokens - Design tokens for colors, typography, shapes, and spacing
interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItem;
  headline: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static readonly Colors: ColorsType = {
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
  }

  static readonly Typography: TypographyType = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapesType = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing: SpacingType = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
}

// RootScreen - Main screen component
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Row() {
          // Navigation Icon (Left)
          Button({ type: ButtonType.Circle }) {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 24, height: 24 })
                .fill(AppTokens.Colors.primary)
              Text('<')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(40)
            .height(40)
          }
          .padding({ left: AppTokens.Spacing.lg })

          // Spacer
          Blank()

          // Title
          Text('Sleep Cycle')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)

          // Spacer
          Blank()

          // Actions Icon (Right)
          Button({ type: ButtonType.Circle }) {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 24, height: 24 })
                .fill(AppTokens.Colors.secondary)
              Text('?')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSecondary)
            }
            .width(40)
            .height(40)
          }
          .padding({ right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)

        // Main Content Area
        Column() {
          // Spacer
          Blank()

          // Central Emoji Box
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 160, height: 160 })
              .fill(AppTokens.Colors.surface)
              .stroke(AppTokens.Colors.outline)
              .strokeWidth(2)
            Text('😴')
              .fontSize(48)
          }
          .width(160)
          .height(160)

          // Welcome Back Text
          Text('Welcome Back')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xl })

          // Description Text
          Text('Track your sleep patterns and improve rest quality.')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
            .margin({ top: AppTokens.Spacing.sm })

          // Sign In Button
          Button() {
            Text('Sign In')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
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
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}