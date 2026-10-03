// MARK: - AppTokens
// This struct defines a consistent set of design tokens for colors, typography, shapes, and spacing,
// mirroring the AppTokens object in the Kotlin version for atomic correspondence.
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#2563EB';
    export const secondary: string = '#38BDF8';
    export const tertiary: string = '#60A5FA';
    // 加深背景蓝色
    export const background: string = '#E6F0FF'; // 更深的蓝色背景
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E2E8F0';
    export const outline: string = '#CBD5E1';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#0F172A';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#0F172A';
    export const onSurface: string = '#1E293B';
  }

  export interface FontSpec {
    size: number;
    weight: FontWeight;
  }

  export namespace TypographyTokens {
    // Using fixed size and weight to match TextStyle in Compose.
    export const display: FontSpec = { size: 28, weight: FontWeight.Bold };
    // semibold (600) approximated with Bold (700).
    export const headline: FontSpec = { size: 20, weight: FontWeight.Bold };
    export const title: FontSpec = { size: 16, weight: FontWeight.Medium };
    export const body: FontSpec = { size: 14, weight: FontWeight.Regular };
    export const label: FontSpec = { size: 12, weight: FontWeight.Medium };
  }

  export namespace Shapes {
    // Corner radii are represented as numbers.
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 16;
  }

  export namespace Spacing {
    // Spacing values are represented as numbers.
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }
}

// MARK: - RootScreen
// This view translates the RootScreen Composable from Kotlin to ArkTS.
// It uses onAreaChange to accurately calculate dynamic sizes like button width.
@Component
struct RootScreen {
  @State contentWidth: number = 0;

  private buttonWidth(): number {
    return Math.max(0, (this.contentWidth - 2 * AppTokens.Spacing.lg) * 0.8);
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar (equivalent to Compose's CenterAlignedTopAppBar)
      Row() {
        // Navigation Icon (Left)
        Button({ type: ButtonType.Circle }) {
          Text('<')
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
        }
        .backgroundColor(AppTokens.Colors.primary)
        .width(24)
        .height(24)
        .margin({ left: AppTokens.Spacing.lg })
        .onClick(() => {})

        Blank() // Pushes title to center and icons to edges

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank() // Pushes title to center and icons to edges

        // Actions Icon (Right)
        Button({ type: ButtonType.Circle }) {
          Text('?')
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
        }
        .backgroundColor(AppTokens.Colors.secondary)
        .width(24)
        .height(24)
        .margin({ right: AppTokens.Spacing.lg })
        .onClick(() => {})
      }
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      // End Top Bar

      // Main Content Area (equivalent to Scaffold content Column)
      Column({ space: AppTokens.Spacing.xl }) {
        Blank() // Pushes content to center vertically

        // Central Emoji Box
        Stack() {
          Circle()
            .fill(AppTokens.Colors.surface)
            .width(160)
            .height(160)
            .stroke(AppTokens.Colors.outline)
            .strokeWidth(2)
          Text('😴')
            .fontSize(48)
        }

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        // Sign In Button
        Button() {
          Text('Sign In')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width(this.buttonWidth())
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {})

        Blank() // Pushes content to center vertically
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.background, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea()
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.contentWidth = Number(newValue.width);
    })
  }
}

// MARK: - App Entry Point
// This is the main entry point for the ArkTS application.
// It sets up the RootScreen and applies global modifiers for full-screen display and status bar visibility.
@Entry
@Component
struct SleepCycleApp {
  build() {
    // Hide the status bar to achieve a full-screen experience.
    // In ArkTS this is configured at the window level (window.setWindowSystemBarProperties).
    // The '@Entry' build requires a single container root node, so RootScreen is wrapped in a Column.
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
