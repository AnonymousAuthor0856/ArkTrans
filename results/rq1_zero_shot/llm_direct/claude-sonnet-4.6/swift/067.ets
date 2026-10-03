import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
    onSurface: '#3E2723',
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
  Shape: {
    small: 8,
    medium: 12,
    large: 16,
  },
  Elevation: {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
  },
};

// MARK: - Client Data Model
interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

const clients: Client[] = [
  { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
  { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
  { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
  { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
];

// MARK: - MapMarker Component
@Component
struct MapMarker {
  label: string = '';
  level: string = '';
  selected: boolean = false;
  onClick: () => void = () => {};
  xOffset: number = 0;
  yOffset: number = 0;

  getMarkerColor(): string {
    switch (this.level) {
      case 'A':
        return AppTokens.Colors.primary;
      case 'B':
        return AppTokens.Colors.secondary;
      default:
        return AppTokens.Colors.tertiary;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker Dot
      Circle()
        .fill(this.getMarkerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface,
          radius: 999,
        })
        .position({ x: this.xOffset, y: this.yOffset })

      // Label Card
      Text(this.label)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs,
        })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shape.small)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: AppTokens.Shape.small,
        })
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
          offsetY: AppTokens.Elevation.level1.dy,
        })
        .position({ x: this.xOffset + 20, y: this.yOffset - 4 })
        .onClick(() => {
          this.onClick();
        })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - MapGridOverlay Component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .strokeWidth(1)
          .color(AppTokens.Colors.surfaceVariant)
          .vertical(false)
          .position({
            x: 0,
            y: AppTokens.Spacing.lg + ((360 - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1),
          })
      })
      // Vertical lines
      ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
        Divider()
          .strokeWidth(1)
          .color(AppTokens.Colors.surfaceVariant)
          .vertical(true)
          .position({
            x: AppTokens.Spacing.lg + ((360 - 2 * AppTokens.Spacing.lg) / 7.0) * (i + 1),
            y: 0,
          })
      })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedId: number | null = null;

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Stack() {
        Text('Client Detail')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Regional Client Map Header
          Text('Regional Client Map')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              angle: 90,
              colors: [
                [AppTokens.Colors.secondary, 0.0],
                [AppTokens.Colors.primary, 1.0],
              ],
            })
            .borderRadius(AppTokens.Shape.large)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ top: AppTokens.Spacing.md })

          // Map Area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shape.large)
              .border({
                width: 1,
                color: AppTokens.Colors.outline,
                radius: AppTokens.Shape.large,
              })

            // Grid Overlay
            MapGridOverlay()
              .width('100%')
              .height('100%')

            // Map Markers
            ForEach(clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onClick: () => {
                  this.selectedId = this.selectedId === client.id ? null : client.id;
                },
                xOffset: 360 * client.x,
                yOffset: 360 * client.y,
              })
            })
          }
          .width('100%')
          .height(360)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Client List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(clients, (client: Client) => {
              Stack() {
                // Card Background
                Column()
                  .width('100%')
                  .height('100%')
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shape.medium)
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline,
                    radius: AppTokens.Shape.medium,
                  })
                  .shadow({
                    radius: AppTokens.Elevation.level1.radius,
                    color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
                    offsetY: AppTokens.Elevation.level1.dy,
                  })

                // Card Content
                Row() {
                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(client.name)
                      .fontSize(AppTokens.Typography.title.size)
                      .fontWeight(AppTokens.Typography.title.weight)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(client.region)
                      .fontSize(AppTokens.Typography.body.size)
                      .fontWeight(AppTokens.Typography.body.weight)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Text(`Level ${client.level}`)
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .width('100%')
                .padding(AppTokens.Spacing.lg)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
            })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.xxl,
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}