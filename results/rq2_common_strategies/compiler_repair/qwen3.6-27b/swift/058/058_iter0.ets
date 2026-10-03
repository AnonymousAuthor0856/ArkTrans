import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状和间距。
// 这些常量在整个应用中提供一致的UI样式。
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
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 8.0,
    medium: 12.0,
    large: 16.0
  };

  static Spacing = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 36.0
  };
}

// MARK: - Helper Functions
function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max);
}

// MARK: - CustomTabRow
@Builder
export function CustomTabRow(tabs: string[], selectedTabIndex: number, onSelect: (index: number) => void) {
  Column() {
    Row() {
      ForEach(tabs.map((tab, index) => ({ tab, index })), (item) => {
        Button({ type: ButtonType.Normal }) {
          Text(item.tab)
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(selectedTabIndex === item.index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .onClick(() => {
          onSelect(item.index);
        })
      });
    }
    .width('100%')

    // Underline Indicator
    Row() {
      Blank()
    }
    .width('100%')
    .height(2)
    .position({ x: (getApp().windowWidth / tabs.length) * selectedTabIndex, y: 0 })
    .backgroundColor(AppTokens.Colors.primary)
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
  .backgroundColor(AppTokens.Colors.surface)
}

// MARK: - OverviewPage
@Component
export struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Spacer()
        .layoutWeight(1)

      Button("Sync Device") {
        // Handle Sync Device button click
      }
      .width(getApp().windowWidth * 0.6)
      .height(48)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
      .fontSize(AppTokens.TypographyTokens.title.size)
      .fontWeight(AppTokens.TypographyTokens.title.weight)
      .fontColor(AppTokens.Colors.onPrimary)

      Spacer()
        .layoutWeight(1)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - RankingPage
@Component
export struct RankingPage {
  build() {
    Column() {
      ForEach(Array.from({ length: 5 }, (_, i) => i), (it) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontColor(AppTokens.Colors.onSurface)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)

          Spacer()

          Text(`${9000 - it * 500} steps`)
            .fontColor(AppTokens.Colors.onSurface)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
        }
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
      })
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - StatsPage
@Component
export struct StatsPage {
  build() {
    Column() {
      Text("Weekly Progress")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(Array.from({ length: 7 }, (_, i) => i), (it) => {
        Row() {
          // Progress Bar Fill
          Row()
            .width(`${clamp(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)

          Spacer()
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Spacer()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - RootScreen
@Component
export struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ["Overview", "Ranking", "Stats"];

  build() {
    Column() {
      // Title Area
      Text("Step Challenge")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .textAlign(TextAlign.Center)
        .width('100%')

      // Custom TabRow
      CustomTabRow(this.tabs, this.selectedTabIndex, (index: number) => {
        this.selectedTabIndex = index;
      })
        .width('100%')

      // Page Content
      if (this.selectedTabIndex === 0) {
        OverviewPage()
      } else if (this.selectedTabIndex === 1) {
        RankingPage()
      } else if (this.selectedTabIndex === 2) {
        StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0],
        [AppTokens.Colors.surface, 1]
      ]
    })
    .systemBarProperties({ barMode: BarMode.Auto })
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct StepChallengeApp {
  build() {
    RootScreen()
  }
}