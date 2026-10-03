import { Length, common } from '@ohos.arkui';

// MARK: - Color Extension for Hex Initialization
function colorFromHex(hex: number): number {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return (0xFF << 24) | (r << 16) | (g << 8) | b;
}

// MARK: - AppTokens
class AppTokens {
  static Colors = {
    primary: colorFromHex(0x38BDF8),
    secondary: colorFromHex(0xA78BFA),
    tertiary: colorFromHex(0x7DD3FC),
    background: colorFromHex(0xF1F5F9),
    surface: colorFromHex(0xFFFFFF),
    surfaceVariant: colorFromHex(0xE2E8F0),
    outline: colorFromHex(0xCBD5E1),
    success: colorFromHex(0x22C55E),
    warning: colorFromHex(0xF59E0B),
    error: colorFromHex(0xEF4444),
    onPrimary: colorFromHex(0xFFFFFF),
    onSecondary: colorFromHex(0x1E1E1E),
    onTertiary: colorFromHex(0x1E1E1E),
    onBackground: colorFromHex(0x1E1E1E),
    onSurface: colorFromHex(0x1E1E1E),
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

// Helper to convert opacity to ARGB color
function withOpacity(color: number, opacity: number): number {
  const alpha = Math.round(opacity * 255);
  return (alpha << 24) | (color & 0x00FFFFFF);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State scrollOffset: number = 0;

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Text("Glass Doc Reader")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ top: 20, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // Main content area (Box)
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [withOpacity(AppTokens.Colors.surfaceVariant, 0.8), 0],
              [AppTokens.Colors.background, 0.5],
              [withOpacity(AppTokens.Colors.surfaceVariant, 0.8), 1],
            ],
          })

        // Surface
        Column() {
          Text("Document Reader")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.md })

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm })
          })

          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(withOpacity(AppTokens.Colors.surface, 0.7))
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: withOpacity(0x000000, AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy,
        })
        .offset({ y: this.scrollOffset / 5 })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              // Optional: Reset or handle start
            })
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffset += event.offset.y;
            })
        )
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}