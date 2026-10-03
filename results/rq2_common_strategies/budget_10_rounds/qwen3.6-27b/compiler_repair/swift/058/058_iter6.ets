import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - Interfaces for AppTokens
interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyMap {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface TabItem {
  tab: string;
  index: number;
}

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状和间距。
// 这些常量在整个应用中提供一致的UI样式。
export class AppTokens {
  static Colors: ColorMap = {
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

  static TypographyTokens: TypographyMap = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium }, // Fixed SemiBold to Medium as SemiBold might not exist in all versions, or use 600 if needed. Standard is Normal/Medium/Bold.
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeMap = {
    small: 8.0,
    medium: 12.0,
    large: 16.0
  };

  static Spacing: SpacingMap = {
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
      ForEach(tabs.map((tab: string, index: number) => ({ tab: tab, index: index } as TabItem)), (item: TabItem) => {
        Button({ type: ButtonType.Normal }) {
          Text(item.tab)
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
    .position({ x: (getWindowWidth() / tabs.length) * selectedTabIndex, y: 0 })
    .backgroundColor(AppTokens.Colors.primary)
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
  .backgroundColor(AppTokens.Colors.surface)
}

function getWindowWidth(): number {
  try {
    const ctx = getContext(this) as UIAbilityContext;
    const winInfo: window.WindowInfo = window.getDefaultWindowSync(ctx);
    return winInfo.windowRect.width;
  } catch (e) {
    return 375; // Default fallback width
  }
}

// MARK: - OverviewPage
@Component
export struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Button("Sync Device")
          .width(getWindowWidth() * 0.6)
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .layoutWeight(1)
      
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center })
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
      ForEach(Array.from({ length: 5 }, (_, i: number) => i), (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)

          Flex({ justifyContent: FlexAlign.End })
            .layoutWeight(1)

          Text(`${9000 - it * 500} steps`)
            .fontColor(AppTokens.Colors.onSurface)
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
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(Array.from({ length: 7 }, (_, i: number) => i), (it: number) => {
        Row() {
          // Progress Bar Fill
          Row()
            .width(`${clamp(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)

          Flex({ justifyContent: FlexAlign.End })
            .layoutWeight(1)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center })
        .layoutWeight(1)
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
    .systemBarProperties({ barMode: BarMode.Auto, statusBarColor: '#FFFFFF' })
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct StepChallengeApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}