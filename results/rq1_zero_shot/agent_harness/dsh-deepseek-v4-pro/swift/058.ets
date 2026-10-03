// MARK: - AppTokens

interface FontStyle {
  size: number;
  weight: FontWeight;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937',
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
struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Text(tab)
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTabIndex = index;
          })
        }, (tab: string, index: number) => index.toString())
      }
      .width('100%')

      Row() {
        Row()
          .width((100 / this.tabs.length) + '%')
          .height(2)
          .backgroundColor(AppTokens.Colors.primary)
          .translate({ x: this.selectedTabIndex * 100 + '%' })
      }
      .width('100%')
      .height(2)
    }
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank().height(AppTokens.Spacing.lg)

      Button() {
        Text('Sync Device')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height('100%')
      }
      .width('60%')
      .height(48)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .alignSelf(ItemAlign.Center)
      .onClick(() => {})

      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct RankingPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          Text('User ' + (it + 1))
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
          Blank()
          Text((9000 - it * 500) + ' steps')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
        }
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
      }, (it: number) => it.toString())
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatsPage {
  private progressPercent(it: number): number {
    return Math.min(1, 0.3 + it * 0.1) * 100;
  }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          Row()
            .width(this.progressPercent(it) + '%')
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Blank()
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      }, (it: number) => it.toString())

      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      CustomTabRow({ tabs: this.tabs, selectedTabIndex: this.selectedTabIndex })
        .width('100%')

      Tabs({ barPosition: BarPosition.End, index: this.selectedTabIndex }) {
        TabContent() {
          OverviewPage()
        }
        TabContent() {
          RankingPage()
        }
        TabContent() {
          StatsPage()
        }
      }
      .barHeight(0)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.surface)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.surface, 1.0]
      ]
    })
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
