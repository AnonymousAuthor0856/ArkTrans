class AppColors {
  static primary: string = '#111827';
  static secondary: string = '#374151';
  static tertiary: string = '#6B7280';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#111827';
  static onBackground: string = '#111827';
  static onSurface: string = '#1F2937';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

@Entry
@Component
struct RootScreen {
  @State private selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  @Builder
  private CustomTabRow() {
    Column({ space: 0 }) {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
            .height(48)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.selectedTabIndex = index;
            })
        })
      }
      .width('100%')
      Row() {
        ForEach(this.tabs, (_tab: string, index: number) => {
          Rect()
            .height(2)
            .layoutWeight(1)
            .fill(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
        })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private OverviewPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button('Sync Device')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }

  @Builder
  private RankingPage() {
    Column({ space: AppSpacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Blank()
          Text(`${9000 - index * 500} steps`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
      })
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private StatsPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(20)
            .fill(AppColors.surfaceVariant)
            .radius(8)
          Rect()
            .width(`${Math.min(1, 0.3 + index * 0.1) * 100}%`)
            .height(20)
            .fill(AppColors.primary)
            .radius(8)
        }
        .width('100%')
        .height(20)
      })

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private CurrentPage() {
    if (this.selectedTabIndex === 0) {
      this.OverviewPage()
    } else if (this.selectedTabIndex === 1) {
      this.RankingPage()
    } else {
      this.StatsPage()
    }
  }

  build() {
    Column({ space: 0 }) {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .padding(AppSpacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      this.CustomTabRow()

      this.CurrentPage()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.surfaceVariant)
  }
}
