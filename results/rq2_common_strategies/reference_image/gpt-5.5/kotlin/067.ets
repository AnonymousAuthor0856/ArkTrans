interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

class AppColors {
  static readonly primary: string = '#FFFF7043';
  static readonly secondary: string = '#FFFFB74D';
  static readonly tertiary: string = '#FFFFD54F';
  static readonly background: string = '#FFFFF8E1';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFFFECB3';
  static readonly outline: string = '#FFE0C097';
  static readonly success: string = '#FF43A047';
  static readonly warning: string = '#FFFBC02D';
  static readonly error: string = '#FFE53935';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF3E2723';
  static readonly onTertiary: string = '#FF3E2723';
  static readonly onBackground: string = '#FF3E2723';
  static readonly onSurface: string = '#FF3E2723';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct Index {
  @State private selectedId: number = -1;
  @State private mapWidth: number = 328;
  @State private mapHeight: number = 364;

  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  private markerColor(level: string): string {
    if (level === 'A') {
      return AppColors.primary;
    }
    if (level === 'B') {
      return AppColors.secondary;
    }
    return AppColors.tertiary;
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
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(200)
          .borderRadius(16)
          .linearGradient({
            angle: 90,
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
          .height(364)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: 16
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.mapWidth = Number(newValue.width);
            this.mapHeight = Number(newValue.height);
          })

          ForEach(this.clients, (client: Client) => {
            this.ClientCard(client)
          }, (client: Client) => `card-${client.id}`)
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.xxl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
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
        }, (item: number) => `v-${item}`)
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
    Blank()
      .width(this.selectedId === client.id ? 28 : 22)
      .height(this.selectedId === client.id ? 28 : 22)
      .backgroundColor(this.markerColor(client.level))
      .borderRadius(this.selectedId === client.id ? 14 : 11)
      .border({
        width: 2,
        color: this.selectedId === client.id ? AppColors.onPrimary : AppColors.surface,
        radius: this.selectedId === client.id ? 14 : 11
      })
      .position({
        x: this.mapWidth * client.x,
        y: this.mapHeight * client.y
      })
      .onClick(() => {
        this.selectedId = this.selectedId === client.id ? -1 : client.id;
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
      .borderRadius(8)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: 8
      })
      .shadow({
        radius: 4,
        color: '#26000000',
        offsetX: 0,
        offsetY: 2
      })
      .position({
        x: this.mapWidth * client.x + 20,
        y: this.mapHeight * client.y - 4
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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(`Level ${client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: 12
    })
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}