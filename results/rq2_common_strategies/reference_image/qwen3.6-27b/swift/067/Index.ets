// App.ets
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// This struct defines the design tokens for the application, making it easy to modify styles globally.
class AppTokens {
  // Colors used throughout the application.
  static readonly Colors = {
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
  };

  // Typography styles for different text elements.
  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  // Shapes with predefined corner radii.
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  // Standardized spacing values.
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  // Shadow specifications for elevation effects.
  static readonly ElevationMapping = {
    level1: { blurRadius: 4, dy: 2, opacity: 0.1 },
    level2: { blurRadius: 8, dy: 4, opacity: 0.14 },
    level3: { blurRadius: 12, dy: 6, opacity: 0.16 }
  };
}

// MARK: - Client Data Model
// Represents a client with various details and map coordinates.
interface Client {
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
  onClick: () => void;
  xOffset: number; // Base X offset from the container's top-leading corner
  yOffset: number; // Base Y offset from the container's top-leading corner

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      let markerColor: string;
      if (this.level === 'A') {
        markerColor = AppTokens.Colors.primary;
      } else if (this.level === 'B') {
        markerColor = AppTokens.Colors.secondary;
      } else {
        markerColor = AppTokens.Colors.tertiary;
      }

      // Marker Dot
      Circle()
        .fill(markerColor)
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface
        })
        .position({ x: this.xOffset, y: this.yOffset });

      // Label Card
      Button({ type: ButtonType.Normal }) {
        Text(this.label)
          .font-size(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({
            radius: AppTokens.ElevationMapping.level1.blurRadius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
      }
      .onClick(() => {
        this.onClick();
      })
      .buttonStyle(ButtonStyle.None)
      .position({ x: this.xOffset + 20, y: this.yOffset - 4 });
    }
  }
}

// A custom view to draw a grid overlay on the map.
@Component
struct MapGridOverlayCorrected {
  build() {
    Grid() {
      ForEach(Array.from({ length: 6 }).map((_, i) => i), (i: number) => {
        GridRow() {
          ForEach(Array.from({ length: 7 }).map((_, j) => j), (j: number) => {
            GridCol() {
              Blank()
            }
            .gridColumnSpan(1)
          })
        }
        .gridRowSpan(1)
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
    .borderWidth(0)
    .itemBorder({ strokeWidth: 1, color: AppTokens.Colors.surfaceVariant })
  }
}

// MARK: - RootScreen
// The main content view of the application.
@Entry
@Component
struct RootScreen {
  @State private selectedId: number | null = null; // State to track the selected client marker.

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
      Row() {
        Text("Client Detail")
          .font-size(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Scrollable content area
      Scroll() {
        Column() {
          // Box 1: Regional Client Map header
          Text("Regional Client Map")
            .font-size(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(200)
            .linearGradient({
              angle: 0,
              colors: [
                [AppTokens.Colors.secondary, 0],
                [AppTokens.Colors.primary, 1]
              ]
            })
            .borderRadius(AppTokens.Shapes.large)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ top: AppTokens.Spacing.md });

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background shape
            Rect()
              .width('100%')
              .height('100%')
              .fill(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: AppTokens.Colors.outline });

            // Grid overlay
            MapGridOverlayCorrected()
              .width('100%')
              .height('100%');

            // Iterate through clients to place MapMarkers
            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onClick: () => {
                  this.selectedId = (this.selectedId === client.id) ? null : client.id;
                },
                xOffset: client.x * 100,
                yOffset: client.y * 100
              })
            })
          }
          .width('100%')
          .aspectRatio(0.9)
          .minHeight(360)
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

          // Client List
          Column() {
            ForEach(this.clients, (client: Client) => {
              // Card for each client
              Stack() {
                Rect()
                  .width('100%')
                  .height('100%')
                  .fill(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.medium)
                  .shadow({
                    radius: AppTokens.ElevationMapping.level1.blurRadius,
                    color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
                    offsetX: 0,
                    offsetY: AppTokens.ElevationMapping.level1.dy
                  })
                  .border({ width: 1, color: AppTokens.Colors.outline });

                Row() {
                  Column() {
                    Text(client.name)
                      .font-size(AppTokens.TypographyTokens.title.size)
                      .fontWeight(AppTokens.TypographyTokens.title.weight)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(client.region)
                      .font-size(AppTokens.TypographyTokens.body.size)
                      .fontWeight(AppTokens.TypographyTokens.body.weight)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .marginRight('auto')

                  Text(`Level ${client.level}`)
                    .font-size(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .padding(AppTokens.Spacing.lg)
              }
              .width('100%')
              .marginBottom(AppTokens.Spacing.md)
            })
          }
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .marginBottom(AppTokens.Spacing.xxl);
        }
      }
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .statusBarConfig({ mode: StatusBarMode.Custom, color: AppTokens.Colors.background })
  }
}