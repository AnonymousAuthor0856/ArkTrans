// AppTokens.ets
// 定义应用程序的颜色、排版、形状和间距。
export class AppTokens {
  static Colors = {
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
    onSurface: '#1F2937'
  }

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
}

// Helper function to clamp values, equivalent to Kotlin's coerceAtMost
function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max);
}

// RootScreen.ets
@Component
export struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  build() {
    Column() {
      // 顶部标题区域
      Text('Step Challenge')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // 自定义 TabRow
      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: this.selectedTabIndex,
        onTabSelected: (index: number) => {
          this.selectedTabIndex = index;
        }
      })

      // Pager 内容区域
      Swiper() {
        OverviewPage()
        RankingPage()
        StatsPage()
      }
      .index(this.selectedTabIndex)
      .indicator(false) // 隐藏指示器
      .loop(false)
      .duration(300)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    // 背景渐变
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
    })
  }
}

// CustomTabRow.ets
@Component
struct CustomTabRow {
  private tabs: string[];
  private selectedTabIndex: number;
  private onTabSelected: (index: number) => void;

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tabName: string, index?: number) => {
          Button(tabName)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .height('100%')
            .layoutWeight(1)
            .onClick(() => {
              if (index !== undefined) {
                this.onTabSelected(index);
              }
            })
        })
      }
      .width('100%')
      .height(48)

      // 下划线指示器
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width(`${100 / this.tabs.length}%`)
          .height(2)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ left: `${(100 / this.tabs.length) * this.selectedTabIndex}%` })
          .animation({ duration: 200, curve: Curve.EaseInOut })
      }
      .width('100%')
      .height(2)
    }
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// OverviewPage.ets
@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Center)
  }
}

// RankingPage.ets
@Component
struct RankingPage {
  private items: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.items, (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${9000 - it * 500} steps`)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// StatsPage.ets
@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.days, (it: number) => {
        Row() {
          // 计算填充比例并限制在 0 到 1 之间
          Row()
            .width(`${clamp(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// App Entry Point
@Entry
struct StepChallengeApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}