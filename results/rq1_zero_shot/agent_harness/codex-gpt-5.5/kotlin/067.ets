const NAME: string = "112*ClientDetail*en";
const UI_TYPE: string = "Dashboard";
const STYLE_THEME: string = "Warm Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly tertiary: string = '#FFD54F';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#E0C097';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#3E2723';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xxl: number = 32;
}

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

@Entry
@Component
struct MainActivity {
  @State selectedId: number = -1;

  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 20, 30),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', 50, 45),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 72, 60),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 33, 75)
  ];

  private levelColor(level: string): string {
    if (level === 'A') {
      return AppColors.primary;
    }
    if (level === 'B') {
      return AppColors.secondary;
    }
    return AppColors.tertiary;
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (line: number) => {
        Blank()
          .width('100%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: '0%', y: `${line * 13}%` })
        Blank()
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: `${line * 13}%`, y: '0%' })
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  MapMarker(client: Client) {
    Stack() {
      Circle()
        .width(this.selectedId === client.id ? 28 : 22)
        .height(this.selectedId === client.id ? 28 : 22)
        .fill(this.levelColor(client.level))
        .stroke(this.selectedId === client.id ? AppColors.onPrimary : AppColors.surface)
        .strokeWidth(2)
        .position({ x: `${client.x}%`, y: `${client.y}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === client.id ? -1 : client.id;
        })
      Text(client.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: AppColors.outline })
        .position({ x: `${Math.min(client.x + 9, 68)}%`, y: `${Math.max(client.y - 2, 4)}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === client.id ? -1 : client.id;
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ClientCard(client: Client) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(client.region)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.78)
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
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(68)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Column() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.secondary)
          .linearGradient({
            angle: 90,
            colors: [[AppColors.secondary, 0.0], [AppColors.primary, 1.0]]
          })
          .borderRadius(16)

          Stack() {
            this.MapGridOverlay()
            ForEach(this.clients, (client: Client) => {
              this.MapMarker(client)
            })
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppColors.outline })

          Column({ space: AppSpacing.md }) {
            ForEach(this.clients, (client: Client) => {
              this.ClientCard(client)
            })
            Blank().height(AppSpacing.xxl)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
