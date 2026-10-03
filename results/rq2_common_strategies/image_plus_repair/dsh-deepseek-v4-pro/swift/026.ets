// Translated from SwiftUI to ArkTS (HarmonyOS).
// The SwiftUI `Color` extension is represented by helper functions below, since
// ArkUI colors are expressed as '#AARRGGBB' strings / ResourceColor values.

// MARK: - Color Extension for Hex Initialization

// Formats a byte value (0-255) as a two-character uppercase hexadecimal string.
function toHex2(value: number): string {
  const hexChars: string = '0123456789ABCDEF'
  return hexChars.charAt((value >> 4) & 0xF) + hexChars.charAt(value & 0xF)
}

// Initializes a Color string (#AARRGGBB) from a 32-bit hexadecimal integer
// (0xAARRGGBB or 0xRRGGBB).
// If the alpha component is not explicitly provided (i.e., hex value is < 0x1000000),
// it defaults to a fully opaque color (alpha = 1.0).
function hexColor(hex: number): string {
  const red: number = ((hex & 0xFF0000) >> 16) & 0xFF
  const green: number = ((hex & 0x00FF00) >> 8) & 0xFF
  const blue: number = (hex & 0x0000FF) & 0xFF
  const alpha: number = ((hex & 0xFF000000) >> 24) & 0xFF

  // If the hex value is in 0xRRGGBB format (no explicit alpha), set alpha to 1.0
  // Otherwise, use the extracted alpha.
  const finalAlpha: number = ((hex & 0xFF000000) === 0) ? 0xFF : alpha
  return '#' + toHex2(finalAlpha) + toHex2(red) + toHex2(green) + toHex2(blue)
}

// Applies an opacity multiplier to the alpha channel of an '#AARRGGBB' color string.
function withOpacity(color: string, opacity: number): string {
  const alpha: number = Math.round(opacity * 255)
  return '#' + toHex2(alpha) + color.substring(3)
}

// MARK: - AppTokens

class AppTokensColors {
  static readonly primary: string = hexColor(0xFF38BDF8)
  static readonly secondary: string = hexColor(0xFFA78BFA)
  static readonly tertiary: string = hexColor(0xFF7DD3FC)
  static readonly background: string = hexColor(0xFFF1F5F9)
  static readonly surface: string = hexColor(0xFFFFFFFF)
  static readonly surfaceVariant: string = hexColor(0xFFE2E8F0)
  static readonly outline: string = hexColor(0xFFCBD5E1)
  static readonly success: string = hexColor(0xFF22C55E)
  static readonly warning: string = hexColor(0xFFF59E0B)
  static readonly error: string = hexColor(0xFFEF4444)
  static readonly onPrimary: string = hexColor(0xFFFFFFFF)
  static readonly onSecondary: string = hexColor(0xFF1E1E1E)
  static readonly onTertiary: string = hexColor(0xFF1E1E1E)
  static readonly onBackground: string = hexColor(0xFF1E1E1E)
  static readonly onSurface: string = hexColor(0xFF1E1E1E)
}

class TypographyTokens {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Normal // FontWeight.Normal maps to .regular
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppTokensShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class Spacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class ShadowSpec {
  elevation: number // Conceptual elevation, often influences radius and dy
  radius: number    // Blur radius of the shadow
  dy: number        // Vertical offset of the shadow
  opacity: number   // Opacity of the shadow color

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

// Equivalent to CGSize, used for the scroll offset state.
class OffsetSize {
  width: number = 0
  height: number = 0
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  // Equivalent to `var scrollOffset by remember { mutableStateOf(Offset(0f, 0f)) }`
  @State scrollOffset: OffsetSize = new OffsetSize()

  build() {
    // Equivalent to Scaffold's main content layout, with containerColor as background
    Column({ space: 0 }) {
      // Equivalent to CenterAlignedTopAppBar
      Text('Glass Doc Reader')
        .fontSize(TypographyTokens.displaySize)
        .fontWeight(TypographyTokens.displayWeight)
        .fontColor(AppTokensColors.onSurface)
        .padding({ top: 20 + Spacing.lg, bottom: Spacing.lg }) // Provides vertical spacing for the title
        .textAlign(TextAlign.Center) // Centers the text horizontally
        .width('100%')
        .backgroundColor(AppTokensColors.background) // Top bar background color

      // Main content area, equivalent to Compose's Box
      Stack({ alignContent: Alignment.Center }) { // contentAlignment = Alignment.Center
        // Equivalent to Compose's Surface
        Column({ space: Spacing.md }) { // Equivalent to Compose's Column
          Text('Document Reader')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(AppTokensColors.primary)

          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Text('This is a sample line of text content number ' + (index + 1) + '.')
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(AppTokensColors.onSurface)
          }, (index: number) => index.toString())

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(Spacing.lg) // Padding inside the Surface content
        .width('90%') // fillMaxWidth(0.9f)
        .height(400) // height(400.dp)
        .backgroundColor(withOpacity(AppTokensColors.surface, 0.7)) // color = AppTokens.Colors.surface.copy(alpha = 0.7f)
        .borderRadius(AppTokensShapes.large) // shape = AppTokens.Shapes.large
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: withOpacity('#FF000000', ElevationMapping.level2.opacity),
          offsetX: 0, // Assuming no horizontal offset for shadow as not explicitly defined in Compose's ShadowSpec
          offsetY: ElevationMapping.level2.dy
        })
        .offset({ y: this.scrollOffset.height / 5 }) // offset(y = scrollOffset.y.dp / 5)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffset.height += event.offsetY
            })
        )
      }
      .width('100%')
      .layoutWeight(1) // Box fillMaxSize()
      // Background gradient for the Box
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [withOpacity(AppTokensColors.surfaceVariant, 0.8), 0.0],
          [AppTokensColors.background, 0.5],
          [withOpacity(AppTokensColors.surfaceVariant, 0.8), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background) // Scaffold containerColor applied to the VStack
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App Entry Point
// SwiftUI's `@main struct SingleFileUIApp: App` and the `RootScreen_Previews`
// PreviewProvider have no direct ArkTS page-level equivalents; a single .ets page
// uses the @Entry-decorated component above as its entry point. The full-screen
// (edge-to-edge) requirement and hidden status bar are represented by the
// expandSafeArea call on the root container.
