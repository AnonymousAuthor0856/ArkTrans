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
    onSurface: '#3E2723'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Shadow: {
    level1: { radius: 4, dy: 2, color: '#1A000000' }
  }
};

const colorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error
};

const typography = {
  displayLarge: AppTokens.Typography.display,
  headlineMedium: AppTokens.Typography.headline,
  titleMedium: AppTokens.Typography.title,
  bodyMedium: AppTokens.Typography.body,
  labelMedium: AppTokens.Typography.label
};

// MARK: - Data Models
class Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.region = region;
    this.level = level;
    this.x = x;
    this.y = y;
  }
}

// MARK: - MapMarker
@Component
struct MapMarker {
  @Prop label: string = '';
  @Prop level: string = '';
  @Prop selected: boolean = false;
  onClick: () => void = () => {};

  private markerColor(): string {
    if (this.level === 'A') return AppTokens.Colors.primary;
    if (this.level === 'B') return AppTokens.Colors.secondary;
    return AppTokens.Colors.tertiary;
  }

  build() {
    Row({ space: 4 }) {
      Row()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface })

      Button() {
        Text(this.label)
          .fontSize(typography.labelMedium.size)
          .fontWeight(typography.labelMedium.weight)
          .fontColor(colorScheme.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(colorScheme.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: colorScheme.outline })
          .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
      }
      .onClick(() => {
        this.onClick();
      })
    }
    .margin({ top: -4 })
  }
}

// MARK: - MapGridOverlay
@Component
struct MapGridOverlay {
  private lines: number[] = [1, 2, 3, 4, 5, 6];

  build() {
    Stack() {
      Column() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(colorScheme.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(colorScheme.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State selectedId: number | null = null;

  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75)
  ];

  build() {
    Column({ space: 0 }) {
      // 顶部栏
      Stack() {
        Text('Client Detail')
          .fontSize(typography.displayLarge.size)
          .fontWeight(typography.displayLarge.weight)
          .fontColor(colorScheme.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(colorScheme.background)

      // 可滚动内容区域
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // 区域标题渐变盒子
          Stack() {
            Text('Regional Client Map')
              .fontSize(typography.headlineMedium.size)
              .fontWeight(typography.headlineMedium.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(200)
          .linearGradient({
            angle: 90,
            colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]]
          })
          .borderRadius(AppTokens.Shapes.large)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // 地图区域
          Stack({ alignContent: Alignment.TopStart }) {
            Row()
              .width('100%')
              .height('100%')
              .backgroundColor(colorScheme.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: colorScheme.outline })

            MapGridOverlay()

            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onClick: () => {
                  this.selectedId = this.selectedId === client.id ? null : client.id;
                }
              })
              .position({ x: (client.x * 100).toString() + '%', y: (client.y * 100).toString() + '%' })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .height(360)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // 客户列表
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              Row() {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text(client.name)
                    .fontSize(typography.titleMedium.size)
                    .fontWeight(typography.titleMedium.weight)
                    .fontColor(colorScheme.onSurface)
                  Text(client.region)
                    .fontSize(typography.bodyMedium.size)
                    .fontWeight(typography.bodyMedium.weight)
                    .fontColor(colorScheme.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text('Level ' + client.level)
                  .fontSize(typography.labelMedium.size)
                  .fontWeight(typography.labelMedium.weight)
                  .fontColor(colorScheme.primary)
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(colorScheme.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: colorScheme.outline })
              .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
            }, (client: Client) => client.id.toString())
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor(colorScheme.background)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorScheme.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ClientDetailApp
@Entry
@Component
struct ClientDetailApp {
  build() {
    RootScreen()
  }
}
