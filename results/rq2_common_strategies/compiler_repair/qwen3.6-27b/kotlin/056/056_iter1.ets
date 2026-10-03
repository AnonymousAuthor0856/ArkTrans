import { router } from '@kit.ArkRouter'
import { webview } from '@kit.WebViewKit'
import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppColors {
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

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppRadius {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
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
    onSurface: '#1E293B'
  } as AppColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  } as AppSpacing,
  Radius: {
    small: 8,
    medium: 12,
    large: 16
  } as AppRadius
}

// --- Components ---

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.md })

      ForEach([1, 2, 3], (index: number) => {
        Row() {
          Text(`Meal ${index}`)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderWidth(1)
        .borderColor(AppTokens.Colors.outline)
        .borderRadius(AppTokens.Radius.medium)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: AppTokens.Spacing.md })
      })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach([1, 2, 3, 4, 5], (index: number) => {
        Row() {
          Row() {
            Text(`Message ${index}`)
              .fontColor(index % 2 === 0 ? AppTokens.Colors.onSurface : AppTokens.Colors.onPrimary)
          }
          .padding(AppTokens.Spacing.md)
          .backgroundColor(index % 2 === 0 ? AppTokens.Colors.surfaceVariant : AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.medium)
        }
        .width('100%')
        .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
        .margin({ top: AppTokens.Spacing.sm })
      })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.md })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Row() {
          Row() {
            // Simulating the bar width logic: (0.3 + index * 0.1).coerceAtMost(1)
            // In ArkTS we can calculate percentage directly
          }
          .width(`${Math.min((0.3 + index * 0.1), 1) * 100}%`)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.small)
        .margin({ bottom: AppTokens.Spacing.md })
      })

      Blank().height(AppTokens.Spacing.lg)

      Button("Share Report")
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .borderRadius(AppTokens.Radius.large)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          // Handle share action
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0
  private tabs: string[] = ["Meals", "Chat", "Stats"]

  build() {
    Column() {
      // Header
      Row() {
        Text("Diet Log")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppTokens.Spacing.lg)

      // Tab Bar
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(14)
            .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentIndex = index
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .borderWidth({ bottom: 1 })
      .borderColor(AppTokens.Colors.outline)

      // Content Area
      Column() {
        if (this.currentIndex === 0) {
          MealsPage()
        } else if (this.currentIndex === 1) {
          ChatPage()
        } else {
          StatsPage()
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // Simulating the gradient background mentioned in Kotlin code
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.primary, 0.1],
        [AppTokens.Colors.secondary, 0.1]
      ]
    })
  }
}