import { Color, FontSize } from '@kit.ArkUI';

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to ArkTS structs/classes
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
    display: { size: 28 as FontSize, weight: 'Bold' },
    title: { size: 18 as FontSize, weight: 'Medium' },
    body: { size: 14 as FontSize, weight: 'Regular' },
    label: { size: 12 as FontSize, weight: 'Medium' }
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
  @State spending: number = 500;
  readonly goal: number = 1000;

  build() {
    Column() {
      // Top Bar equivalent (CenterAlignedTopAppBar)
      Row() {
        Text('Bill Calendar')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area (Column)
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card
          Column({ space: 0 }) {
            Text('Current Spending')
              .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
              .fontColor(AppTokens.Colors.primary)
              .alignSelf(ItemAlign.Start)

            Blank()

            Text(`$${this.spending} / $${this.goal}`)
              .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            Blank()

            // LinearProgressIndicator equivalent
            Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)
          }
          .width('100%')
          .height(160)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(Color.White.withAlpha(0.9))
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: Color.Black.withAlpha(AppTokens.ElevationMapping.level2.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          Text('Adjust Spending')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Center)

          // Slider
          Slider({ value: this.spending, min: 0, max: 2000 })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .trackHeight(8)
            .showTips(false)

          // Button
          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0;
            })
        }
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .backgroundColor(
        new LinearGradient({
          angle: 90,
          colors: [
            [AppTokens.Colors.secondary, 0.3],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary, 0.2]
          ]
        })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}