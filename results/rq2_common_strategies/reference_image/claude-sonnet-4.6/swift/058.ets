// StepChallenge.ets
// ArkTS 版 "Step Challenge"，与 SwiftUI 版本一一对应。

// MARK: - AppTokens ---------------------------------------------------------

export class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
  static readonly transparent: string = '#00000000';
}

export class AppTypography {
  // Compose 的 TextStyle 在 ArkTS 中拆分为 fontSize / fontWeight 两个令牌
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;

  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Bold;

  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;

  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;

  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

export class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

export class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// MARK: - RootScreen --------------------------------------------------------

const TABS: string[] = ['Overview', 'Ranking', 'Stats'];

@Entry
@Component
struct StepChallengeApp {
  @State selectedTabIndex: number = 0;
  private controller: TabsController = new TabsController();

  // MARK: 自定义 TabRow（带下划线指示器）
  @Builder
  TabRow() {
    Row() {
      ForEach(TABS, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(this.selectedTabIndex === index
              ? AppColors.primary
              : AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ top: AppSpacing.md, bottom: AppSpacing.md })

          // 下划线指示器：宽度 = 单个 Tab 宽度，高度 2vp
          Row()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTabIndex === index
              ? AppColors.primary
              : AppColors.transparent)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedTabIndex = index;
          this.controller.changeIndex(index);
        })
      }, (tab: string) => tab)
    }
    .width('100%')
  }

  // MARK: OverviewPage
  @Builder
  OverviewPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)

      // 对应 Spacer(modifier = Modifier.height(AppSpacing.lg))
      Row().width('100%').height(AppSpacing.lg)

      Button('Sync Device')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)

      Blank()
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.lg)
  }

  // MARK: RankingPage
  @Builder
  RankingPage() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.rankIndexes, (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)

          Blank()

          Text(`${9000 - it * 500} steps`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
      }, (it: number) => it.toString())
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(AppSpacing.lg)
  }

  // MARK: StatsPage
  @Builder
  StatsPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach(this.weekIndexes, (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          // 背景条
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          // 进度条：0.3 + it * 0.1，上限 1.0
          Row()
            .width(`${Math.min(30 + it * 10, 100)}%`)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(20)
      }, (it: number) => it.toString())

      Blank()
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(AppSpacing.lg)
  }

  private rankIndexes: number[] = [0, 1, 2, 3, 4];
  private weekIndexes: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column() {
      // 顶部标题，对应 Kotlin 中的 Box + fillMaxWidth + Alignment.Center
      Text('Step Challenge')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding(AppSpacing.lg)

      // 自定义 TabRow
      this.TabRow()

      // HorizontalPager -> Tabs（隐藏系统 bar，使用自绘 TabRow）
      Tabs({
        barPosition: BarPosition.Start,
        index: this.selectedTabIndex,
        controller: this.controller
      }) {
        TabContent() {
          this.OverviewPage()
        }

        TabContent() {
          this.RankingPage()
        }

        TabContent() {
          this.StatsPage()
        }
      }
      .barHeight(0)
      .scrollable(true)
      .animationDuration(200)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    // Brush.verticalGradient 的 ArkTS 对应写法
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.surface, 1.0]
      ]
    })
  }
}