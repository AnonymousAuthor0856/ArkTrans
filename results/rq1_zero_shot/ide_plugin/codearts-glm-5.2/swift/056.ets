class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF6366F1',
    tertiary: '#FF06B6D4',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF1E293B',
    onSurface: '#FF1E293B',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([1, 2, 3], (it: number) => {
        Stack() {
          Text(`Meal ${it}`)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
      })
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([1, 2, 3, 4, 5], (it: number) => {
        Row() {
          if (it % 2 === 1) {
            Text(`Message ${it}`)
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
            Blank()
          } else {
            Blank()
            Text(`Message ${it}`)
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%')
      })
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Column()
            .width(`${Math.min(Math.max(0.3 + it * 0.1, 0), 1) * 100}%`)
            .height('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank()
        .layoutWeight(1)

      Row() {
        Button("Share Report")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width('60%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
        })

      Column() {
        Row() {
          Text("Diet Log")
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)

        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                .layoutWeight(1)
                .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedTab = index
                })
            })
          }
          .width('100%')

          Stack({ alignContent: Alignment.Start }) {
            Column()
              .width(`${100 / this.tabs.length}%`)
              .height(2)
              .backgroundColor(AppTokens.Colors.primary)
              .margin({ left: `${this.selectedTab * (100 / this.tabs.length)}%` })
          }
          .width('100%')
          .height(2)
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)

        if (this.selectedTab === 0) {
          MealsPage()
        } else if (this.selectedTab === 1) {
          ChatPage()
        } else {
          StatsPage()
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}