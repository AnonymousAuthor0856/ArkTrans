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
  static readonly headlineSize: number = 20
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
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

@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0

  private readonly tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding(AppSpacing.lg)

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex,
        onTabSelected: (index: number): void => {
          this.selectedTabIndex = index
          this.swiperController.changeIndex(index, true)
        }
      })
        .width('100%')

      Swiper(this.swiperController) {
        OverviewPage()

        RankingPage()

        StatsPage()
      }
      .index(this.selectedTabIndex)
      .indicator(false)
      .loop(false)
      .duration(250)
      .curve(Curve.EaseInOut)
      .onChange((index: number): void => {
        this.selectedTabIndex = index
      })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.surface, 1.0]
      ]
    })
  }
}

@Component
struct CustomTabRow {
  tabs: string[] = []
  @Link selectedTabIndex: number

  onTabSelected: (index: number) => void = (index: number): void => {
  }

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .padding({
              top: AppSpacing.md,
              bottom: AppSpacing.md
            })
            .layoutWeight(1)
            .onClick((): void => {
              this.selectedTabIndex = index
              this.onTabSelected(index)
            })
        }, (tab: string) => tab)
      }
      .width('100%')

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Blank()
            .height(2)
            .layoutWeight(1)
            .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : '#00000000')
        }, (tab: string) => `${tab}_indicator`)
      }
      .width('100%')
      .height(2)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')

      Blank()
        .height(AppSpacing.lg)

      Stack({ alignContent: Alignment.Center }) {
        Text('Sync Device')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
      }
      .width('60%')
      .height(48)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .onClick((): void => {
      })

      Blank()
        .layoutWeight(1)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct RankingPage {
  private readonly users: number[] = [0, 1, 2, 3, 4]

  build() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.users, (item: number) => {
        Row() {
          Text(`User ${item + 1}`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Text(`${9000 - item * 500} steps`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
      }, (item: number) => item.toString())

      Blank()
        .layoutWeight(1)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatsPage {
  private readonly days: number[] = [0, 1, 2, 3, 4, 5, 6]

  private getProgress(index: number): number {
    const value: number = 0.3 + index * 0.1
    return value > 1 ? 1 : value
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')

      ForEach(this.days, (item: number) => {
        ProgressBar({
          progress: this.getProgress(item)
        })
      }, (item: number) => item.toString())

      Blank()
        .layoutWeight(1)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ProgressBar {
  progress: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Blank()
        .width('100%')
        .height(20)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)

      Blank()
        .width(`${this.progress * 100}%`)
        .height(20)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
    }
    .width('100%')
    .height(20)
  }
}