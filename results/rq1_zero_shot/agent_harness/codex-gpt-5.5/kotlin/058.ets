const NAME: string = "087_StepChallenge_en";
const UI_TYPE: string = "Health ControlPanel";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111827';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

@Entry
@Component
struct MainActivity {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  @Builder
  TabRowView() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        Column() {
          Text(title)
            .fontSize(14)
            .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
            .fontWeight(this.selectedTab === index ? FontWeight.SemiBold : FontWeight.Normal)
            .textAlign(TextAlign.Center)
            .width('100%')
          Rect()
            .width(this.selectedTab === index ? 46 : 0)
            .height(3)
            .fill(AppColors.primary)
            .radius(2)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .height(50)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedTab = index;
        })
      })
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  OverviewPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
      Blank().height(AppSpacing.lg)
      Button('Sync Device')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RankingPage() {
    Column({ space: AppSpacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          Text(`User ${item + 1}`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Text(`${9000 - item * 500} steps`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width('100%')
            .height(20)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(8)
          Blank()
            .width(`${Math.min(100, Math.round((0.3 + item * 0.1) * 100))}%`)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(20)
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)

      this.TabRowView()

      Scroll() {
        Column() {
          if (this.selectedTab === 0) {
            this.OverviewPage()
          } else if (this.selectedTab === 1) {
            this.RankingPage()
          } else {
            this.StatsPage()
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
    })
  }
}
