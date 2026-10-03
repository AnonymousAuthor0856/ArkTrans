const NAME: string = '068*MetroPlanner*en';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#00B4FF';
  static readonly tertiary: string = '#8A2BE2';
  static readonly background: string = '#0A0A1A';
  static readonly surface: string = '#141436';
  static readonly surfaceVariant: string = '#1E1E4A';
  static readonly outline: string = '#2E2E5C';
  static readonly success: string = '#00FFAA';
  static readonly warning: string = '#FFCC00';
  static readonly error: string = '#FF4444';
  static readonly onPrimary: string = '#0A0A1A';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

@Entry
@Component
struct MainActivity {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];
  private navItems: string[] = ['Routes', 'Planner', 'Tickets', 'Profile'];

  @Builder
  RouteDiagram(): void {
    Stack() {
      Row() {
        ForEach(this.stations, (station: string, index: number) => {
          Column() {
            if (index % 2 === 0) {
              this.StationDot(station);
              Blank().layoutWeight(1);
            } else {
              Blank().layoutWeight(1);
              this.StationDot(station);
            }
          }
          .layoutWeight(1)
          .height('100%')
          .alignItems(HorizontalAlign.Center);
        }, (station: string) => station)
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(22);
  }

  @Builder
  StationDot(label: string): void {
    Stack() {
      Circle().width(32).height(32).fill(AppColors.primary);
      Circle().width(12).height(12).fill(AppColors.background);
    }
    .width(32)
    .height(32);
  }

  @Builder
  DeparturesCard(): void {
    Column({ space: AppSpacing.sm }) {
      Text('Next Departures')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary);
      ForEach(this.departures, (departure: string) => {
        Row() {
          Text(departure)
            .fontSize(14)
            .fontColor(AppColors.onSurface);
          Blank();
          Text('On Time')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.success);
        }
        .width('100%');
      }, (departure: string) => departure)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(22)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  BottomBar(): void {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Text(item)
          .fontSize(14)
          .fontColor(item === 'Routes' ? AppColors.secondary : AppColors.onSurface);
      }, (item: string) => item)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary);
        this.RouteDiagram();
        this.DeparturesCard();
        Blank().height(AppSpacing.md);
        Blank().layoutWeight(1);
        this.BottomBar();
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg })
      .backgroundColor(AppColors.background);
      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .width(56)
        .height(56)
        .position({ x: '80%', y: '78%' });
    }
    .width('100%')
    .height('100%');
  }
}
