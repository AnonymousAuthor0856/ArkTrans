// MARK: - AppTokens (Atomic Design System)

interface FontStyle {
  size: number;
  weight: FontWeight;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#1E293B',
    onSurface: '#1E293B',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2], (it: number) => {
        Stack() {
          Text('Meal ' + (it + 1))
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
      }, (it: number) => it.toString())

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor('#00000000')
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text('Message ' + (it + 1))
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
            Blank()
          } else {
            Blank()
            Text('Message ' + (it + 1))
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%')
      }, (it: number) => it.toString())

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor('#00000000')
  }
}

@Component
struct StatsPage {
  private progressPercent(it: number): number {
    return Math.min(1, 0.3 + it * 0.1) * 100;
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          Row()
            .width(this.progressPercent(it) + '%')
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Blank()
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      }, (it: number) => it.toString())

      Blank().height(AppTokens.Spacing.lg)

      Button() {
        Text('Share Report')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width('100%')
          .height('100%')
      }
      .width('60%')
      .height(48)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.large)
      .alignSelf(ItemAlign.Center)
      .onClick(() => {})
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor('#00000000')
  }
}

@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      Column() {
        Row() {
          Text('Diet Log')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding(AppTokens.Spacing.lg)

        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button() {
                Text(tab)
                  .fontSize(AppTokens.Typography.body.size)
                  .fontWeight(AppTokens.Typography.body.weight)
                  .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                  .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index;
              })
            }, (tab: string, index: number) => index.toString())
          }
          .width('100%')

          Row() {
            Row()
              .width((100 / this.tabs.length) + '%')
              .height(2)
              .backgroundColor(AppTokens.Colors.primary)
              .translate({ x: this.selectedTab * 100 + '%' })
          }
          .width('100%')
          .height(2)
        }
        .backgroundColor(AppTokens.Colors.surface)
        .width('100%')

        Tabs({ barPosition: BarPosition.End, index: this.selectedTab }) {
          TabContent() {
            MealsPage()
          }
          TabContent() {
            ChatPage()
          }
          TabContent() {
            StatsPage()
          }
        }
        .barHeight(0)
        .layoutWeight(1)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1A0EA5E9', 0.0],
          ['#1A6366F1', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
