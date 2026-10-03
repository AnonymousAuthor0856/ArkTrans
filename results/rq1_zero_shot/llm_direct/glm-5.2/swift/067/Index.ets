// AppTokens: Design tokens for the application
class AppTokens {
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

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly Elevation = {
    level1: { blur: 4, dy: 2, opacity: 0.1 },
    level2: { blur: 8, dy: 4, opacity: 0.14 },
    level3: { blur: 12, dy: 6, opacity: 0.16 }
  };
}

// Client Data Model
interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

// MapMarker Component
@Component
struct MapMarker {
  @Prop label: string;
  @Prop level: string;
  @Prop selected: boolean;
  onClick: () => void = () => {};
  xOffset: number = 0;
  yOffset: number = 0;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker Dot
      Circle({ width: this.selected ? 28 : 22, height: this.selected ? 28 : 22 })
        .fill(this.level === 'A' ? AppTokens.Colors.primary : (this.level === 'B' ? AppTokens.Colors.secondary : AppTokens.Colors.tertiary))
        .stroke(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface)
        .strokeWidth(2)
        .position({ x: this.xOffset, y: this.yOffset })

      // Label Card
      Button({ type: ButtonType.Normal, action: this.onClick }) {
        Text(this.label)
          .fontSize(AppTokens.Typography.label.size)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
          .shadow({ radius: AppTokens.Elevation.level1.blur, color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`, offsetY: AppTokens.Elevation.level1.dy })
      }
      .position({ x: this.xOffset + 20, y: this.yOffset - 4 })
    }
    .width('100%')
    .height('100%')
  }
}

// MapGridOverlay Component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .color(AppTokens.Colors.surfaceVariant)
          .height(1)
          .width('100%')
          .position({ x: 0, y: AppTokens.Spacing.lg + ((100 - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1) }) // Simplified relative logic
      })

      // Vertical lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .vertical(true)
          .color(AppTokens.Colors.surfaceVariant)
          .width(1)
          .height('100%')
          .position({ x: AppTokens.Spacing.lg + ((100 - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1), y: 0 }) // Simplified relative logic
      })
    }
    .width('100%')
    .height('100%')
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State selectedId: number | null = null;

  clients: Client[] = [
    { id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3 },
    { id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45 },
    { id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6 },
    { id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75 }
  ];

  build() {
    Column() {
      // Top Bar
      Text("Client Detail")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .height(56)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Regional Client Map Header
          Text("Regional Client Map")
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
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

          // Map Area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
              .borderRadius(AppTokens.Shapes.large)

            // Grid Overlay
            MapGridOverlay()

            // Markers
            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onClick: () => {
                  this.selectedId = this.selectedId === client.id ? null : client.id;
                },
                xOffset: 300 * client.x, // Assuming a base width for relative positioning in ArkTS without GeometryReader
                yOffset: 360 * client.y  // Assuming a base height
              })
            })
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Client List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              // Client Card
              Row() {
                Column() {
                  Text(client.name)
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(client.region)
                    .fontSize(AppTokens.Typography.body.size)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xs })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text(`Level ${client.level}`)
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
              .shadow({ radius: AppTokens.Elevation.level1.blur, color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`, offsetY: AppTokens.Elevation.level1.dy })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}