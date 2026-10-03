import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// Design Tokens
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

class AppTokensConfig {
  Colors: AppColors = {
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
  
  Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
}

const AppTokens = new AppTokensConfig();

@Entry
@Component
struct RootScreen {
  @State currentPageIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      // Header
      Row() {
        Text("Step Challenge")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg })

      // Tab Bar
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(14)
            .fontWeight(this.currentPageIndex === index ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.currentPageIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .onClick(() => {
              this.currentPageIndex = index
            })
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        })
      }
      .width('100%')
      .height(48)
      .backgroundColor(Color.White)
      .borderWidth({ bottom: 1 })
      .borderColor(AppTokens.Colors.outline)

      // Content Area
      Column() {
        if (this.currentPageIndex === 0) {
          OverviewPage()
        } else if (this.currentPageIndex === 1) {
          RankingPage()
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
  }
}

@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.xxl })

      Button("Sync Device")
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Spacing.lg)
        .margin({ top: AppTokens.Spacing.lg })
        .onClick(() => {
          // Sync logic here
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RankingPage {
  build() {
    Column() {
      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row() {
          Text(`User ${item}`)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank().layoutWeight(1)
          
          Text(`${9000 - item * 500} steps`)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Spacing.md)
        .margin({ bottom: AppTokens.Spacing.sm })
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
      Text("Weekly Progress")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.lg })

      ForEach([0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], (progress: number) => {
        Row() {
          Row() {
            // Progress bar fill
          }
          .width(`${progress * 100}%`)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Spacing.xs)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Spacing.xs)
        .margin({ bottom: AppTokens.Spacing.sm })
      })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}