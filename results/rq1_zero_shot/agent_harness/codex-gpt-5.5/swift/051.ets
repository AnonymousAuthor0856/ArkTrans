class AppColors {
  static primary: string = '#00FFFF';
  static secondary: string = '#00B4FF';
  static tertiary: string = '#8A2BE2';
  static background: string = '#0A0A1A';
  static surface: string = '#141436';
  static surfaceVariant: string = '#1E1E4A';
  static outline: string = '#2E2E5C';
  static success: string = '#00FFAA';
  static warning: string = '#FFCC00';
  static error: string = '#FF4444';
  static onPrimary: string = '#0A0A1A';
  static onSecondary: string = '#FFFFFF';
  static onBackground: string = '#FFFFFF';
  static onSurface: string = '#FFFFFF';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];
  private bottomBarHeight: number = 56;
  private fabSize: number = 56;

  @Builder
  private StationNode(label: string, left: string, top: string) {
    Column({ space: 4 }) {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(AppColors.primary)
        Circle()
          .width(12)
          .height(12)
          .fill(AppColors.background)
      }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .position({ x: left, y: top })
  }

  @Builder
  private MetroMap() {
    Stack() {
      Polyline()
        .width('100%')
        .height('100%')
        .points([[14, 65], [84, 195], [154, 65], [224, 195], [294, 65], [364, 195]])
        .fill(Color.Transparent)
        .stroke(AppColors.secondary)
        .strokeWidth(6)
        .lineCap(LineCapStyle.Round)
        .lineJoin(LineJoinStyle.Round)
      this.StationNode('A', '4%', '18%')
      this.StationNode('B', '22%', '68%')
      this.StationNode('C', '40%', '18%')
      this.StationNode('D', '58%', '68%')
      this.StationNode('E', '76%', '18%')
      this.StationNode('F', '91%', '68%')
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(22)
  }

  @Builder
  private DeparturesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Next Departures')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .width('100%')

      ForEach(this.departures, (departure: string) => {
        Row() {
          Text(departure)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Blank()
          Text('On Time')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.success)
        }
        .width('100%')
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(22)
    .shadow({ radius: 8, color: '#2E2E5C26', offsetX: 0, offsetY: 4 })
  }

  @Builder
  private FloatingButton() {
    Button('+')
      .width(this.fabSize)
      .height(this.fabSize)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onPrimary)
      .backgroundColor(AppColors.primary)
      .borderRadius(this.fabSize / 2)
  }

  @Builder
  private BottomBar() {
    Row() {
      Text('Routes')
        .fontSize(14)
        .fontColor(AppColors.secondary)
      Blank()
      Text('Planner')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Tickets')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .width('100%')
    .height(this.bottomBarHeight)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        this.MetroMap()
          .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

        this.DeparturesCard()
          .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

        Blank()
          .height(AppSpacing.md)
      }
      .padding({ top: AppSpacing.lg, bottom: this.bottomBarHeight })
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()
        Row() {
          Blank()
          this.FloatingButton()
            .margin({ right: AppSpacing.lg, bottom: this.bottomBarHeight + AppSpacing.lg })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
