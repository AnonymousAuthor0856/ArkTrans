class AppColors {
  static primary: string = '#111827'
  static secondary: string = '#374151'
  static tertiary: string = '#6B7280'
  static background: string = '#F9FAFB'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E5E7EB'
  static outline: string = '#D1D5DB'
  static success: string = '#16A34A'
  static warning: string = '#F59E0B'
  static error: string = '#EF4444'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#111827'
  static onBackground: string = '#111827'
  static onSurface: string = '#1F2937'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 36
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
}

@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private progress: number[] = [30, 40, 50, 60, 70, 80, 90]

  @Builder
  TabItem(label: string, index: number) {
    Column() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
        .height(46)
        .width('100%')
        .textAlign(TextAlign.Center)

      Rect()
        .width('100%')
        .height(2)
        .fill(this.selectedTabIndex === index ? AppColors.primary : AppColors.surface)
    }
    .layoutWeight(1)
    .onClick(() => {
      this.selectedTabIndex = index
    })
  }

  @Builder
  OverviewPage() {
    Column({ space: AppSpacing.md }) {
      Blank()
        .layoutWeight(1)

      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button('Sync Device')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.large)

      Blank()
        .layoutWeight(1)
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
          Text('User ' + (item + 1).toString())
            .fontSize(14)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Text((9000 - item * 500).toString() + ' steps')
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.medium)
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(this.progress, (value: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(20)
            .fill(AppColors.surfaceVariant)
            .borderRadius(AppShape.small)
          Rect()
            .width(value.toString() + '%')
            .height(20)
            .fill(AppColors.primary)
            .borderRadius(AppShape.small)
        }
        .width('100%')
        .height(20)
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .padding(AppSpacing.lg)
        .textAlign(TextAlign.Center)

      Column() {
        Row() {
          ForEach(this.tabs, (tab: string, index?: number) => {
            this.TabItem(tab, index ? index : 0)
          })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor(AppColors.surface)

      if (this.selectedTabIndex === 0) {
        this.OverviewPage()
      } else if (this.selectedTabIndex === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
    })
    .backgroundColor(AppColors.background)
  }
}
