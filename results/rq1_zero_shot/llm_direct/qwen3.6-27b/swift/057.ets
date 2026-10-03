import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// This struct defines a consistent set of design tokens for colors, typography, shapes, and spacing.
const AppTokens = {
  Colors: {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#E6F0FF', // Deeper blue background
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
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
};

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar (equivalent to Compose's CenterAlignedTopAppBar)
      Row() {
        // Navigation Icon (Left)
        Button() {
          // Action placeholder
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .width(24)
        .height(24)
        .onClick(() => {
          // Handle back action
        })
        .position({ x: 0, y: 0 })
        .zIndex(1)
        
        Circle()
          .fill(AppTokens.Colors.primary)
          .width(24)
          .height(24)
          .position({ x: 0, y: 0 })
        
        Text('<')
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .position({ x: 0, y: 0 })
          .textAlign(TextAlign.Center)
          
        Blank() // Spacer equivalent
        
        // Title
        Text('Sleep Cycle')
          .fontColor(AppTokens.Colors.onBackground)
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          
        Blank() // Spacer equivalent
        
        // Actions Icon (Right)
        Button() {
          // Action placeholder
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .width(24)
        .height(24)
        .onClick(() => {
          // Handle help action
        })
        .alignItems(HorizontalAlign.End)
        
        Circle()
          .fill(AppTokens.Colors.secondary)
          .width(24)
          .height(24)
          .margin({ right: AppTokens.Spacing.lg })
        
        Text('?')
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .margin({ right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Main Content Area
      Column() {
        Blank() // Pushes content to center vertically

        // Central Emoji Box
        Stack() {
          Circle()
            .fill(AppTokens.Colors.surface)
            .width(160)
            .height(160)
            .border({ width: 2, color: AppTokens.Colors.outline })
          
          Text('😴')
            .fontSize(48)
        }

        // Welcome Back Text
        Text('Welcome Back')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .margin({ top: AppTokens.Spacing.xl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .textAlign(TextAlign.Center)
          .margin({ top: AppTokens.Spacing.sm })

        // Sign In Button
        Button('Sign In')
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .height(52)
          .width('80%') // Matches fillMaxWidth(0.8f) logic relative to parent padding
          .margin({ top: AppTokens.Spacing.xl })
          .onClick(() => {
            // Handle sign in
          })

        Blank() // Pushes content to center vertically
      }
      .width('100%')
      .layoutWeight(1) // Fill remaining space
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}