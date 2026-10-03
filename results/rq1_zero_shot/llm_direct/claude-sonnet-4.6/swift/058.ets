import { display } from '@kit.DisplayKit';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  },
};

// MARK: - OverviewPage
@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)

      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - RankingPage
@Component
struct RankingPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)

          Blank()

          Text(`${9000 - it * 500} steps`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
        }
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      })

      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - StatsPage
@Component
struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.small)

          Row()
            .width(`${Math.min((0.3 + it * 0.1), 1.0) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
      })

      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private controller: TabsController = new TabsController();

  build() {
    Column({ space: 0 }) {
      // Title
      Text('Step Challenge')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)

      // Custom Tab Row
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Text(tab)
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(this.selectedTabIndex === index
                ? AppTokens.Colors.primary
                : AppTokens.Colors.onSurface)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.selectedTabIndex = index;
                this.controller.changeIndex(index);
              })
          })
        }
        .width('100%')

        // Indicator
        Row() {
          Divider()
            .width(`${100 / this.tabs.length}%`)
            .strokeWidth(2)
            .color(AppTokens.Colors.primary)
            .margin({ left: `${(100 / this.tabs.length) * this.selectedTabIndex}%` })
        }
        .width('100%')
        .height(2)
        .animation({
          duration: 200,
          curve: Curve.EaseInOut,
        })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)

      // Pager
      Tabs({ barPosition: BarPosition.Start, controller: this.controller, index: this.selectedTabIndex }) {
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
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .animationDuration(200)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]],
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}