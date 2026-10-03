// MARK: - AppTokens (Equivalent to Kotlin AppTokens object)
// SwiftUI nested structs are mapped to top-level ArkTS classes, since ArkTS does
// not support nested class declarations the way Swift does.

// MARK: Colors
class AppColors {
  // Hex values for reference:
  // primary: #FF8C00
  // secondary: #FFC107
  // tertiary: #FFE082
  // background: #FFF8E1
  // surface: #FFFFFF
  // surfaceVariant: #FFECB3
  // outline: #D7CCC8
  // success: #4CAF50
  // warning: #FFB300
  // error: #E53935
  // onPrimary: #3E2723
  // onSecondary: #3E2723
  // onBackground: #3E2723
  // onSurface: #3E2723

  static readonly primary: string = '#FF8C00';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE082';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#D7CCC8';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#3E2723';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';

  // Builds an ARGB (#AARRGGBB) color string by applying an opacity to an RGB color.
  // Equivalent to SwiftUI's Color.opacity(_:).
  static withOpacity(color: string, opacity: number): string {
    let alpha: string = Math.round(opacity * 255).toString(16);
    if (alpha.length < 2) {
      alpha = '0' + alpha;
    }
    return '#' + alpha.toUpperCase() + color.substring(1);
  }
}

// MARK: TypographyTokens
class AppTypography {
  // Font sizes (sp) and weights
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular; // Kotlin's FontWeight.Normal maps to .regular
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// MARK: Shapes
class AppShapes {
  // Corner radii (dp)
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

// MARK: Spacing
class AppSpacing {
  // Spacing values (dp)
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

// MARK: ShadowSpec (for elevation mapping)
class ShadowSpec {
  elevation: number; // Corresponds to blur radius in SwiftUI's .shadow
  radius: number;    // Not directly mapped as a separate blur radius in ArkUI, elevation is used.
  dy: number;        // Y-offset for the shadow
  opacity: number;   // Opacity of the shadow

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// MARK: ElevationMapping
class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

// MARK: - Pin Data Model (Equivalent to Kotlin data class Pin)
class Pin {
  static nextId: number = 0;
  id: number; // Required for ForEach in ArkUI to uniquely identify elements
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = Pin.nextId;
    Pin.nextId++;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - RootScreen (Equivalent to Kotlin RootScreen Composable)
@Component
struct RootScreen {
  // @State for mutable state, equivalent to remember { mutableStateListOf(...) }
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ];

  build() {
    // Scaffold equivalent: A Stack to set the background color for the entire screen,
    // and a Column for the main content layout.
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppSpacing.lg }) { // Column equivalent, with vertical arrangement spacedBy(lg)
        Text('Retro Group Buy')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start) // Align text to the start (left)

        // Card equivalent for "Live Deals Map"
        Column({ space: AppSpacing.md }) { // Column equivalent inside card
          Text('Live Deals Map')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)

          // Box equivalent for the map canvas
          Stack({ alignContent: Alignment.TopStart }) {
            // Draw pins on the canvas. drawCircle(radius = 14f) means diameter is 28f,
            // so each pin is a 28x28 circle centered at (pin.x, pin.y).
            ForEach(this.pins, (pin: Pin) => {
              Circle()
                .fill(AppColors.primary)
                .width(28)
                .height(28)
                .position({ x: pin.x - 14, y: pin.y - 14 })
            }, (pin: Pin) => pin.id.toString())
          }
          .width('100%') // fillMaxWidth()
          .height(220) // height(220.dp)
          .backgroundColor(AppColors.surfaceVariant) // Background matching Kotlin's .background(surfaceVariant, medium)
          .borderRadius(AppShapes.medium) // Apply rounded corners
          .clip(true) // Clip pin circles to the canvas bounds, like SwiftUI's Canvas
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppSpacing.lg) // Padding inside the card, matching Kotlin's .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface) // Card background color
        .borderRadius(AppShapes.large) // Card shape
        .shadow({
          radius: AppElevation.level2.elevation, // blur radius
          color: AppColors.withOpacity(AppColors.onSurface, AppElevation.level2.opacity),
          offsetX: 0, // No x-offset in Kotlin's shadow
          offsetY: AppElevation.level2.dy
        }) // Card elevation

        Blank().height(AppSpacing.sm) // Spacer equivalent

        // Row equivalent for buttons
        Row({ space: AppSpacing.md }) { // horizontalArrangement = Arrangement.spacedBy(AppSpacing.md)
          Button('Add Group')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onSecondary)
            .height(48) // height(48.dp)
            .backgroundColor(AppColors.secondary) // containerColor
            .borderRadius(AppShapes.medium) // shape
            .layoutWeight(1) // Modifier.weight(1f) equivalent
            .onClick(() => {
              // Random.nextInt(100, 550) generates 100 to 549
              // Random.nextInt(150, 450) generates 150 to 449
              const randomX: number = Math.floor(Math.random() * 450) + 100;
              const randomY: number = Math.floor(Math.random() * 300) + 150;
              this.pins.push(new Pin(randomX, randomY, 'New'));
            })

          Button('Clear')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
            .height(48) // height(48.dp)
            .backgroundColor(AppColors.primary) // containerColor
            .borderRadius(AppShapes.medium) // shape
            .layoutWeight(1) // Modifier.weight(1f) equivalent
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')

        // Card equivalent for "Active Groups"
        Column({ space: AppSpacing.sm }) { // Column equivalent inside card
          Text('Active Groups')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.primary)

          // ForEach for dynamic list items, equivalent to pins.forEach
          ForEach(this.pins, (pin: Pin) => {
            Row() { // Row equivalent
              Text(pin.label)
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
              Blank() // horizontalArrangement = Arrangement.SpaceBetween
              Circle() // Box with CircleShape
                .fill(AppColors.primary)
                .width(14)
                .height(14) // size(14.dp)
            }
            .width('100%')
          }, (pin: Pin) => pin.id.toString())
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppSpacing.lg) // Padding inside the card
        .backgroundColor(AppColors.surface) // Card background color
        .borderRadius(AppShapes.large) // Card shape
        .shadow({
          radius: AppElevation.level1.elevation, // blur radius
          color: AppColors.withOpacity(AppColors.onSurface, AppElevation.level1.opacity),
          offsetX: 0,
          offsetY: AppElevation.level1.dy
        }) // Card elevation

        Blank() // Pushes content to the top, similar to fillMaxSize() without specific alignment
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg) // Outer padding for the whole column, matching .padding(pad).padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background) // Set the background color
    // MARK: Full-screen and Status Bar Hiding
    // SwiftUI's .ignoresSafeArea(.all, edges: .all) and .statusBarHidden(true) hide the
    // status bar and extend the background under safe areas. In ArkUI this is configured
    // at the window/ability level (e.g. setWindowLayoutFullScreen) rather than a modifier.
  }
}

// MARK: - App Entry Point (Equivalent to MainActivity)
// SwiftUI's WindowGroup { RootScreen() } maps to a full-screen container hosting RootScreen.
@Entry
@Component
struct GroupBuyApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
