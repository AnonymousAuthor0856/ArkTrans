import { common } from '@kit.ArkUI';

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to ArkTS structs/classes

interface ColorToken {
  value: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ElevationSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  static TypographyTokens = {
    // Kotlin's displayLarge = 28.sp, FontWeight.Bold
    display: { size: 28, weight: FontWeight.Bold },
    // Kotlin's titleMedium = 18.sp, FontWeight.Medium
    title: { size: 18, weight: FontWeight.Medium },
    // Kotlin's bodyMedium = 14.sp, FontWeight.Normal
    body: { size: 14, weight: FontWeight.Normal },
    // Kotlin's labelMedium = 12.sp, FontWeight.Medium
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  // ShadowSpec mapping from Compose to ArkTS
  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  // Kotlin's mutableFloatStateOf(500f)
  @State spending: number = 500;
  readonly goal: number = 1000;

  build() {
    Column() {
      // Top Bar equivalent (CenterAlignedTopAppBar)
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area (Column)
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card - Moved to the top
          Column({ space: 0 }) {
            Text('Current Spending')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.primary)
              .alignSelf(ItemAlign.Start)

            Blank()

            Text(`$${this.spending} / $${this.goal}`)
              .fontSize(AppTokens.TypographyTokens.display.size)
              .fontWeight(AppTokens.TypographyTokens.display.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            Blank()

            // LinearProgressIndicator equivalent
            Row() {
              Row()
                .width(`${(this.spending / this.goal) * 100}%`)
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
          }
          .width('100%')
          .height(160)
          .padding(AppTokens.Spacing.lg)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: Color('#000000').withAlpha(AppTokens.ElevationMapping.level2.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Center)

          // Slider
          Slider({ value: this.spending, min: 0, max: 2000 })
            .width('100%')
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.secondary)

          // Button
          Button('Reset', { type: ButtonType.Capsule })
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .onClick(() => {
              this.spending = 0;
            })
        }
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}