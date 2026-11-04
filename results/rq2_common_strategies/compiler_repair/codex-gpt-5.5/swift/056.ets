class AppColors {
  static primary: string = '#0EA5E9'
  static secondary: string = '#6366F1'
  static tertiary: string = '#06B6D4'
  static background: string = '#F1F5F9'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E2E8F0'
  static outline: string = '#D1D5DB'
  static success: string = '#22C55E'
  static warning: string = '#F59E0B'
  static error: string = '#EF4444'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#0F172A'
  static onBackground: string = '#1E293B'
  static onSurface: string = '#1E293B'
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
  @State selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']
  private calories: number[] = [30, 40, 50, 60, 70, 80, 90]

  @Builder
  TabLabel(label: string, index: number) {
    Column() {
      Text(label)
        .fontSize(14)
        .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
        .height(46)
        .width('100%')
        .textAlign(TextAlign.Center)

      Rect()
        .width('100%')
        .height(2)
        .fill(this.selectedTab === index ? AppColors.primary : AppColors.surface)
    }
    .layoutWeight(1)
    .onClick(() => {
      this.selectedTab = index
    })
  }

  @Builder
  MealsPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2], (item: number) => {
        Stack() {
          Text('Meal ' + (item + 1).toString())
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppShape.medium })
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ChatPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Text('Message ' + (item + 1).toString())
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShape.medium)
            Blank()
              .layoutWeight(1)
          } else {
            Blank()
              .layoutWeight(1)
            Text('Message ' + (item + 1).toString())
              .fontSize(14)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShape.medium)
          }
        }
        .width('100%')
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(this.calories, (value: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(24)
            .fill(AppColors.surfaceVariant)
            .borderRadius(AppShape.small)
          Rect()
            .width(value.toString() + '%')
            .height(24)
            .fill(AppColors.primary)
            .borderRadius(AppShape.small)
        }
        .width('100%')
        .height(24)
      })

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShape.large)

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
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)

      Column() {
        Row() {
          ForEach(this.tabs, (tab: string, index?: number) => {
            this.TabLabel(tab, index ? index : 0)
          })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor(AppColors.surface)

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
    .linearGradient({
      angle: 180,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
    .backgroundColor(AppColors.background)
  }
}
