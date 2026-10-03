// MARK: - AppTokens
// This struct defines the design tokens for the application, making it easy to modify styles globally.
// Translated to ArkTS: SwiftUI structs become ArkTS classes with static members.

// Colors used throughout the application.
class AppColors {
  static readonly primary: string = '#FF7043'
  static readonly secondary: string = '#FFB74D'
  static readonly tertiary: string = '#FFD54F'
  static readonly background: string = '#FFF8E1'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFECB3'
  static readonly outline: string = '#E0C097'
  static readonly success: string = '#43A047'
  static readonly warning: string = '#FBC02D'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onTertiary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
}

// A font token combining size and weight (SwiftUI Font -> ArkUI fontSize/fontWeight).
class FontToken {
  size: number
  weight: FontWeight
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

// Typography styles for different text elements.
class TypographyTokens {
  static readonly display: FontToken = new FontToken(28, FontWeight.Bold)
  static readonly headline: FontToken = new FontToken(20, FontWeight.Medium)
  static readonly title: FontToken = new FontToken(16, FontWeight.Medium)
  static readonly body: FontToken = new FontToken(14, FontWeight.Regular)
  static readonly label: FontToken = new FontToken(12, FontWeight.Medium)
}

// Shapes with predefined corner radii (RoundedRectangle(cornerRadius:) -> borderRadius()).
class Shapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

// Standardized spacing values.
class Spacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

// Shadow specifications for elevation effects.
class ShadowSpec {
  elevation: number // Corresponds to blur radius in SwiftUI's shadow
  radius: number    // Not directly mapped, often combined with elevation
  dy: number        // Y-offset for the shadow
  opacity: number   // Opacity of the shadow
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

// Predefined elevation levels with their shadow specs.
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.1)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16)
}

// MARK: - Custom Environment Values for Theming
// These structs and extensions allow us to mimic a MaterialTheme-like system in SwiftUI
// by providing custom color schemes and typography through the environment.
// In ArkUI, theme values are supplied directly via the global default instances below.

// Defines the application's color scheme.
class AppColorScheme {
  primary: string
  onPrimary: string
  secondary: string
  onSecondary: string
  background: string
  onBackground: string
  surface: string
  onSurface: string
  surfaceVariant: string
  outline: string
  error: string
  constructor(primary: string, onPrimary: string, secondary: string, onSecondary: string,
    background: string, onBackground: string, surface: string, onSurface: string,
    surfaceVariant: string, outline: string, error: string) {
    this.primary = primary
    this.onPrimary = onPrimary
    this.secondary = secondary
    this.onSecondary = onSecondary
    this.background = background
    this.onBackground = onBackground
    this.surface = surface
    this.onSurface = onSurface
    this.surfaceVariant = surfaceVariant
    this.outline = outline
    this.error = error
  }
}

// Default color scheme (mimics AppColorSchemeKey.defaultValue).
const defaultAppColorScheme: AppColorScheme = new AppColorScheme(
  AppColors.primary, AppColors.onPrimary,
  AppColors.secondary, AppColors.onSecondary,
  AppColors.background, AppColors.onBackground,
  AppColors.surface, AppColors.onSurface,
  AppColors.surfaceVariant, AppColors.outline, AppColors.error
)

// Defines the application's typography.
class AppTypography {
  displayLarge: FontToken
  headlineMedium: FontToken
  titleMedium: FontToken
  bodyMedium: FontToken
  labelMedium: FontToken
  constructor(displayLarge: FontToken, headlineMedium: FontToken, titleMedium: FontToken,
    bodyMedium: FontToken, labelMedium: FontToken) {
    this.displayLarge = displayLarge
    this.headlineMedium = headlineMedium
    this.titleMedium = titleMedium
    this.bodyMedium = bodyMedium
    this.labelMedium = labelMedium
  }
}

// Default typography (mimics AppTypographyKey.defaultValue).
const defaultAppTypography: AppTypography = new AppTypography(
  TypographyTokens.display, TypographyTokens.headline, TypographyTokens.title,
  TypographyTokens.body, TypographyTokens.label
)

// MARK: - Client Data Model
// Represents a client with various details and map coordinates.
interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number // Relative X position (0.0 to 1.0)
  y: number // Relative Y position (0.0 to 1.0)
}

// MARK: - Custom Views

// A custom view for displaying a map marker with a label.
@Component
struct MapMarker {
  label: string = ''
  level: string = ''
  @Prop selected: boolean = false
  onMarkerClick: () => void = () => {}
  xOffset: number = 0 // Base X offset from the container's top-leading corner
  yOffset: number = 0 // Base Y offset from the container's top-leading corner

  markerColor(): string {
    if (this.level === 'A') {
      return AppColors.primary
    } else if (this.level === 'B') {
      return AppColors.secondary
    } else {
      return AppColors.tertiary
    }
  }

  build() {
    // ZStack is used to layer the marker dot and the label card.
    // Alignment is .topLeading, and then individual offsets are applied.
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker Dot (CircleShape in Compose)
      Circle()
        .fill(this.markerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .stroke(this.selected ? AppColors.onPrimary : AppColors.surface)
        .strokeWidth(2)
        .offset({ x: this.xOffset, y: this.yOffset }) // Apply the base offset to the marker dot

      // Label Card (Card in Compose)
      Text(this.label)
        .fontSize(defaultAppTypography.labelMedium.size)
        .fontWeight(defaultAppTypography.labelMedium.weight)
        .fontColor(defaultAppColorScheme.onSurface)
        .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
        .backgroundColor(defaultAppColorScheme.surfaceVariant)
        .borderRadius(Shapes.small)
        .border({ width: 1, color: defaultAppColorScheme.outline })
        .shadow({
          radius: ElevationMapping.level1.radius,
          color: '#1A000000',
          offsetX: 0,
          offsetY: ElevationMapping.level1.dy
        })
        .onClick(() => {
          this.onMarkerClick()
        })
        // Apply the base offset plus the additional offset specified in Kotlin
        .offset({ x: this.xOffset + 20, y: this.yOffset - 4 })
    }
  }
}

// A custom view to draw a grid overlay on the map.
// Mimics `Arrangement.SpaceEvenly` for 6 lines within the padded area.
@Component
struct MapGridOverlayCorrected {
  @State gridWidth: number = 0
  @State gridHeight: number = 0
  lineIndices: number[] = [0, 1, 2, 3, 4, 5]

  availableWidth(): number {
    return this.gridWidth - 2 * Spacing.lg
  }

  availableHeight(): number {
    return this.gridHeight - 2 * Spacing.lg
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Horizontal lines: 6 lines distributed evenly, meaning 7 equal segments.
      ForEach(this.lineIndices, (i: number) => {
        Rect()
          .fill(defaultAppColorScheme.surfaceVariant)
          .width('100%')
          .height(1)
          .offset({ x: 0, y: Spacing.lg + (this.availableHeight() / 7.0) * (i + 1) })
      }, (i: number) => i.toString())

      // Vertical lines: 6 lines distributed evenly, meaning 7 equal segments.
      ForEach(this.lineIndices, (i: number) => {
        Rect()
          .fill(defaultAppColorScheme.surfaceVariant)
          .width(1)
          .height('100%')
          .offset({ x: Spacing.lg + (this.availableWidth() / 7.0) * (i + 1), y: 0 })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.gridWidth = Number(newValue.width)
      this.gridHeight = Number(newValue.height)
    })
  }
}

// MARK: - RootScreen
// The main content view of the application.
@Entry
@Component
struct RootScreen {
  @State selectedId: number = -1 // State to track the selected client marker.
  @State mapWidth: number = 0 // Measured width of the map area (GeometryReader).
  @State mapHeight: number = 0 // Measured height of the map area (GeometryReader).

  // Sample client data.
  clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  build() {
    // Column acts as the Scaffold, arranging Top Bar and content vertically.
    Column({ space: 0 }) {
      // Custom Top Bar (mimics CenterAlignedTopAppBar)
      Stack() {
        Text('Client Detail')
          .fontSize(defaultAppTypography.displayLarge.size)
          .fontWeight(defaultAppTypography.displayLarge.weight)
          .fontColor(defaultAppColorScheme.onSurface)
          .padding({ top: Spacing.md, bottom: Spacing.md }) // Vertical padding for text
      }
      .width('100%')
      .height(56) // Standard Material3 TopAppBar height
      .backgroundColor(defaultAppColorScheme.background) // Background color for the top bar area

      // Scrollable content area (mimics LazyColumn and other content below TopAppBar)
      Scroll() {
        Column({ space: Spacing.md }) { // Vertical arrangement with spacing
          // Box 1: Regional Client Map header
          Text('Regional Client Map')
            .fontSize(defaultAppTypography.headlineMedium.size)
            .fontWeight(defaultAppTypography.headlineMedium.weight)
            .fontColor(AppColors.onPrimary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .constraintSize({ minHeight: 200 }) // height(200.dp)
            .linearGradient({
              angle: 90,
              colors: [[AppColors.secondary, 0.0], [AppColors.primary, 1.0]]
            })
            .borderRadius(Shapes.large) // RoundedCornerShape(large)
            .padding({ left: Spacing.lg, right: Spacing.lg }) // Horizontal padding from Column
            .padding({ top: Spacing.md }) // Top padding from Column

          // BoxWithConstraints: Map area
          Stack({ alignContent: Alignment.TopStart }) { // Alignment for MapMarker positioning
            MapGridOverlayCorrected() // The grid overlay

            // Iterate through clients to place MapMarkers
            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onMarkerClick: () => {
                  this.selectedId = (this.selectedId === client.id) ? -1 : client.id
                },
                // Calculate marker position based on relative coordinates and GeometryReader size
                xOffset: this.mapWidth * client.x,
                yOffset: this.mapHeight * client.y
              })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .aspectRatio(0.9) // aspectRatio(0.9f)
          .constraintSize({ minHeight: 360 }) // heightIn(min = 360.dp)
          .backgroundColor(defaultAppColorScheme.surface) // Background shape fill
          .borderRadius(Shapes.large) // Rounded corner for the map card
          .border({ width: 1, color: defaultAppColorScheme.outline }) // Border
          .padding({ left: Spacing.lg, right: Spacing.lg }) // Horizontal padding from Column
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.mapWidth = Number(newValue.width)
            this.mapHeight = Number(newValue.height)
          })

          // LazyColumn: Client List
          Column({ space: Spacing.md }) { // Vertical arrangement with spacing
            ForEach(this.clients, (client: Client) => {
              // Card for each client
              Stack() {
                Row() { // Row for client details
                  Column({ space: Spacing.xs }) { // Column for name and region
                    Text(client.name)
                      .fontSize(defaultAppTypography.titleMedium.size)
                      .fontWeight(defaultAppTypography.titleMedium.weight)
                      .fontColor(defaultAppColorScheme.onSurface)
                    Text(client.region)
                      .fontSize(defaultAppTypography.bodyMedium.size)
                      .fontWeight(defaultAppTypography.bodyMedium.weight)
                      .fontColor(defaultAppColorScheme.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank() // Pushes "Level" text to the right

                  Text(`Level ${client.level}`)
                    .fontSize(defaultAppTypography.labelMedium.size)
                    .fontWeight(defaultAppTypography.labelMedium.weight)
                    .fontColor(defaultAppColorScheme.primary)
                }
                .width('100%')
                .padding(Spacing.lg) // Padding inside the card
              }
              .width('100%') // Card fills available width
              .backgroundColor(defaultAppColorScheme.surface) // Card background shape
              .borderRadius(Shapes.medium) // Rounded card
              .border({ width: 1, color: defaultAppColorScheme.outline }) // Card border
              .shadow({
                radius: ElevationMapping.level1.radius,
                color: '#1A000000',
                offsetX: 0,
                offsetY: ElevationMapping.level1.dy
              })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg }) // Horizontal padding from Column
          .padding({ bottom: Spacing.xxl }) // contentPadding for LazyColumn
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(defaultAppColorScheme.background) // Background for the scrollable content
    }
    .width('100%')
    .height('100%')
    .expandSafeArea() // Make the app content extend to all edges, ignoring safe areas.
    // statusBarHidden(true) has no direct ArkUI modifier; it maps to window system bar configuration.
    .backgroundColor(defaultAppColorScheme.background) // Ensure the very root background matches the theme.
  }
}

// MARK: - App Entry Point
// The main entry point for the SwiftUI application.
// In ArkTS, RootScreen serves as the @Entry page (the ClientDetailApp WindowGroup maps to it).
// The .appTheme() modifier is unnecessary: the theme is applied via the default
// color scheme and typography instances referenced directly above.
