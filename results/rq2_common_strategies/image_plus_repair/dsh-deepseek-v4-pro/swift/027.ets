// MARK: - AppTokens Translation
// This section translates the AppTokens object from Kotlin to ArkTS.
// It defines custom colors, typography styles, shapes, spacing, and elevation for consistent UI elements.

// Converts a byte value (0-255) to a two-character hexadecimal string.
function toHexByte(value: number): string {
  const s: string = value.toString(16)
  return s.length < 2 ? '0' + s : s
}

// Initializes an ArkUI color string from a 32-bit hexadecimal integer, similar to Android's 0xFF format.
// - Parameters:
//   - hex: The hexadecimal value (e.g., 0xFFA0C4FF).
//   - alpha: The alpha component, defaults to 1.0 (fully opaque).
function colorFromHex(hex: number, alpha: number = 1.0): string {
  const red: number = (hex >> 16) & 0xFF
  const green: number = (hex >> 8) & 0xFF
  const blue: number = hex & 0xFF
  const a: number = Math.round(alpha * 255)
  return '#' + toHexByte(a) + toHexByte(red) + toHexByte(green) + toHexByte(blue)
}

// A class containing all design tokens for the application, mirroring Kotlin's AppTokens.
class AppColors {
  static readonly primary: string = colorFromHex(0xFFA0C4FF)
  static readonly secondary: string = colorFromHex(0xFFB7E4C7)
  static readonly tertiary: string = colorFromHex(0xFFFFDDC1)
  static readonly background: string = colorFromHex(0xFFF8F7FF)
  static readonly surface: string = colorFromHex(0xFFFFFFFF)
  static readonly surfaceVariant: string = colorFromHex(0xFFF0F0F5)
  static readonly outline: string = colorFromHex(0xFFD9D9E3)
  static readonly success: string = colorFromHex(0xFFB4E4C7)
  static readonly warning: string = colorFromHex(0xFFFFDDC1)
  static readonly error: string = colorFromHex(0xFFFFB4AB)
  static readonly onPrimary: string = colorFromHex(0xFF001D3D)
  static readonly onSecondary: string = colorFromHex(0xFF003720)
  static readonly onTertiary: string = colorFromHex(0xFF3E2800)
  static readonly onBackground: string = colorFromHex(0xFF1B1B1F)
  static readonly onSurface: string = colorFromHex(0xFF1B1B1F)
}

class AppTypography {
  // ArkUI's fontSize/fontWeight allow specifying size and weight directly.
  // Line height and letter spacing can be applied as separate attributes if needed globally,
  // but for this UI, direct font application is sufficient.
  static readonly displaySize: number = 45
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineSize: number = 24
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly smallRadius: number = 4.0
  static readonly mediumRadius: number = 8.0
  static readonly largeRadius: number = 12.0
  // A circle is represented in ArkUI by a borderRadius of half the component size,
  // or by the Circle() shape component.
}

class AppSpacing {
  // Using number for Dp values, assuming 1dp = 1vp for direct translation.
  static readonly xs: number = 4.0
  static readonly sm: number = 8.0
  static readonly md: number = 12.0
  static readonly lg: number = 16.0
  static readonly xl: number = 24.0
}

// Represents a shadow specification, similar to Android's elevation.
class ShadowSpec {
  elevation: number // Corresponds to ArkUI's shadow radius
  radius: number    // Corresponds to ArkUI's shadow radius (often combined with elevation)
  dy: number        // Corresponds to ArkUI's shadow y-offset
  opacity: number   // Corresponds to ArkUI's shadow color opacity

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  // Mapping Android elevation to ArkUI shadow properties.
  // 'elevation' from Kotlin is often best represented by ArkUI's 'radius' for visual softness.
  // 'radius' from Kotlin's ShadowSpec is also used for ArkUI's 'radius'.
  // 'dy' directly maps to ArkUI's 'y' offset.
  static readonly level1: ShadowSpec = new ShadowSpec(1.0, 2.0, 1.0, 0.08)
  static readonly level2: ShadowSpec = new ShadowSpec(3.0, 4.0, 2.0, 0.10)
  static readonly level3: ShadowSpec = new ShadowSpec(6.0, 8.0, 4.0, 0.12)
}

// MARK: - AppTheme Equivalent
// In ArkUI, theming is often applied via attribute modifiers or directly to components.
// For this specific UI, most styles are applied directly using the AppTokens classes.

// MARK: - Reusable Components

// A reusable button for annotation tools, mirroring the Kotlin `AnnotationToolButton` composable.
@Component
struct AnnotationToolButton {
  icon: string = ''
  toolName: string = ''
  @Prop selectedTool: string = ''
  onToolClick: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(this.icon)
        .fontSize(17) // Font size for the icon, adjusted for visual parity
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppColors.onSecondary : AppColors.onSurface)
    }
    .width(40)
    .height(40) // Corresponds to Modifier.size(40.dp)
    .backgroundColor(this.toolName === this.selectedTool ? AppColors.secondary : AppColors.surfaceVariant)
    .borderRadius(20) // Corresponds to CircleShape
    .onClick(() => {
      this.onToolClick()
    })
  }
}

// MARK: - RootScreen Translation

// The main UI screen, translating the Kotlin `RootScreen` composable.
@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    // Equivalent of Scaffold in ArkUI: a Column for vertical layout,
    // with the top bar and then the main content.
    Column() {
      // Top Bar equivalent (CenterAlignedTopAppBar)
      Row() {
        // Navigation Icon (IconButton with a Box inside)
        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Circle({ width: 24, height: 24 })
            .fill(AppColors.surfaceVariant)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.Transparent) // Remove default button styling
        .onClick(() => {})

        Blank() // Pushes the title to the center

        Text('Document.pdf')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onBackground)

        Blank() // Pushes the title to the center

        // Actions (Share Button)
        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Text('Share')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
            .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs, left: AppSpacing.sm, right: AppSpacing.sm })
        }
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.smallRadius) // Corresponds to RoundedCornerShape(4.dp)
        .onClick(() => {})
      }
      .padding(AppSpacing.md) // Padding for the top bar content
      .backgroundColor(AppColors.surface) // Top bar background color
      .height(56) // Standard AppBar height in Material Design 3 is often 64dp, but 56vp is common in iOS and visually fits.
      .width('100%')

      // Main content area (Row in Compose)
      Row() {
        // Left side: Grid for pages
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Button({ type: ButtonType.Normal, stateEffect: false }) {
                Text(`${page}`)
                  .fontSize(AppTypography.labelSize)
                  .fontWeight(AppTypography.labelWeight)
                  .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
              }
              .width('100%')
              .aspectRatio(0.7) // Corresponds to Modifier.aspectRatio(0.7f)
              .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(AppShapes.mediumRadius) // Card shape (RoundedCornerShape(8.dp))
              .borderWidth(this.selectedPage === page ? 2 : 0) // BorderStroke equivalent
              .borderColor(AppColors.primary)
              .onClick(() => { this.selectedPage = page })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr') // GridCells.Fixed(2) with spacedBy
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)
        .width(150) // Corresponds to Modifier.width(150.dp)
        .padding(AppSpacing.sm) // Corresponds to contentPadding for the grid
        .height('100%') // Corresponds to .fillMaxHeight()

        // Right side: Main document view (Box in Compose)
        Stack({ alignContent: Alignment.Center }) { // Corresponds to Box(contentAlignment = Alignment.Center)
          // Main document card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTypography.headlineSize)
              .fontWeight(AppTypography.headlineWeight)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeRadius) // Card shape (RoundedCornerShape(12.dp))
          .shadow({
            radius: ElevationMapping.level1.radius, // Using radius for softness
            color: colorFromHex(0x000000, ElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: ElevationMapping.level1.dy // Shadow for elevation
          })

          // Annotation tools column
          Row() {
            Column({ space: AppSpacing.sm }) { // Corresponds to verticalArrangement = Arrangement.spacedBy(AppSpacing.sm)
              AnnotationToolButton({ icon: 'P', toolName: 'pen', selectedTool: this.selectedTool, onToolClick: () => { this.selectedTool = 'pen' } })
              AnnotationToolButton({ icon: 'H', toolName: 'highlighter', selectedTool: this.selectedTool, onToolClick: () => { this.selectedTool = 'highlighter' } })
              AnnotationToolButton({ icon: 'T', toolName: 'text', selectedTool: this.selectedTool, onToolClick: () => { this.selectedTool = 'text' } })
              AnnotationToolButton({ icon: 'S', toolName: 'shape', selectedTool: this.selectedTool, onToolClick: () => { this.selectedTool = 'shape' } })
            }
            .padding(AppSpacing.sm)
            .backgroundColor(colorFromHex(0xFFFFFF, 0.8)) // Corresponds to .background(AppTokens.Colors.surface.copy(alpha=0.8f))
            .borderRadius(AppShapes.largeRadius)
            .borderWidth(1) // Border equivalent
            .borderColor(AppColors.outline)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Start) // Corresponds to .align(Alignment.CenterStart)
          .alignItems(VerticalAlign.Center)
          .padding(AppSpacing.md)
        }
        .layoutWeight(1) // Corresponds to Modifier.weight(1f)
        .height('100%') // Corresponds to .fillMaxHeight()
      }
      .padding({ left: AppSpacing.md, right: AppSpacing.md }) // Overall padding for the main content row (left/right)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background) // Apply background to the whole screen
    // The SwiftUI .statusBarHidden(true) has no direct ArkUI equivalent in a single page file.
  }
}

// MARK: - ArkUI App Entry Point
// The main entry point for the ArkUI application is provided by the @Entry decorator on RootScreen,
// mirroring the Kotlin `MainActivity` onCreate setup and the SwiftUI `@main` App struct.
