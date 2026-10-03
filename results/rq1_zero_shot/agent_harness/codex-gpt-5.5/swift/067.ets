class AppColors {
  static primary: string = '#FF7043';
  static secondary: string = '#FFB74D';
  static tertiary: string = '#FFD54F';
  static background: string = '#FFF8E1';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFECB3';
  static outline: string = '#E0C097';
  static success: string = '#43A047';
  static warning: string = '#FBC02D';
  static error: string = '#E53935';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#3E2723';
  static onTertiary: string = '#3E2723';
  static onBackground: string = '#3E2723';
  static onSurface: string = '#3E2723';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: string;
  y: string;

  constructor(id: number, name: string, region: string, level: string, x: string, y: string) {
    this.id = id;
    this.name = name;
    this.region = region;
    this.level = level;
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State private selectedId: number = -1;
  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', '20%', '30%'),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', '50%', '45%'),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', '72%', '60%'),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', '33%', '75%')
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

  @Builder
  private MapGridOverlay() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank()
          Divider().height(1).color(AppColors.surfaceVariant)
        })
        Blank()
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank()
          Divider().vertical(true).width(1).color(AppColors.surfaceVariant)
        })
        Blank()
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
    }
  }

  @Builder
  private MapMarker(client: Client) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selectedId === client.id ? 28 : 22)
        .height(this.selectedId === client.id ? 28 : 22)
        .fill(this.markerColor(client.level))
        .stroke(this.selectedId === client.id ? AppColors.onPrimary : AppColors.surface)
        .strokeWidth(2)
      Text(client.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: AppColors.outline })
        .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })
        .position({ x: 88, y: 8 })
    }
    .width(180)
    .height(42)
    .position({ x: client.x, y: client.y })
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
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Text(`Level ${client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private MapArea() {
    Stack({ alignContent: Alignment.TopStart }) {
      Rect()
        .width('100%')
        .height('100%')
        .fill(AppColors.surface)
        .stroke(AppColors.outline)
        .strokeWidth(1)
        .radius(16)
      this.MapGridOverlay()
      ForEach(this.clients, (client: Client) => {
        this.MapMarker(client)
      })
    }
    .width('100%')
    .height(360)
    .borderRadius(16)
  }

  build() {
    Column({ space: 0 }) {
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .height(56)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppColors.secondary)
            .borderRadius(16)
            .margin({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })

          this.MapArea()
            .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

          Column({ space: AppSpacing.md }) {
            ForEach(this.clients, (client: Client) => {
              this.ClientCard(client)
            })
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.xxl })
          .width('100%')
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
