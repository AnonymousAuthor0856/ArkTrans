// MARK: - AppTokens (Atomic Design System)
// This section defines all the design tokens, ensuring atomic correspondence with the Kotlin version.
// All Dp values are directly translated to number (vp), and sp values to number (fp) for font sizes.

class AppTokensColors {
  static readonly primary: string = '#1E293B'   // Color(red: 30/255, green: 41/255, blue: 59/255)
  static readonly secondary: string = '#0EA5E9' // Color(red: 14/255, green: 165/255, blue: 233/255)
  static readonly tertiary: string = '#FACC15'  // Color(red: 250/255, green: 204/255, blue: 21/255)
  static readonly background: string = '#1E293B' // Color(red: 30/255, green: 41/255, blue: 59/255)
  static readonly surface: string = '#1E293B'   // Color(red: 30/255, green: 41/255, blue: 59/255)
  static readonly surfaceVariant: string = '#334155' // Color(red: 51/255, green: 65/255, blue: 85/255)
  static readonly outline: string = '#475569'   // Color(red: 71/255, green: 85/255, blue: 105/255)
  static readonly success: string = '#22C55E'   // Color(red: 34/255, green: 197/255, blue: 94/255)
  static readonly warning: string = '#F59E0B'   // Color(red: 245/255, green: 158/255, blue: 11/255)
  static readonly error: string = '#EF4444'     // Color(red: 239/255, green: 68/255, blue: 68/255)
  static readonly onPrimary: string = '#FFFFFF' // Color(red: 255/255, green: 255/255, blue: 255/255)
  static readonly onSecondary: string = '#FFFFFF' // Color(red: 255/255, green: 255/255, blue: 255/255)
  static readonly onTertiary: string = '#0B1220' // Color(red: 11/255, green: 18/255, blue: 32/255)
  static readonly onBackground: string = '#E2E8F0' // Color(red: 226/255, green: 232/255, blue: 240/255)
  static readonly onSurface: string = '#E2E8F0'  // Color(red: 226/255, green: 232/255, blue: 240/255)
}

class FontSpec {
  size: number;
  weight: number;
  constructor(size: number, weight: number) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTokensTypography {
  // Using the system default font for direct size and weight mapping.
  // Kotlin's sp (scalable pixels) are mapped to ArkUI's fp (font pixels).
  static readonly display: FontSpec = new FontSpec(26, 700); // .system(size: 26, weight: .bold)
  static readonly headline: FontSpec = new FontSpec(20, 600); // .system(size: 20, weight: .semibold)
  static readonly title: FontSpec = new FontSpec(16, 500); // .system(size: 16, weight: .medium)
  static readonly body: FontSpec = new FontSpec(14, 400); // .system(size: 14, weight: .regular)
  static readonly label: FontSpec = new FontSpec(12, 500); // .system(size: 12, weight: .medium)
}

class AppTokensShapes {
  // Kotlin's Dp values for RoundedCornerShape are mapped to number (vp) for borderRadius.
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppTokensSpacing {
  // Kotlin's Dp values for spacing are mapped to number (vp).
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// Shadow mapping from Android's elevation to ArkUI's shadow.
// Android's elevation is a complex concept that often involves multiple shadows and z-index.
// For a "Retro Flat" style, a single, well-placed shadow is often sufficient and visually similar.
// Kotlin's ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
// ArkUI's shadow({ radius: number, color: ResourceColor, offsetX: number, offsetY: number })
// We map Kotlin's `radius` to ArkUI's `radius`, `dy` to ArkUI's `offsetY`, and `opacity` directly.
class ShadowSpec {
  radius: number; // Blur radius
  y: number; // Vertical offset
  opacity: number; // Shadow opacity

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
  }
}

class AppTokensShadowSpec {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 1, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 2, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 3, 0.16);
}

// MARK: - Data Model
// Directly translates the Kotlin data class into an ArkTS class.

class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

// MARK: - Custom Views
// Translating Composable functions into ArkUI components, maintaining layout and style.

@Component
struct CustomTopAppBar {
  title: string = '';

  build() {
    // Mimics Android's CenterAlignedTopAppBar
    Row() {
      Blank()
      Text(this.title)
        .fontSize(AppTokensTypography.display.size)
        .fontWeight(AppTokensTypography.display.weight)
        .fontColor(AppTokensColors.onBackground)
      Blank()
    }
    .padding({ top: AppTokensSpacing.md, bottom: AppTokensSpacing.md }) // Vertical padding for the top bar itself
    .backgroundColor(AppTokensColors.background) // Top bar background color
  }
}

@Component
struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: AppTokensSpacing.md }) { // horizontalArrangement = Arrangement.spacedBy(AppTokensSpacing.md)
      Stack() { // Box equivalent
        Text(`${this.marker.id}`)
          .fontColor(AppTokensColors.onSecondary)
          .fontSize(AppTokensTypography.label.size)
          .fontWeight(AppTokensTypography.label.weight)
      }
      .width(32)
      .height(32) // size(32.dp)
      .backgroundColor(AppTokensColors.secondary)
      .borderRadius(AppTokensShapes.small)

      Column() { // Column equivalent
        Text(this.marker.name)
          .fontSize(AppTokensTypography.title.size)
          .fontWeight(AppTokensTypography.title.weight)
          .fontColor(AppTokensColors.onSurface)
        Text(this.marker.desc)
          .fontSize(AppTokensTypography.body.size)
          .fontWeight(AppTokensTypography.body.weight)
          .fontColor(AppTokensColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokensSpacing.md) // padding(AppTokensSpacing.md)
    .width('100%') // fillMaxWidth()
    .alignItems(VerticalAlign.Center) // Center the box and column vertically
    .backgroundColor(AppTokensColors.surfaceVariant) // CardDefaults.cardColors(containerColor = AppTokensColors.surfaceVariant)
    .borderRadius(AppTokensShapes.medium) // shape = AppTokensShapes.medium
    // Apply a subtle shadow to mimic Material Design's default card elevation.
    .shadow({
      radius: AppTokensShadowSpec.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokensShadowSpec.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokensShadowSpec.level1.y
    })
  }
}

// MARK: - RootScreen
// The main content view, equivalent to Kotlin's RootScreen Composable.
// `@Entry` here is the ArkTS equivalent of SwiftUI's `@main` app entry point.

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  build() {
    Column({ space: 0 }) { // Mimics Scaffold, managing top bar and scrollable content
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() { // LazyColumn equivalent for scrollability
        Column({ space: AppTokensSpacing.lg }) { // Column equivalent, verticalArrangement = Arrangement.spacedBy(AppTokensSpacing.lg)
          Text('Project Files')
            .fontSize(AppTokensTypography.headline.size)
            .fontWeight(AppTokensTypography.headline.weight)
            .fontColor(AppTokensColors.onBackground)

          Column({ space: AppTokensSpacing.sm }) { // LazyColumn equivalent for efficient list rendering
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppTokensSpacing.xl }) // contentPadding = PaddingValues(bottom = AppTokensSpacing.xl)

          Text('Live Terminal')
            .fontSize(AppTokensTypography.headline.size)
            .fontWeight(AppTokensTypography.headline.weight)
            .fontColor(AppTokensColors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) { // Box equivalent
            Column()
              .width('100%') // fillMaxWidth()
              .height(240) // height(240.dp)
              .backgroundColor(AppTokensColors.surfaceVariant)
              .borderRadius(AppTokensShapes.medium)
              .border({ width: 1, color: AppTokensColors.outline, radius: AppTokensShapes.medium }) // border(1.dp, AppTokensColors.outline, AppTokensShapes.medium)
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokensTypography.body.size)
              .fontWeight(AppTokensTypography.body.weight)
              .fontColor(AppTokensColors.onSurface)
              .padding(AppTokensSpacing.md) // padding(AppTokensSpacing.md)
          }
          .width('100%')

          Button('Run Code', { type: ButtonType.Normal })
            .fontSize(AppTokensTypography.title.size)
            .fontWeight(AppTokensTypography.title.weight)
            .fontColor(AppTokensColors.onSecondary)
            // modifier = Modifier.align(Alignment.CenterHorizontally).fillMaxWidth(0.6f).height(48.dp)
            .width('60%') // fillMaxWidth(0.6f)
            .height(48) // height(48.dp)
            .backgroundColor(AppTokensColors.secondary) // ButtonDefaults.buttonColors(containerColor = AppTokensColors.secondary)
            .borderRadius(AppTokensShapes.large) // shape = AppTokensShapes.large
            // Apply a subtle shadow to the button for a lifted effect.
            .shadow({
              radius: AppTokensShadowSpec.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokensShadowSpec.level1.opacity})`,
              offsetX: 0,
              offsetY: AppTokensShadowSpec.level1.y
            })
            .alignSelf(ItemAlign.Center) // This modifier centers the button horizontally
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokensSpacing.lg) // modifier = Modifier.padding(AppTokensSpacing.lg)
        .width('100%') // Ensure the Column takes full width for proper alignment
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off) // showsIndicators = false
      // background(Brush.verticalGradient(...))
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(30, 41, 59, 0.8)', 0.0], // AppTokensColors.primary.opacity(0.8)
          ['rgba(30, 41, 59, 0.9)', 1.0] // AppTokensColors.surface.opacity(0.9)
        ]
      })
    }
    .backgroundColor(AppTokensColors.background) // containerColor = MaterialTheme.colorScheme.background
    .width('100%')
    .height('100%')
    // Ensures the app content extends to the edges of the screen, ignoring safe areas.
    // SwiftUI: .ignoresSafeArea(.all, edges: .all) / .statusBarHidden(true)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App Entry Point
// The main application structure for SwiftUI, equivalent to MainActivity.
// In ArkTS, the `@Entry` decorator on RootScreen replaces the `@main struct SingleFileUIApp: App`
// WindowGroup entry point, and the preview provider is not required at runtime.
