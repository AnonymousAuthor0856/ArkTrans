// AppTokens - 应用程序设计令牌常量
class AppColors {
  static readonly primary: string = '#111827'
  static readonly secondary: string = '#374151'
  static readonly tertiary: string = '#6B7280'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#111827'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineSize: number = 20
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 16
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Normal
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

// 自定义标签行组件
@Component
struct CustomTabRow {
  tabs: string[] = []
  @Link selectedTabIndex: number

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button(tab)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
            .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
            .width('100%')
            .height(48)
            .backgroundColor(Color.Transparent)
            .borderRadius(0)
            .onClick(() => {
              this.selectedTabIndex = index
            })
        }, (tab: string, index: number) => tab + index.toString())
      }
      .width('100%')

      // 下划线指示器
      Stack({ alignContent: Alignment.CenterStart }) {
        Row()
          .width('100%')
          .height(2)
          .backgroundColor(Color.Transparent)

        Row()
          .width(100 / this.tabs.length + '%')
          .height(2)
          .backgroundColor(AppColors.primary)
          .translate({ x: this.selectedTabIndex * (100 / this.tabs.length) + '%' })
          .animation({
            duration: 200,
            curve: Curve.EaseInOut
          })
      }
      .width('100%')
      .height(2)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

// 概览页面
@Component
struct OverviewPage {
  @State syncButtonWidth: number = 0

  aboutToAppear() {
    this.syncButtonWidth = 0
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button('Sync Device')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {
          // 处理 Sync Device 按钮点击事件
        })

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

// 排名页面
@Component
struct RankingPage {
  build() {
    Column({ space: AppSpacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          Text('User ' + (it + 1))
            .fontColor(AppColors.onSurface)
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)

          Blank()

          Text((9000 - it * 500) + ' steps')
            .fontColor(AppColors.onSurface)
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)
        }
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .width('100%')
      }, (it: number) => it.toString())
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// 统计页面
@Component
struct StatsPage {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.CenterStart }) {
          // 背景条
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          // 填充部分
          Row()
            .width(Math.min(0.3 + it * 0.1, 1.0) * 100 + '%')
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(20)
      }, (it: number) => it.toString())

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// 主界面 - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private tabController: TabsController = new TabsController()

  build() {
    Column({ space: 0 }) {
      // 顶部标题区域
      Text('Step Challenge')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .padding(AppSpacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // 自定义标签行
      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex
      })
      .onChange((index: number) => {
        this.tabController.changeIndex(index)
      })

      // 标签内容页（水平滑动分页）
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabController
      }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar('')

        TabContent() {
          RankingPage()
        }
        .tabBar('')

        TabContent() {
          StatsPage()
        }
        .tabBar('')
      }
      .barMode(BarMode.Fixed)
      .barHeight(0)
      .scrollable(true)
      .animationDuration(300)
      .onChange((index: number) => {
        this.selectedTabIndex = index
      })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundImage([AppColors.surfaceVariant, AppColors.surface])
    .backgroundImageSize(ImageSize.Cover)
  }
}
