const NAME: string = '112*ClientDetail*en';
const UI_TYPE: string = 'Dashboard';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

class AppColors {
  static readonly primary: ResourceColor = '#FF7043';
  static readonly secondary: ResourceColor = '#FFB74D';
  static readonly tertiary: ResourceColor = '#FFD54F';
  static readonly background: ResourceColor = '#FFF8E1';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFECB3';
  static readonly outline: ResourceColor = '#E0C097';
  static readonly success: ResourceColor = '#43A047';
  static readonly warning: ResourceColor = '#FBC02D';
  static readonly error: ResourceColor = '#E53935';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#3E2723';
  static readonly onTertiary: ResourceColor = '#3E2723';
  static readonly onBackground: ResourceColor = '#3E2723';
  static readonly onSurface: ResourceColor = '#3E2723';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppElevation {
  static readonly level1 = {
    radius: 4,
    offsetY: 2,
    color: '#1A000000'
  };
  static readonly level2 = {
    radius: 8,
    offsetY: 4,
    color: '#24000000'
  };
  static readonly level3 = {
    radius: 12,
    offsetY: 6,
    color: '#29000000'
  };
}

@Entry
@Component
struct ClientDetailPage {
  @State private selectedId: number = -1;

  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  private levelColor(level: string): ResourceColor {
    if (level === 'A') {
      return AppColors.primary;
    }
    if (level === 'B') {
      return AppColors.secondary;
    }
    return AppColors.tertiary;
  }

  private markerSize(client: Client): number {
    return this.selectedId === client.id ? 28 : 22;
  }

  @Builder
  private MapGridOverlay() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .width('100%')
            .height(1)
            .backgroundColor(AppColors.surfaceVariant)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .width(1)
            .height('100%')
            .backgroundColor(AppColors.surfaceVariant)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  private MapMarker(client: Client) {
    Stack({ alignContent: Alignment.TopStart }) {
      Blank()
        .width(this.markerSize(client))
        .height(this.markerSize(client))
        .backgroundColor(this.levelColor(client.level))
        .borderRadius(this.markerSize(client) / 2)
        .border({
          width: 2,
          color: this.selectedId === client.id ? AppColors.onPrimary : AppColors.surface
        })

      Text(client.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .shadow({
          radius: AppElevation.level1.radius,
          color: AppElevation.level1.color,
          offsetY: AppElevation.level1.offsetY
        })
        .position({ x: 20, y: -4 })
    }
    .width(180)
    .height(44)
    .position({
      x: `${client.x * 100}%`,
      y: `${client.y * 100}%`
    })
    .onClick(() => {
      this.selectedId = this.selectedId === client.id ? -1 : client.id;
    })
  }

  @Builder
  private ClientCard(client: Client) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(client.region)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }

      Blank()
        .layoutWeight(1)

      Text(`Level ${client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: AppElevation.level1.radius,
      color: AppElevation.level1.color,
      offsetY: AppElevation.level1.offsetY
    })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(200)
          .borderRadius(AppRadius.large)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [
              [AppColors.secondary, 0.0],
              [AppColors.primary, 1.0]
            ]
          })

          Stack({ alignContent: Alignment.TopStart }) {
            this.MapGridOverlay()

            ForEach(this.clients, (client: Client) => {
              this.MapMarker(client)
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .height(400)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppRadius.large)
          .border({
            width: 1,
            color: AppColors.outline
          })
          .clip(true)

          Column({ space: AppSpacing.md }) {
            ForEach(this.clients, (client: Client) => {
              this.ClientCard(client)
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppSpacing.xxl })
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}