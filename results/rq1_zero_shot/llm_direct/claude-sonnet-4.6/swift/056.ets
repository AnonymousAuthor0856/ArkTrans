import { router } from '@kit.ArkUI';

// MARK: - AppTokens (Atomic Design System)

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#06B6D4';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0F172A';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// MARK: - MealsPage

@Component
struct MealsPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text('Today\'s Meals')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2], (it: number) => {
        Stack() {
          Text(`Meal ${it + 1}`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.medium
        })
      }, (it: number) => it.toString())

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

// MARK: - ChatPage

@Component
struct ChatPage {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        if (it % 2 === 0) {
          Row() {
            Text(`Message ${it + 1}`)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
            Blank()
          }
          .width('100%')
        } else {
          Row() {
            Blank()
            Text(`Message ${it + 1}`)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
          }
          .width('100%')
        }
      }, (it: number) => it.toString())

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

// MARK: - StatsPage

@Component
struct StatsPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(24)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          Row()
            .width(`${Math.min(0.3 + it * 0.1, 1.0) * 100}%`)
            .height(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(24)
      }, (it: number) => it.toString())

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.Transparent)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['#1A0EA5E9', 0.0],
            ['#1A6366F1', 1.0]
          ]
        })

      Column({ space: 0 }) {
        // Title
        Row() {
          Text('Diet Log')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(AppSpacing.lg)

        // Custom Tab Row
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Normal)
                .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
                .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedTab = index;
                })
            }, (tab: string) => tab)
          }
          .width('100%')

          // Tab indicator
          Row()
            .width(`${100 / this.tabs.length}%`)
            .height(2)
            .backgroundColor(AppColors.primary)
            .borderRadius(1)
            .margin({ left: `${(100 / this.tabs.length) * this.selectedTab}%` })
            .animation({
              duration: 200,
              curve: Curve.EaseInOut
            })
        }
        .width('100%')
        .backgroundColor(AppColors.surface)

        // Page Content using Swiper
        Swiper() {
          MealsPage()
          ChatPage()
          StatsPage()
        }
        .index(this.selectedTab)
        .loop(false)
        .indicator(false)
        .duration(200)
        .curve(Curve.EaseInOut)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}