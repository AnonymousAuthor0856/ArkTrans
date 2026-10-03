import { Length, ResourceStr } from '@ohos.arkui.UIContext';

class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF6366F1',
    tertiary: '#FF06B6D4',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF1E293B',
    onSurface: '#FF1E293B',
  };

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      // Title Box
      Row() {
        Text('Diet Log')
          .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)

      // Custom TabRow
      Column() {
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button(tab)
              .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
              .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .backgroundColor(Color.Transparent)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index;
              })
          }, (tab: string) => tab)
        }
        // Tab indicator line
        Row() {
          Line()
            .width('33.33%')
            .height(2)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ left: `${(this.selectedTab * 100) / 3}%`, right: `${100 - ((this.selectedTab + 1) * 100) / 3}%` })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)

      // Pager Content
      Stack() {
        if (this.selectedTab === 0) {
          MealsPage()
        } else if (this.selectedTab === 1) {
          ChatPage()
        } else if (this.selectedTab === 2) {
          StatsPage()
        }
      }
      .layoutWeight(1)
      .width('100%')
      .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.primary, 0.1], [AppTokens.Colors.secondary, 0.1]]
    })
    .backgroundColor(AppTokens.Colors.background)
    .statusBarHidden(true)
  }
}

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.md })

      ForEach([0, 1, 2], (it: number) => {
        Row() {
          Text(`Meal ${it + 1}`)
            .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
        .margin({ bottom: AppTokens.Spacing.md })
      }, (it: number) => it.toString())

      Blank().layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text('Diet Chat')
        .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
            Blank().layoutWeight(1)
          } else {
            Blank().layoutWeight(1)
            Text(`Message ${it + 1}`)
              .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.sm })
      }, (it: number) => it.toString())

      Blank().layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text('Weekly Calories')
        .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.md })

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          Row()
            .width(`${(0.3 + it * 0.1) * 100}%`)
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Blank().layoutWeight(1)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .margin({ bottom: AppTokens.Spacing.md })
      }, (it: number) => it.toString())

      Blank().layoutWeight(1)

      Button('Share Report')
        .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
        .fontColor(AppTokens.Colors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}