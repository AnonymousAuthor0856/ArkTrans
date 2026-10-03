// Step Challenge - Health ControlPanel
// Monochrome theme

class AppColors {
  static readonly primary: string = '#FF111827'
  static readonly secondary: string = '#FF374151'
  static readonly tertiary: string = '#FF6B7280'
  static readonly background: string = '#FFF9FAFB'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFE5E7EB'
  static readonly outline: string = '#FFD1D5DB'
  static readonly success: string = '#FF16A34A'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FF111827'
  static readonly onBackground: string = '#FF111827'
  static readonly onSurface: string = '#FF1F2937'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

@Entry
@Component
struct StepChallengeApp {
  @State currentIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)

      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              OverviewPage()
            } else if (index === 1) {
              RankingPage()
            } else if (index === 2) {
              StatsPage()
            }
          }
          .tabBar(this.TabBarBuilder(title, index))
        }, (title: string) => title)
      }
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
    })
  }

  @Builder
  TabBarBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontWeight(index === this.currentIndex ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(index === this.currentIndex ? AppColors.primary : AppColors.onSurface)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button('Sync Device')
        .width('60%')
        .height(48)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.primary)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RankingPage {
  private rankingItems: RankingItem[] = [
    { name: 'User 1', steps: 9000 },
    { name: 'User 2', steps: 8500 },
    { name: 'User 3', steps: 8000 },
    { name: 'User 4', steps: 7500 },
    { name: 'User 5', steps: 7000 }
  ]

  build() {
    Column() {
      ForEach(this.rankingItems, (item: RankingItem) => {
        Row() {
          Text(item.name)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Blank()
          Text(`${item.steps} steps`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .justifyContent(FlexAlign.SpaceBetween)
      }, (item: RankingItem) => item.name)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}

interface RankingItem {
  name: string
  steps: number
}

@Component
struct StatsPage {
  private progressValues: number[] = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

  build() {
    Column() {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      ForEach(this.progressValues, (value: number, index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          Row()
            .width(`${value * 100}%`)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(20)
        .margin({ bottom: AppSpacing.sm })
      }, (value: number, index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}
