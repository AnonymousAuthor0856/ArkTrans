import { window } from '@kit.ArkUI';

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状和间距。
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
    onSurface: '#1F2937'
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 8.0,
    medium: 12.0,
    large: 16.0
  },
  Spacing: {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 36.0
  }
};

@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ["Overview", "Ranking", "Stats"];

  build() {
    Column() {
      // 顶部标题区域
      Text("Step Challenge")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // 自定义 TabRow
      CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })
        .width('100%')

      // 页面内容区域 (使用 LazyColumn 模拟 TabView 切换效果，ArkTS中通常用 Navigation 或条件渲染)
      // 这里为了简单直接根据索引渲染不同组件
      if (this.selectedTabIndex === 0) {
        OverviewPage()
      } else if (this.selectedTabIndex === 1) {
        RankingPage()
      } else {
        StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.surface, 1.0]
      ]
    })
  }
}

@Component
struct CustomTabRow {
  tabs: string[];
  @Link selectedTabIndex: number;

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button(tab) {
            this.selectedTabIndex = index;
          }
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTabIndex = index;
          })
        })
      }
      .width('100%')

      // 下划线指示器
      Row() {
        Blank()
        Rectangle()
          .fill(AppTokens.Colors.primary)
          .width(`${100 / this.tabs.length}%`)
          .height(2)
          .offset({ x: (100 / this.tabs.length) * this.selectedTabIndex + '%', y: 0 })
          .animation({ duration: 200, curve: Curve.EaseInOut })
        Blank()
      }
      .width('100%')
      .height(2)
    }
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)

      Spacer().layoutWeight(1)

      Button("Sync Device") {
        // Handle Sync Device action
      }
      .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
      .fontColor(AppTokens.Colors.onPrimary)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .width('60%')
      .height(48)

      Spacer().layoutWeight(1)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct RankingPage {
  build() {
    Column() {
      ForEach(5, (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface)

          Spacer()

          Text(`${9000 - index * 500} steps`)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
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

@Component
struct StatsPage {
  build() {
    Column() {
      Text("Weekly Progress")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(7, (index: number) => {
        Row() {
          // 进度条填充部分
          Rectangle()
            .fill(AppTokens.Colors.primary)
            .width(`${Math.min(30 + index * 10, 100)}%`)
            .borderRadius(AppTokens.Shapes.small)
          
          Spacer()
        }
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .width('100%')
      })

      Spacer()
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}