@Entry
@Component
struct ClientDetailApp {
  build() {
    RootScreen()
  }
}

// MARK: - AppTokens
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
  } as const;

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  } as const;

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  } as const;

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as const;

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 }
  } as const;
}

// MARK: - Client Data Model
interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

// MARK: - MapMarker Component
@Component
struct MapMarker {
  @Prop label: string = '';
  @Prop level: string = '';
  @Prop selected: boolean = false;
  @Prop xOffset: number = 0;
  @Prop yOffset: number = 0;
  onClick: () => void = () => {};

  private getMarkerColor(): string {
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
        .stroke(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface)
        .strokeWidth(2)
        .translate({ x: this.xOffset, y: this.yOffset })

      // Label Card
      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text(this.label)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.small
          })
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
            offsetY: AppTokens.Elevation.level1.dy
          })
      }
      .onClick(() => {
        this.onClick();
      })
      .translate({ x: this.xOffset + 20, y: this.yOffset - 4 })
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
      ForEach(0, 6, (i: number) => {
        Row()
          .width('100%')
          .height(1)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .translate({
            y: AppTokens.Spacing.lg + (this.getAvailableHeight() / 7.0) * (i + 1)
          })
      }, (i: number) => `h-${i}`)

      // Vertical lines
      ForEach(0, 6, (i: number) => {
        Column()
          .width(1)
          .height('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .translate({
            x: AppTokens.Spacing.lg + (this.getAvailableWidth() / 7.0) * (i + 1)
          })
      }, (i: number) => `v-${i}`)
    }
    .width('100%')
    .height('100%')
  }

  private getAvailableWidth(): number {
    return 360 - 2 * AppTokens.Spacing.lg;
  }

  private getAvailableHeight(): number {
    return 400 - 2 * AppTokens.Spacing.lg;
  }
}

// MARK: - RootScreen Component
@Component
struct RootScreen {
  @State private selectedId: number = -1;
  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  build() {
    Column() {
      // Top Bar
      Column() {
        Text('Client Detail')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Box 1: Regional Client Map header
          Text('Regional Client Map')
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              angle: 90,
              colors: [[AppTokens.Colors.secondary, 0], [AppTokens.Colors.primary, 1]]
            })
            .borderRadius(AppTokens.Shapes.large)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background shape
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({
                width: 1,
                color: AppTokens.Colors.outline,
                radius: AppTokens.Shapes.large
              })

            // Grid overlay
            MapGridOverlay()

            // Map markers
            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                xOffset: 360 * client.x,
                yOffset: 400 * client.y,
                onClick: () => {
                  this.selectedId = (this.selectedId === client.id) ? -1 : client.id;
                }
              })
            }, (client: Client) => `marker-${client.id}`)
          }
          .width('100%')
          .height(400)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Client List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              // Card for each client
              Stack() {
                Column()
                  .width('100%')
                  .height('100%')
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.medium)
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline,
                    radius: AppTokens.Shapes.medium
                  })
                  .shadow({
                    radius: AppTokens.Elevation.level1.radius,
                    color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
                    offsetY: AppTokens.Elevation.level1.dy
                  })

                Row() {
                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(client.name)
                      .fontSize(AppTokens.Typography.title.fontSize)
                      .fontWeight(AppTokens.Typography.title.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(client.region)
                      .fontSize(AppTokens.Typography.body.fontSize)
                      .fontWeight(AppTokens.Typography.body.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Text(`Level ${client.level}`)
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .width('100%')
                .padding(AppTokens.Spacing.lg)
              }
              .width('100%')
            }, (client: Client) => `card-${client.id}`)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.xxl
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