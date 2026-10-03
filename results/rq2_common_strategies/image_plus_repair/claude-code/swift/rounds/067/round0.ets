import { promptAction } from '@kit.ArkUI';

// MARK: - AppTokens
export class AppTokens {
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
    onSurface: '#3E2723',
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };
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
  label: string = '';
  level: string = '';
  selected: boolean = false;
  onClick: () => void = () => {};
  xOffset: number = 0;
  yOffset: number = 0;

  private getMarkerColor(): ResourceColor {
    switch (this.level) {
      case 'A': return AppTokens.Colors.primary;
      case 'B': return AppTokens.Colors.secondary;
      default: return AppTokens.Colors.tertiary;
    }
  }

  private getDotSize(): number {
    return this.selected ? 28 : 22;
  }

  build() {
    Stack() {
      Circle({ width: this.getDotSize(), height: this.getDotSize() })
        .fill(this.getMarkerColor())
        .stroke(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface, 2)
        .position({ x: this.xOffset - this.getDotSize() / 2, y: this.yOffset - this.getDotSize() / 2 })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({
          radius: 4,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 2,
        })
        .position({ x: this.xOffset + 20, y: this.yOffset - 4 })
        .onClick(() => this.onClick())
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - MapGridOverlay Component
@Component
struct MapGridOverlay {
  private readonly lineCount: number = 6;
  private readonly segmentCount: number = 7;

  build() {
    Stack() {
      // Horizontal lines
      ForEach(Array.from({ length: this.lineCount }, (_, i) => i), (item: number) => {
        Rect()
          .fill(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .height(1)
          .position({
            x: 0,
            y: AppTokens.Spacing.lg + ((100 - 2 * AppTokens.Spacing.lg / 1) / this.segmentCount) * (item + 1),
          })
      }, (item: number) => item.toString())

      // Vertical lines
      ForEach(Array.from({ length: this.lineCount }, (_, i) => i), (item: number) => {
        Rect()
          .fill(AppTokens.Colors.surfaceVariant)
          .width(1)
          .height('100%')
          .position({
            x: AppTokens.Spacing.lg + ((100 - 2 * AppTokens.Spacing.lg / 1) / this.segmentCount) * (item + 1),
            y: 0,
          })
      }, (item: number) => 'v' + item.toString())
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Client Card Component
@Component
struct ClientCard {
  client: Client;

  build() {
    Stack() {
      RoundedRect({
        width: '100%',
        height: '100%',
        radius: AppTokens.Shapes.medium,
      })
        .fill(AppTokens.Colors.surface)
        .stroke(AppTokens.Colors.outline, 1)
        .shadow({
          radius: 4,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 2,
        })

      Row() {
        Column() {
          Text(this.client.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.client.region)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('Level ' + this.client.level)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .width('100%')
  }
}

// MARK: - Map Area Component
@Component
struct MapArea {
  clients: Client[] = [];
  selectedId: number = 0;
  onMarkerClick: (id: number) => void = () => {};

  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  build() {
    Stack() {
      // Background shape with border
      RoundedRect({
        width: '100%',
        height: '100%',
        radius: AppTokens.Shapes.large,
      })
        .fill(AppTokens.Colors.surface)
        .stroke(AppTokens.Colors.outline, 1)

      // Grid overlay
      MapGridOverlay()

      // Map markers
      ForEach(this.clients, (client: Client) => {
        MapMarker({
          label: client.name,
          level: client.level,
          selected: this.selectedId === client.id,
          onClick: () => this.onMarkerClick(client.id),
          xOffset: this.mapWidth * client.x,
          yOffset: this.mapHeight * client.y,
        })
      }, (client: Client) => client.id.toString())
    }
    .width('100%')
    .aspectRatio(0.9)
    .onAreaChange((oldArea: Area, newArea: Area) => {
      this.mapWidth = newArea.width as number;
      this.mapHeight = newArea.height as number;
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedId: number = 0;

  private readonly clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
  ];

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Regional Client Map header
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]],
            })
            .borderRadius(AppTokens.Shapes.large)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Map area
          MapArea({
            clients: this.clients,
            selectedId: this.selectedId,
            onMarkerClick: (id: number) => {
              this.selectedId = this.selectedId === id ? 0 : id;
            },
          })
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Client list
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              ClientCard({ client: client })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
