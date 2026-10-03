// App.ets
import { window } from '@kit.ArkUI';

// MARK: - AppTokens (Atomic Design System)

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

class AppTokens {
  static Colors: ColorMap = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#E2E8F0', // Adjusted to match screenshot's solid light blue-grey
    surface: '#FFFFFF',
    surfaceVariant: '#CBD5E1',
    outline: '#D1D5DB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#1E293B',
    onSurface: '#1E293B'
  };

  static TypographyTokens: TypographyMap = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium }, // SemiBold is not standard in all versions, using Medium or Bold usually works. If SemiBold exists, use it. Assuming standard set.
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeMap = {
    small: 8,
    medium: 12,
    large: 16
  };

  static Spacing: SpacingMap = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ["Meals", "Chat", "Stats"];

  build() {
    Column() {
      // Title Box equivalent
      Row() {
        Text("Diet Log")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppTokens.Spacing.lg)

      // Custom TabRow equivalent
      Column() {
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button(tab)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .height(AppTokens.Spacing.md * 2 + AppTokens.Spacing.sm) // Approximate height of padding
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index;
              })
          })
        }
        .width('100%')

        // Tab indicator line
        Row()
          .width(`${100 / this.tabs.length}%`)
          .height(2)
          .backgroundColor(AppTokens.Colors.primary)
          .position({ x: `${this.selectedTab * (100 / this.tabs.length)}%`, y: 0 })
          .animation({ duration: 200, curve: Curve.EaseInOut })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)

      // Content Area
      Column() {
        if (this.selectedTab === 0) {
          MealsPage();
        } else if (this.selectedTab === 1) {
          ChatPage();
        } else {
          StatsPage();
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - MealsPage

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach([0, 1, 2], (it: number) => {
        Column() {
          Text(`Meal ${it + 1}`)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
      })

      Blank().layoutWeight(1)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - ChatPage

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
            Blank().layoutWeight(1)
          } else {
            Blank().layoutWeight(1)
            Text(`Message ${it + 1}`)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%')
      })

      Blank().layoutWeight(1)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - StatsPage

@Component
struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          // Progress bar segment
          Row()
            .width(`${Math.min(Math.max(0.3 + it * 0.1, 0), 1) * 100}%`)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          
          Blank().layoutWeight(1)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank().height(AppTokens.Spacing.lg)

      Button("Share Report")
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .alignSelf(ItemAlign.Center)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}