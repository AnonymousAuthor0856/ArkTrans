// Index.ets

// MARK: - AppTokens
// This struct defines the design tokens for the application, making it easy to modify styles globally.
export class AppTokens {
  // Colors used throughout the application.
  static Colors: AppColorScheme = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    tertiary: '#FFD54F',
    background: '#FFF8E1',
    surface: '#FFFFFF',
    surfaceVariant: '#FFECB3',
    outline: '#E0C097',
    success: '#43A047',
    warning: '#FBC02D',
    error: '#E53935',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onTertiary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  }

  // Typography styles for different text elements.
  static TypographyTokens: AppTypography = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium },
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Normal },
    labelMedium: { size: 12, weight: FontWeight.Medium }
  }

  // Shapes with predefined corner radii.
  static Shapes: AppShapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  // Standardized spacing values.
  static Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  // Shadow specifications for elevation effects.
  static ElevationMapping: AppElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 }
  }
}

// Defines the application's color scheme.
export interface AppColorScheme {
  primary: ResourceColor;
  onPrimary: ResourceColor;
  secondary: ResourceColor;
  onSecondary: ResourceColor;
  tertiary: ResourceColor;
  onTertiary: ResourceColor;
  background: ResourceColor;
  onBackground: ResourceColor;
  surface: ResourceColor;
  onSurface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  error: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
}

// Defines the application's typography.
export interface AppTypography {
  displayLarge: AppFont;
  headlineMedium: AppFont;
  titleMedium: AppFont;
  bodyMedium: AppFont;
  labelMedium: AppFont;
}

export interface AppFont {
  size: number | string;
  weight: FontWeight;
}

export interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

export interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export interface AppShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

export interface AppElevationMapping {
  level1: AppShadowSpec;
  level2: AppShadowSpec;
  level3: AppShadowSpec;
}

// Default Theme values
export const defaultColorScheme: AppColorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  tertiary: AppTokens.Colors.tertiary,
  onTertiary: AppTokens.Colors.onTertiary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error,
  success: AppTokens.Colors.success,
  warning: AppTokens.Colors.warning
};

export const defaultTypography: AppTypography = {
  displayLarge: AppTokens.TypographyTokens.displayLarge,
  headlineMedium: AppTokens.TypographyTokens.headlineMedium,
  titleMedium: AppTokens.TypographyTokens.titleMedium,
  bodyMedium: AppTokens.TypographyTokens.bodyMedium,
  labelMedium: AppTokens.TypographyTokens.labelMedium
};

// Represents a client with various details and map coordinates.
export interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number; // Relative X position (0.0 to 1.0)
  y: number; // Relative Y position (0.0 to 1.0)
}

// MARK: - Custom Views

// A custom view for displaying a map marker with a label.
@Component
struct MapMarker {
  @Prop label: string;
  @Prop level: string;
  @Prop selected: boolean;
  onMarkerClick: () => void = () => {};
  xOffset: number = 0;
  yOffset: number = 0;
  @Prop colorScheme: AppColorScheme;
  @Prop typography: AppTypography;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker Dot
      Circle({ width: this.selected ? 28 : 22, height: this.selected ? 28 : 22 })
        .fill(this.level === 'A' ? AppTokens.Colors.primary : this.level === 'B' ? AppTokens.Colors.secondary : AppTokens.Colors.tertiary)
        .stroke(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface)
        .strokeWidth(2)
        .markAnchor(0, 0)
        .position({ x: this.xOffset, y: this.yOffset })

      // Label Card
      Button(this.label, { type: ButtonType.Normal })
        .fontSize(this.typography.labelMedium.size)
        .fontWeight(this.typography.labelMedium.weight)
        .fontColor(this.colorScheme.onSurface as string)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(this.colorScheme.surfaceVariant as string)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: this.colorScheme.outline as string })
        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
        .onClick(() => this.onMarkerClick())
        .markAnchor(0, 0)
        .position({ x: this.xOffset + 20, y: this.yOffset - 4 })
    }
    .width('100%')
    .height('100%')
  }
}

// A custom view to draw a grid overlay on the map.
@Component
struct MapGridOverlayCorrected {
  @Prop colorScheme: AppColorScheme;

  build() {
    Stack() {
      // Horizontal lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .color(this.colorScheme.surfaceVariant as string)
          .strokeWidth(1)
          .width('100%')
          .markAnchor(0, 0)
          .position({ x: 0, y: AppTokens.Spacing.lg + ((this.getParentWidth() - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1) })
      }, (i: number) => i.toString())

      // Vertical lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .vertical(true)
          .color(this.colorScheme.surfaceVariant as string)
          .strokeWidth(1)
          .height('100%')
          .markAnchor(0, 0)
          .position({ x: AppTokens.Spacing.lg + ((this.getParentWidth() - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1), y: 0 })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
  }

  // Helper to approximate GeometryReader behavior for grid calculations
  getParentWidth(): number {
    return 360; 
  }
}

// The main content view of the application.
@Entry
@Component
struct RootScreen {
  @State selectedId: number | null = null;
  private colorScheme: AppColorScheme = defaultColorScheme;
  private typography: AppTypography = defaultTypography;

  // Sample client data.
  private clients: Client[] = [
    { id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3 },
    { id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45 },
    { id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6 },
    { id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75 }
  ];

  build() {
    Column() {
      // Custom Top Bar
      Stack() {
        Text("Client Detail")
          .fontSize(this.typography.displayLarge.size)
          .fontWeight(this.typography.displayLarge.weight)
          .fontColor(this.colorScheme.onSurface as string)
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.colorScheme.background as string)
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

      // Scrollable content area
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Box 1: Regional Client Map header
          Text("Regional Client Map")
            .fontSize(this.typography.headlineMedium.size)
            .fontWeight(this.typography.headlineMedium.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              angle: 90,
              colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]]
            })
            .borderRadius(AppTokens.Shapes.large)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // BoxWithConstraints: Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background shape
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(this.colorScheme.surface as string)
              .border({ width: 1, color: this.colorScheme.outline as string })
              .borderRadius(AppTokens.Shapes.large)

            // Grid Overlay
            MapGridOverlayCorrected({ colorScheme: this.colorScheme })

            // Markers
            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onMarkerClick: () => {
                  this.selectedId = (this.selectedId === client.id) ? null : client.id;
                },
                xOffset: 360 * client.x, // Using 360 as approx width
                yOffset: 360 * client.y, // Assuming min height 360 for calculation
                colorScheme: this.colorScheme,
                typography: this.typography
              })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // LazyColumn: Client List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              // Card for each client
              Stack() {
                Column()
                  .width('100%')
                  .height('100%')
                  .backgroundColor(this.colorScheme.surface as string)
                  .borderRadius(AppTokens.Shapes.medium)
                  .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
                  .border({ width: 1, color: this.colorScheme.outline as string })

                Row() {
                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(client.name)
                      .fontSize(this.typography.titleMedium.size)
                      .fontWeight(this.typography.titleMedium.weight)
                      .fontColor(this.colorScheme.onSurface as string)
                    Text(client.region)
                      .fontSize(this.typography.bodyMedium.size)
                      .fontWeight(this.typography.bodyMedium.weight)
                      .fontColor(this.colorScheme.onSurface as string)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank() // Pushes "Level" text to the right

                  Text(`Level ${client.level}`)
                    .fontSize(this.typography.labelMedium.size)
                    .fontWeight(this.typography.labelMedium.weight)
                    .fontColor(this.colorScheme.primary as string)
                }
                .width('100%')
                .padding(AppTokens.Spacing.lg)
              }
              .width('100%')
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.colorScheme.background as string)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background as string)
  }
}