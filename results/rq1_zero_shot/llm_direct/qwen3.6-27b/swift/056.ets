import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - AppTokens (Atomic Design System)

interface ColorToken {
  hex: string;
}

class AppTokens {
  static Colors = {
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
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static Spacing = {
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
  private screenWidth: number = 0;

  aboutToAppear() {
    // Get screen width for calculations
    const systemInfo = require('@ohos.systemInfo');
    this.screenWidth = systemInfo.windowSize.width;
  }

  build() {
    Column() {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(14, 165, 233, 0.1)', 0.0],
            ['rgba(99, 102, 241, 0.1)', 1.0]
          ]
        })
        .position({ x: 0, y: 0 })
        .zIndex(-1);

      // Content Overlay
      Column() {
        // Title Box
        Row() {
          Text("Diet Log")
            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg);

        // Custom TabRow
        Column() {
          Row() {
            ForEach(this.tabs.map((tab, index) => ({ name: tab, index: index })), (item: { name: string, index: number }) => {
              Button(item.name) {
                this.selectedTab = item.index;
              }
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .fontColor(this.selectedTab === item.index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = item.index;
              });
            })
          }
          .width('100%');

          // Tab indicator line
          Row()
            .width(`${this.screenWidth / this.tabs.length}px`)
            .height(2)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ left: `${(this.screenWidth / this.tabs.length) * this.selectedTab}px` })
            .animation({ duration: 200, curve: Curve.EaseInOut });
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface);

        // HorizontalPager equivalent using Swiper
        Swiper() {
          MealsPage();
          ChatPage();
          StatsPage();
        }
        .index(this.selectedTab)
        .loop(false)
        .displayCount(1)
        .indicator(false)
        .onChange((index: number) => {
          this.selectedTab = index;
        });
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start);

      ForEach([0, 1, 2], (it: number) => {
        Column() {
          Text(`Meal ${it + 1}`)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline });
      });

      Blank().layoutWeight(1);
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start);

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium);
            Blank().layoutWeight(1);
          } else {
            Blank().layoutWeight(1);
            Text(`Message ${it + 1}`)
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium);
          }
        }
        .width('100%');
      });

      Blank().layoutWeight(1);
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  private screenWidth: number = 0;

  aboutToAppear() {
    const systemInfo = require('@ohos.systemInfo');
    this.screenWidth = systemInfo.windowSize.width;
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start);

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          // Progress bar segment
          Row()
            .width(`${Math.min(Math.max(0.3 + it * 0.1, 0), 1) * (this.screenWidth - AppTokens.Spacing.lg * 2)}px`)
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small);
          
          Blank().layoutWeight(1);
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small);
      });

      Blank().height(AppTokens.Spacing.lg);

      Button("Share Report") {
        // Action
      }
      .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
      .fontColor(AppTokens.Colors.onSecondary)
      .width(`${this.screenWidth * 0.6}px`)
      .height(48)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.large)
      .alignSelf(ItemAlign.Center);
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}