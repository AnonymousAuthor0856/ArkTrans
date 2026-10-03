// import SwiftUI
// (No equivalent import is required: ArkUI components are global in an .ets page.)

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to ArkTS classes
interface ColorTokens {
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

interface FontToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: FontToken;
  title: FontToken;
  body: FontToken;
  label: FontToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

// ShadowSpec mapping from Compose to ArkUI
class ShadowSpec {
  elevation: number; // Compose's elevation, often contributes to blur/spread
  radius: number;    // Compose's radius (blur radius)
  dy: number;        // Compose's dy (y-offset)
  opacity: number;   // Compose's opacity

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

interface ElevationMappingTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF06B6D4',
    secondary: '#FF3B82F6',
    tertiary: '#FF8B5CF6',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  };

  static readonly Typography: TypographyTokens = {
    // Kotlin's displayLarge = 28.sp, FontWeight.Bold
    display: { size: 28, weight: FontWeight.Bold },
    // Kotlin's titleMedium = 18.sp, FontWeight.Medium
    title: { size: 18, weight: FontWeight.Medium },
    // Kotlin's bodyMedium = 14.sp, FontWeight.Normal
    body: { size: 14, weight: FontWeight.Regular },
    // Kotlin's labelMedium = 12.sp, FontWeight.Medium
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly ElevationMapping: ElevationMappingTokens = {
    level1: new ShadowSpec(2, 4, 2, 0.12),
    level2: new ShadowSpec(6, 8, 4, 0.18),
  };
}

// MARK: - Color Hex Extension
// ArkUI accepts "#AARRGGBB" strings directly, so Color(hex: 0xFF...) maps to a string literal.
// Example: Color(hex: 0xFF06B6D4) == '#FF06B6D4' (alpha FF, red 06, green B6, blue D4).

// MARK: - Custom LinearProgressViewStyle
// Maps LinearProgressViewStyle with separate tint and track colors to a Progress component.
@Component
struct LinearProgressView {
  @Prop tint: string = '#FF06B6D4';
  @Prop track: string = '#FFE0F2FE';
  @Prop value: number = 0;
  @Prop total: number = 1;

  build() {
    Progress({ value: this.value, total: this.total, type: ProgressType.Linear })
      .color(this.tint)
      .backgroundColor(this.track)
      .width('100%')
      .height(8)
  }
}

// MARK: - RootScreen View
@Entry
@Component
struct RootScreen {
  // Kotlin's mutableFloatStateOf(500f)
  @State spending: number = 500.0;
  goal: number = 1000.0;

  build() {
    Column() {
      // Mimic Scaffold's containerColor and topBar structure
      // Top Bar equivalent (CenterAlignedTopAppBar)
      Stack() {
        Text('Bill Calendar')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // extends behind status bar

      // Main content area (Column)
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card - 移到最顶部
          Column() {
            Text('Current Spending')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.primary)

            Blank() // Arrangement.SpaceBetween

            Text('$' + Math.floor(this.spending).toString() + ' / $' + Math.floor(this.goal).toString())
              .fontSize(AppTokens.Typography.display.size)
              .fontWeight(AppTokens.Typography.display.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank() // Arrangement.SpaceBetween

            // LinearProgressIndicator equivalent
            LinearProgressView({
              value: this.spending,
              total: this.goal,
              tint: AppTokens.Colors.primary,
              track: AppTokens.Colors.surfaceVariant,
            })
              .width('100%')
              .height(8)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.Spacing.lg)
          .width('100%')
          .height(160)
          .backgroundColor('#E6FFFFFF') // surface with 0.9 opacity
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: '#2E000000', // Color.black.opacity(level2.opacity)
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy,
          })

          Text('Adjust Spending')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          // Slider
          Slider({ value: this.spending, min: 0, max: 2000, style: SliderStyle.OutSet })
            .onChange((value: number) => {
              this.spending = value;
            })
            .selectedColor(AppTokens.Colors.primary) // activeTrackColor
            .blockColor(AppTokens.Colors.secondary) // thumbColor
            .trackColor(AppTokens.Colors.surfaceVariant) // inactiveTrackColor
            .width('100%')

          // Button
          Button('Reset')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onTertiary) // contentColor = onTertiary
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary) // containerColor = tertiary
            .borderRadius(AppTokens.Shapes.medium) // shape = medium
            .onClick(() => {
              this.spending = 0.0;
            })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .linearGradient({
        angle: 180, // top to bottom
        colors: [
          ['#4D3B82F6', 0],   // secondary with 0.3 opacity
          ['#FFF0F9FF', 0.5], // background
          ['#3306B6D4', 1],   // primary with 0.2 opacity
        ],
      })
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // Scaffold containerColor
    // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App Entry Point
// SwiftUI's @main + App + WindowGroup maps to the @Entry annotation on RootScreen.
// .statusBarHidden(true) is handled at the window/ability level in HarmonyOS.
