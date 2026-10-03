// Translation of 017.swift (SwiftUI) to ArkTS (ArkUI).
// SwiftUI/UIKit imports map to ArkUI's built-in declarative UI framework.

// MARK: - Color Extension for Hex Initialization
// Provides a convenient way to initialize ArkUI colors from hex values,
// mirroring the Android Color(0xFFRRGGBB) syntax.
function colorFromHex(hex: number, alpha: number = 1.0): string {
  // Use unsigned shifts to mirror Swift's UInt semantics; the leading 0xFF
  // alpha byte is ignored because opacity is supplied separately.
  const r = (hex >>> 16) & 0xFF;
  const g = (hex >>> 8) & 0xFF;
  const b = hex & 0xFF;
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// MARK: - AppTokens
// Centralized definitions for colors, typography, shapes, and spacing,
// mirroring the Kotlin AppTokens object for easy modification and consistency.
class Colors {
  static readonly primary: string = colorFromHex(0xFF00FF66);
  static readonly secondary: string = colorFromHex(0xFFCCCCCC);
  static readonly tertiary: string = colorFromHex(0xFF999999);
  static readonly background: string = colorFromHex(0xFF000000);
  static readonly surface: string = colorFromHex(0xFF0A0A0A);
  static readonly surfaceVariant: string = colorFromHex(0xFF141414);
  static readonly outline: string = colorFromHex(0xFF2A2A2A);
  static readonly success: string = colorFromHex(0xFF22C55E);
  static readonly warning: string = colorFromHex(0xFFF59E0B);
  static readonly error: string = colorFromHex(0xFFEF4444);
  static readonly onPrimary: string = colorFromHex(0xFF000000);
  static readonly onSecondary: string = colorFromHex(0xFFFFFFFF);
  static readonly onTertiary: string = colorFromHex(0xFFFFFFFF);
  static readonly onBackground: string = colorFromHex(0xFFE0E0E0);
  static readonly onSurface: string = colorFromHex(0xFFE0E0E0);
}

class TypographyTokens {
  // Mapping Kotlin's TextStyle to ArkUI font attributes.
  // fontSize (sp) maps directly to ArkUI's fp size.
  // FontWeight.Bold -> FontWeight.Bold, FontWeight.Medium -> FontWeight.Medium,
  // FontWeight.Normal -> FontWeight.Normal
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 13;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 11;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class Shapes {
  // RoundedCornerShape(X.dp) maps to number radius values.
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class Spacing {
  // Dp values map directly to number for consistent spacing.
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppTokens {
  static readonly Colors = Colors;
  static readonly TypographyTokens = TypographyTokens;
  static readonly Shapes = Shapes;
  static readonly Spacing = Spacing;
}
// ShadowSpec and ElevationMapping are defined in Kotlin but not used in the UI,
// so they are omitted here for brevity.

// MARK: - MixerSlider Component
// Reusable component for the individual audio mixer sliders.
@Component
struct MixerSlider {
  label: string = '';
  @Link value: number; // Use @Link to allow external modification of the slider value

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.floor(this.value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
      Slider({ value: this.value, min: 0, max: 1 })
        .width('100%') // Equivalent to Modifier.fillMaxWidth()
        // Slider colors (thumb, active/inactive track) are customized globally
        // using UIAppearance in the Swift App struct's init(); in ArkUI the
        // same colors are applied directly on each Slider to preserve behavior.
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.value = value;
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - RootScreen
// The main UI screen, equivalent to the Composable RootScreen in Kotlin.
@Entry
@Component
struct RootScreen {
  // @State variables to hold the mutable slider values, mirroring Kotlin's remember { mutableFloatStateOf(...) }
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    // Full-screen Column layered with a black background, equivalent to
    // ZStack + Color.background.ignoresSafeArea(.all).
    Column() {
      // Top Bar equivalent: Simulates CenterAlignedTopAppBar.
      // Material 3 CenterAlignedTopAppBar typically has a height of 64.dp.
      // The title text (26fp) is vertically centered within this fixed height.
      Column() {
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%') // Center aligned horizontally
      }
      .width('100%')
      .height(64) // Fixed height for the top bar
      .justifyContent(FlexAlign.Center) // Vertically center 26fp text in 64fp height
      .backgroundColor(AppTokens.Colors.background) // Ensure top bar background is black

      // Content area: Contains sliders, progress bar, and button.
      Column({ space: AppTokens.Spacing.lg }) { // Spacing between elements in this column.
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        // Spacer equivalent to Modifier.height(AppTokens.Spacing.lg)
        Blank().height(AppTokens.Spacing.lg)

        // LinearProgressIndicator equivalent
        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .color(AppTokens.Colors.primary) // Sets the active track color
          .width('100%') // Equivalent to Modifier.fillMaxWidth()
          .height(6) // Fixed height 6.dp

        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start) // Aligned to start

        // Master volume Slider
        Slider({ value: this.master, min: 0, max: 1 })
          .width('100%') // Equivalent to Modifier.fillMaxWidth()
          // Slider colors customized directly to mirror the global UIAppearance.
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.primary)
          .onChange((value: number) => {
            this.master = value;
          })

        // Apply Settings Button
        Button('Apply Settings')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%') // Text fills button width
          .height(48) // Fixed button height 48.dp
          .backgroundColor(AppTokens.Colors.primary) // Button background color
          .borderRadius(AppTokens.Shapes.medium) // Rounded corners (10.dp)
      }
      .padding(AppTokens.Spacing.lg) // Outer padding for the content column (16.dp on all sides)
      .width('100%')
      .layoutWeight(1) // Make content column fill remaining space
      .backgroundColor(AppTokens.Colors.background) // Ensure content background is black
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // statusBarHidden(true) equivalent: the status bar is hidden via the
    // application's full-screen / immersive configuration.
  }
}

// MARK: - App Entry Point
// In SwiftUI, AudioMixerApp conforms to the App protocol and customizes
// UIKit control appearances (UISlider, UIProgressView) in its init().
// ArkUI has no global UIAppearance equivalent, so the same colors are applied
// directly on each Slider/Progress component above to preserve behavior.
// The @Entry decorator on RootScreen serves as the application entry point.

// MARK: - Preview Provider
// SwiftUI's RootScreen_Previews (PreviewProvider) is an Xcode canvas helper
// with no ArkUI equivalent and is omitted here.
