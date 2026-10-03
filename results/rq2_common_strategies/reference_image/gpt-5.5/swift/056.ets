class AppColors {
  static readonly primary: number = 0xFF0EA5E9
  static readonly secondary: number = 0xFF6366F1
  static readonly tertiary: number = 0xFF06B6D4
  static readonly background: number = 0xFFF1F5F9
  static readonly surface: number = 0xFFFFFFFF
  static readonly surfaceVariant: number = 0xFFE2E8F0
  static readonly outline: number = 0xFFD1D5DB
  static readonly success: number = 0xFF22C55E
  static readonly warning: number = 0xFFF59E0B
  static readonly error: number = 0xFFEF4444
  static readonly onPrimary: number = 0xFFFFFFFF
  static readonly onSecondary: number = 0xFFFFFFFF
  static readonly onTertiary: number = 0xFF0F172A
  static readonly onBackground: number = 0xFF1E293B
  static readonly onSurface: number = 0xFF1E293B
}

class AppTypography {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly body: number = 14
  static readonly label: number = 12
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
  @State selectedTab: number = 0

  private readonly tabs: string[] = ['Meals', 'Chat', 'Stats']
  private readonly meals: number[] = [0, 1, 2]
  private readonly messages: number[] = [0, 1, 2, 3, 4]
  private readonly days: number[] = [0, 1, 2, 3, 4, 5, 6]

  private progressValue(index: number): number {
    const value: number = 0.3 + index * 0.1
    return Math.max(0, Math.min(1, value))
  }

  build() {
    Column() {
      Row() {
        Text('Diet Log')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(65)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      this.TabRow()

      if (this.selectedTab === 0) {
        this.MealsPage()
      } else if (this.selectedTab === 1) {
        this.ChatPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [0x1A0EA5E9, 0.0],
        [0x1A6366F1, 1.0]
      ]
    })
  }

  @Builder
  TabRow() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
            .width('100%')
            .height(41)
            .textAlign(TextAlign.Center)

          Blank()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTab === index ? AppColors.primary : 0x00000000)
        }
        .layoutWeight(1)
        .height('100%')
        .onClick(() => {
          this.selectedTab = index
        })
      }, (tab: string) => tab)
    }
    .width('100%')
    .height(43)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  MealsPage() {
    Column({ space: AppSpacing.md }) {
      Text(`Today's Meals`)
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(this.meals, (item: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Text(`Meal ${item + 1}`)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.medium
        })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ChatPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(this.messages, (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Text(`Message ${item + 1}`)
              .fontSize(AppTypography.body)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)

            Blank()
              .layoutWeight(1)
          } else {
            Blank()
              .layoutWeight(1)

            Text(`Message ${item + 1}`)
              .fontSize(AppTypography.body)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
          }
        }
        .width('100%')
      }, (item: number) => item.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(this.days, (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width(`${this.progressValue(item) * 100}%`)
            .height(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
      }, (item: number) => item.toString())

      Blank()
        .height(AppSpacing.lg)

      Button() {
        Text('Share Report')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width('60%')
      .height(48)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShapes.large)
      .onClick(() => {
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}