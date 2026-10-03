// MARK: - AppTokens
// This struct holds all the design tokens (colors, typography, shapes, spacing, elevation)
// to ensure atomic correspondence with the Android Compose version.

// MARK: - Color Helper for Hex Initialization
// Initializes a color string from a 0xRRGGBB hex integer.
// Assumes full opacity (alpha = 1.0) as per Kotlin's Color(0xFFRRGGBB) convention.
function toHex2(value: number): string {
  const s: string = value.toString(16);
  return s.length === 1 ? '0' + s : s;
}

function colorFromHex(hex: number): string {
  const red: number = (hex & 0xFF0000) >> 16;
  const green: number = (hex & 0x00FF00) >> 8;
  const blue: number = hex & 0x0000FF;
  return '#FF' + toHex2(red) + toHex2(green) + toHex2(blue);
}

// AppTokens.Colors
class Colors {
  // Defined using hex values for precise color matching.
  static readonly primary: string = colorFromHex(0xFF8B5CF6);
  static readonly secondary: string = colorFromHex(0xFFD946EF);
  static readonly tertiary: string = colorFromHex(0xFF3B82F6);
  static readonly background: string = colorFromHex(0xFFF9F5FF);
  static readonly surface: string = colorFromHex(0xFFFFFFFF);
  static readonly surfaceVariant: string = colorFromHex(0xFFF1E9FE);
  static readonly outline: string = colorFromHex(0xFFE3D7FE);
  static readonly success: string = colorFromHex(0xFF22C55E);
  static readonly warning: string = colorFromHex(0xFFFACC15);
  static readonly error: string = colorFromHex(0xFFEF4444);
  static readonly onPrimary: string = colorFromHex(0xFFFFFFFF);
  static readonly onSecondary: string = colorFromHex(0xFFFFFFFF);
  static readonly onTertiary: string = colorFromHex(0xFFFFFFFF);
  static readonly onBackground: string = colorFromHex(0xFF1E1E1E);
  static readonly onSurface: string = colorFromHex(0xFF1E1E1E);
}

// AppTokens.TypographyTokens
class TypographyTokens {
  // Font styles mapped to ArkUI font with specific size and weight.
  static readonly display: Font = { size: 48, weight: FontWeight.Bold };
  static readonly title: Font = { size: 18, weight: FontWeight.Medium };
  static readonly body: Font = { size: 14, weight: FontWeight.Regular }; // FontWeight.Normal maps to .regular
  static readonly label: Font = { size: 42, weight: FontWeight.Medium };
}

// AppTokens.Shapes
class Shapes {
  // Rounded corner shapes defined by their corner radius.
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 22;
}

// AppTokens.Spacing
class Spacing {
  // Standard spacing values, directly mapped from Dp to number (vp).
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// AppTokens.ShadowSpec
// Shadow specification to mimic Compose's elevation system.
class ShadowSpec {
  readonly elevation: number; // Corresponds to ArkUI's shadow radius (blur amount)
  readonly dy: number;        // Corresponds to ArkUI's shadow y-offset
  readonly opacity: number;   // Corresponds to ArkUI's shadow color alpha

  constructor(elevation: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// AppTokens.ElevationMapping
class ElevationMapping {
  // Shadow levels with specific properties.
  // Kotlin's 'elevation' is mapped to ArkUI's 'radius' (blur).
  // Kotlin's 'dy' is mapped to ArkUI's 'offsetY' offset.
  static readonly level1: ShadowSpec = new ShadowSpec(4, 2, 0.14);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 6, 0.18);
}

// MARK: - RootScreen View
// This view translates the main UI content from the Kotlin Composable.
@Component
struct RootScreen {
  // State variables to manage UI interactions, equivalent to Compose's `remember { mutableStateOf(...) }`.
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    // Navigation is used to provide a navigation bar (TopAppBar equivalent)
    // and allows for title customization.
    Navigation() {
      // Column acts as the main Column for vertical arrangement of UI elements.
      Column({ space: Spacing.xl }) {
        // Surface equivalent for the sample subtitle line display.
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize) // Dynamic font size from state
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large) // Apply rounded corners
          .shadow({
            radius: ElevationMapping.level2.elevation, // Blur radius
            color: 'rgba(0, 0, 0, ' + ElevationMapping.level2.opacity.toString() + ')',
            offsetX: 0,
            offsetY: ElevationMapping.level2.dy // Y-offset for the shadow
          })
          .width('100%') // Equivalent to Modifier.fillMaxWidth()
          .height(200) // Fixed height as in Compose

        Text('Font Size: ' + Math.trunc(this.fontSize) + 'sp')
          .font(TypographyTokens.body)
          .fontColor(Colors.onSurface)

        // Slider for font size adjustment.
        Slider({ value: this.fontSize, min: 16, max: 48, style: SliderStyle.OutSet })
          .onChange((value: number) => {
            this.fontSize = value;
          })
          .selectedColor(Colors.primary) // Sets the active track color.
          .width('100%')
        // Note: Direct customization of the Slider's thumb and inactive track color
        // is handled through ArkUI's built-in styles rather than UIViewRepresentable.

        Text('Sync Progress')
          .font(TypographyTokens.body)
          .fontColor(Colors.onSurface)

        // LinearProgressIndicator equivalent.
        Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
          .color(Colors.primary) // Color of the progress bar itself
          .backgroundColor(Colors.surfaceVariant) // Color of the track behind the progress bar
          .height(6) // Fixed height
          .width('100%') // Fill width

        // Row equivalent for the two buttons.
        Row({ space: Spacing.md }) {
          // "Sync +" Button
          Button('Sync +', { type: ButtonType.Normal })
            .fontSize(TypographyTokens.title.size)
            .fontWeight(TypographyTokens.title.weight)
            .fontColor(Colors.onPrimary)
            .height(48) // Fixed height
            .layoutWeight(1) // Fill button's content area
            .backgroundColor(Colors.primary) // Button background color
            .borderRadius(Shapes.medium) // Apply rounded corners
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0); // Increment progress, clamp at 1.0
            })

          // "Sync -" Button
          Button('Sync -', { type: ButtonType.Normal })
            .fontSize(TypographyTokens.title.size)
            .fontWeight(TypographyTokens.title.weight)
            .fontColor(Colors.onSecondary)
            .height(48) // Fixed height
            .layoutWeight(1) // Fill button's content area
            .backgroundColor(Colors.secondary) // Button background color
            .borderRadius(Shapes.medium) // Apply rounded corners
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress - 0.1, 0.0); // Decrement progress, clamp at 0.0
            })
        }
        .width('100%') // Ensure Row fills available width, distributing space to buttons
      }
      .padding(Spacing.lg) // Outer padding for the entire content Column
      .width('100%')
      .height('100%') // Make content Column fill remaining space
      .linearGradient({
        // Linear gradient background for the main content area.
        angle: 180, // Gradient from top (180) to bottom
        colors: [
          [Colors.surfaceVariant, 0.0],
          [Colors.background, 0.5],
          [Colors.surface, 1.0]
        ]
      })
    }
    // Navigation bar (TopAppBar) configuration.
    .title('Subtitle Editor') // Title text
    .titleMode(NavigationTitleMode.Mini) // Centers the title
    .mode(NavigationMode.Stack) // Prevents split view, ensuring full-screen behavior.
    // Note: toolbarBackground and statusBarHidden have no direct ArkUI equivalent;
    // the custom navigation bar background and status bar are left to system defaults.
  }
}

// MARK: - Main App Entry Point
// This is the entry point for the ArkUI application.
@Entry
@Component
struct SubtitleEditorApp {
  build() {
    Column() {
      RootScreen() // Presents the RootScreen as the initial view.
    }
    .width('100%')
    .height('100%')
  }
}
