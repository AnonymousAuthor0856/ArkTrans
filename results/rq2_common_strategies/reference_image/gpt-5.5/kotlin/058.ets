const NAME: string = '087_StepChallenge_en'
const UI_TYPE: string = 'Health ControlPanel'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly body: number = 14
  static readonly label: number = 12
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

@Entry
@Component
struct Index {
  @State private selectedIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private ranks: number[] = [0, 1, 2, 3, 4]
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column() {
      this.Header()
      this.TabBar()
      this.PageContent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.surface, 1.0]
      ]
    })
  }

  @Builder
  private Header() {
    Row() {
      Text('Step Challenge')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(65)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private TabBar() {
    Column() {
      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Column() {
            Row() {
              Text(title)
                .fontSize(AppTypography.title)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedIndex === index ? AppColors.primary : AppColors.onSurface)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(45)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Row()
              .width('100%')
              .height(3)
              .backgroundColor(this.selectedIndex === index ? AppColors.primary : Color.Transparent)
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppColors.surface)
          .onClick(() => {
            this.selectedIndex = index
          })
        }, (title: string, index: number) => `${title}-${index}`)
      }
      .width('100%')
      .height(48)
      .backgroundColor(AppColors.surface)

      Row()
        .width('100%')
        .height(1)
        .backgroundColor(AppColors.outline)
    }
    .width('100%')
    .height(49)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private PageContent() {
    Column() {
      if (this.selectedIndex === 0) {
        this.OverviewPage()
      } else if (this.selectedIndex === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  private OverviewPage() {
    Column() {
      Text('Today\'s Steps: 8452')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Blank()
        .height(40)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Sync Device')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('60%')
      .height(48)
      .borderRadius(AppRadius.large)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.lg,
      bottom: AppSpacing.lg
    })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private RankingPage() {
    Column() {
      ForEach(this.ranks, (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Text(`${9000 - index * 500} steps`)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(48)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md
        })
        .margin({ bottom: AppSpacing.sm })
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.surfaceVariant)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  private StatsPage() {
    Column() {
      Text('Weekly Progress')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Blank()
        .height(AppSpacing.sm)

      ForEach(this.days, (index: number) => {
        Row() {
          Row()
            .width(`${Math.min(30 + index * 10, 100)}%`)
            .height('100%')
            .borderRadius(AppRadius.small)
            .backgroundColor(AppColors.primary)
        }
        .width('100%')
        .height(20)
        .margin({ bottom: AppSpacing.sm })
        .borderRadius(AppRadius.small)
        .backgroundColor(AppColors.surfaceVariant)
        .clip(true)
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}