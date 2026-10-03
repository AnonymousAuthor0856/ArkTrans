// MARK: - AppTokens (Translation of Kotlin AppTokens)

// Color tokens. Swift's Color(hex: 0xAARRGGBB) maps to ArkUI '#AARRGGBB' strings.
class AppTokensColors {
  static readonly primary: string = '#00FFFF'; // Cyan
  static readonly secondary: string = '#00B4FF'; // Light Blue
  static readonly tertiary: string = '#8A2BE2'; // Blue Violet
  static readonly background: string = '#0A0A1A'; // Dark Navy
  static readonly surface: string = '#141436'; // Darker Purple-Blue
  static readonly surfaceVariant: string = '#1E1E4A'; // Even Darker Purple-Blue
  static readonly outline: string = '#2E2E5C'; // Dark Purple-Blue
  static readonly success: string = '#00FFAA'; // Greenish Cyan
  static readonly warning: string = '#FFCC00'; // Yellow
  static readonly error: string = '#FF4444'; // Red
  static readonly onPrimary: string = '#0A0A1A'; // Dark Navy (on primary)
  static readonly onSecondary: string = '#FFFFFF'; // White
  static readonly onBackground: string = '#FFFFFF'; // White
  static readonly onSurface: string = '#FFFFFF'; // White
}

// Typography tokens. SwiftUI's Font maps to fontSize + fontWeight.
class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal; // Kotlin's FontWeight.Normal
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// Shape tokens. Kotlin's Dp directly maps to a number (vp) for corner radius.
class AppTokensShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 14;
  static readonly largeCornerRadius: number = 22;
}

// Spacing tokens. Kotlin's Dp directly maps to a number (vp) for spacing.
class AppTokensSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// Shadow spec, corresponding to Compose's shadow parameters.
interface ShadowSpec {
  elevation: number; // Corresponds to Compose's Dp
  radius: number;    // Corresponds to Compose's Dp for blur radius
  dy: number;        // Corresponds to Compose's Dp for y-offset
  opacity: number;   // Corresponds to Compose's Float
}

// Elevation mapping. Shadow parameters are directly mapped.
class AppTokensElevationMapping {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.1 };
  static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.15 };
  static readonly level3: ShadowSpec = { elevation: 10, radius: 12, dy: 6, opacity: 0.18 };
}

// MARK: - RootScreen (Translation of Kotlin RootScreen Composable)
// The SwiftUI @main App entry point is represented by @Entry.

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];
  // Standard Material Design BottomAppBar height
  private bottomBarHeight: number = 56;
  // Standard Material Design FloatingActionButton size
  private fabSize: number = 56;
  // Fixed drawing area for the metro line, mirroring the Canvas size.
  private metroWidth: number = 328;
  private metroHeight: number = 260;
  private metroStep: number = this.metroWidth / (this.stations.length - 1);

  build() {
    Stack() {
      // Main content area, equivalent to Scaffold's content block.
      Column({ space: AppTokensSpacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTokensTypography.displaySize)
          .fontWeight(AppTokensTypography.displayWeight)
          .fontColor(AppTokensColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start) // Equivalent to Modifier.fillMaxWidth() and Alignment.Start

        // Canvas for drawing the metro line and stations (translated to ArkUI shapes).
        Stack() {
          // Metro line: a polyline connecting the six stations, alternating height/4 and 3*height/4.
          Path()
            .width(this.metroWidth)
            .height(this.metroHeight)
            .commands('M 0 65 L 65.6 195 L 131.2 65 L 196.8 195 L 262.4 65 L 328 195')
            .fillOpacity(0)
            .stroke(AppTokensColors.primary) // Horizontal gradient approximated with a solid color
            .strokeWidth(6)

          // Draw the circles for stations (outer radius 16 -> diameter 32, inner radius 6 -> diameter 12).
          ForEach(this.stations, (station: string, index: number) => {
            Stack() {
              Circle({ width: 32, height: 32 }).fill(AppTokensColors.primary) // Outer circle
              Circle({ width: 12, height: 12 }).fill(AppTokensColors.background) // Inner circle
            }
            .position({
              x: index * this.metroStep,
              y: index % 2 === 0 ? this.metroHeight / 4 : this.metroHeight * 3 / 4
            })
          }, (station: string) => station)
        }
        .width('100%')
        .height(260) // Fixed height for the canvas
        .padding(AppTokensSpacing.md) // Inner padding for the drawing content
        .backgroundColor(AppTokensColors.surfaceVariant) // Background color for the canvas area
        .borderRadius(AppTokensShapes.largeCornerRadius) // Rounded corners for the canvas background
        .margin({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg }) // Outer horizontal padding

        // Card for "Next Departures" section.
        Column({ space: AppTokensSpacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(AppTokensColors.secondary)

          ForEach(this.departures, (departure: string) => {
            Row() { // Equivalent to Row in Compose
              Text(departure)
                .fontSize(AppTokensTypography.bodySize)
                .fontWeight(AppTokensTypography.bodyWeight)
                .fontColor(AppTokensColors.onSurface)
              Blank() // Equivalent to Modifier.weight(1f) or Arrangement.SpaceBetween
              Text('On Time')
                .fontSize(AppTokensTypography.labelSize)
                .fontWeight(AppTokensTypography.labelWeight)
                .fontColor(AppTokensColors.success)
            }
            .width('100%')
          }, (departure: string) => departure)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokensSpacing.lg) // Inner padding for the card content
        .backgroundColor(AppTokensColors.surface) // Card background color
        .borderRadius(AppTokensShapes.largeCornerRadius) // Rounded corners for the card
        // Shadow applied based on AppTokens.ElevationMapping.level2
        .shadow({
          radius: AppTokensElevationMapping.level2.radius,
          color: '#262E2E5C', // outline color at level2 opacity (0.15)
          offsetX: 0,
          offsetY: AppTokensElevationMapping.level2.dy
        })
        .margin({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg }) // Outer horizontal padding

        // Spacer to push content up.
        Blank()
      }
      .padding({ top: AppTokensSpacing.lg }) // Top padding for the entire content column
      .padding({ bottom: this.bottomBarHeight }) // Prevent content being obscured by the bottom bar
      .width('100%')
      .height('100%') // Equivalent to Modifier.fillMaxSize()
      // Apply vertical gradient background to the main content area.
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokensColors.background, 0],
          [AppTokensColors.surfaceVariant, 0.5],
          [AppTokensColors.background, 1]
        ]
      })

      // Floating Action Button (FAB)
      Column() {
        Blank() // Pushes the FAB to the bottom
        Row() {
          Blank() // Pushes the FAB to the trailing edge
          Button('+', { type: ButtonType.Circle })
            .width(this.fabSize) // Fixed size for FAB
            .height(this.fabSize)
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(AppTokensColors.onPrimary)
            .backgroundColor(AppTokensColors.primary) // FAB background color
            .onClick(() => {}) // Button action is empty as in Kotlin
        }
        .width('100%')
        .padding({ right: AppTokensSpacing.lg }) // Right padding from screen edge
        .margin({ bottom: this.bottomBarHeight + AppTokensSpacing.lg }) // Bottom padding above the bottom bar
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar
      Column() {
        Blank() // Pushes the bottom bar to the very bottom
        Row() {
          Text('Routes')
            .fontSize(AppTokensTypography.bodySize)
            .fontWeight(AppTokensTypography.bodyWeight)
            .fontColor(AppTokensColors.secondary) // Active item color
          Blank()
          Text('Planner')
            .fontSize(AppTokensTypography.bodySize)
            .fontWeight(AppTokensTypography.bodyWeight)
            .fontColor(AppTokensColors.onSurface)
          Blank()
          Text('Tickets')
            .fontSize(AppTokensTypography.bodySize)
            .fontWeight(AppTokensTypography.bodyWeight)
            .fontColor(AppTokensColors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokensTypography.bodySize)
            .fontWeight(AppTokensTypography.bodyWeight)
            .fontColor(AppTokensColors.onSurface)
        }
        .width('100%') // Equivalent to Modifier.fillMaxWidth()
        .height(this.bottomBarHeight) // Fixed height for the bottom bar
        .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg }) // Horizontal padding
        .backgroundColor(AppTokensColors.surface) // Bottom bar background color
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background) // Overall background color
  }
}
