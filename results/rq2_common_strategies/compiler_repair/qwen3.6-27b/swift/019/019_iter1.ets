import { Font, FontWeight } from '@kit.ArkUI';

// MARK: - AppTokens
// This struct holds all the design tokens (colors, typography, shapes, spacing, elevation)
// to ensure atomic correspondence with the Android Compose version.
class AppTokens {
  static Colors = {
    // Defined using hex values for precise color matching.
    primary: '#FF8B5CF6',
    secondary: '#FFD946EF',
    tertiary: '#FF3B82F6',
    background: '#FFF9F5FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1E9FE',
    outline: '#FFE3D7FE',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  static TypographyTokens = {
    // Font styles mapped to ArkTS's Font with specific size and weight.
    display: { size: 48, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 42, weight: FontWeight.Medium }
  };

  static Shapes = {
    // Rounded corner shapes defined by their corner radius.
    small: 8,
    medium: 14,
    large: 22
  };

  static Spacing = {
    // Standard spacing values, directly mapped from Dp to number.
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  // Shadow specification to mimic Compose's elevation system.
  static ElevationMapping = {
    level1: { elevation: 4, dy: 2, opacity: 0.14 },
    level2: { elevation: 8, dy: 6, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  // State variables to manage UI interactions, equivalent to Compose's `remember { mutableStateOf(...) }`.
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Surface equivalent for the sample subtitle line display.
      Text('Sample Subtitle Line')
        .fontSize(this.fontSize) // Dynamic font size from state
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(200) // Fixed height as in Compose
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large) // Apply rounded corners
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation, // Blur radius
          color: Color.Black.opacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy // Y-offset for the shadow
        })
        .margin({ top: AppTokens.Spacing.xl })

      Text(`Font Size: ${Math.round(this.fontSize)}sp`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })

      // Slider for font size adjustment.
      Slider({
        value: this.fontSize,
        min: 16,
        max: 48,
        step: 1
      })
        .blockColor(AppTokens.Colors.primary) // Sets the active track color.
        .trackColor(AppTokens.Colors.surfaceVariant) // Inactive track color
        .selectedColor(AppTokens.Colors.primary) // Thumb color
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })

      Text('Sync Progress')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.lg })

      // LinearProgressIndicator equivalent.
      Progress({
        value: this.syncProgress * 100, // ArkTS Progress uses percentage 0-100
        total: 100
      })
        .color(AppTokens.Colors.primary) // Color of the progress bar itself
        .backgroundColor(AppTokens.Colors.surfaceVariant) // Color of the track behind the progress bar
        .height(6) // Fixed height
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })

      // Row equivalent for the two buttons.
      Row() {
        // "Sync +" Button
        Button('Sync +')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary) // Button background color
          .borderRadius(AppTokens.Shapes.medium) // Apply rounded corners
          .height(48) // Fixed height
          .layoutWeight(1) // Distribute space equally
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0); // Increment progress, clamp at 1.0
          })

        // "Sync -" Button
        Button('Sync -')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary) // Button background color
          .borderRadius(AppTokens.Shapes.medium) // Apply rounded corners
          .height(48) // Fixed height
          .layoutWeight(1) // Distribute space equally
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0); // Decrement progress, clamp at 0.0
          })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.lg })
    }
    .padding(AppTokens.Spacing.lg) // Outer padding for the entire content VStack
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90, // Gradient from top to bottom
      colors: [
        [AppTokens.Colors.surfaceVariant, 0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.surface, 1]
      ]
    })
    .safeAreaPadding({ right: true, left: true, bottom: true }) // Handle safe areas appropriately
  }
}