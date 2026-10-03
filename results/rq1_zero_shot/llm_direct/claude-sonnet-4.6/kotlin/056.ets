import { curves } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0EA5E9';
    export const secondary: string = '#6366F1';
    export const tertiary: string = '#06B6D4';
    export const background: string = '#F1F5F9';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E2E8F0';
    export const outline: string = '#D1D5DB';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#0F172A';
    export const onBackground: string = '#1E293B';
    export const onSurface: string = '#1E293B';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      ForEach([0, 1, 2], (index: number) => {
        Row() {
          Text(`Meal ${index + 1}`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(14)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(12)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: 12 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          if (index % 2 === 0) {
            Text(`Message ${index + 1}`)
              .fontColor(AppTokens.Colors.onSurface)
              .fontSize(14)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(12)
            Blank()
          } else {
            Blank()
            Text(`Message ${index + 1}`)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(14)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(12)
          }
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  private barFractions: number[] = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach(this.barFractions, (fraction: number, index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(24)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(8)

          Row()
            .width(`${Math.min(fraction, 1.0) * 100}%`)
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
      }, (item: number, index: number) => index.toString())

      Blank().height(AppTokens.Spacing.lg)

      Button("Share Report")
        .width('60%')
        .height(48)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State currentTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

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
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Center)

      // Tab bar
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .padding({ top: 10, bottom: 10 })

            Divider()
              .width('100%')
              .height(2)
              .backgroundColor(this.currentTab === index ? AppTokens.Colors.primary : Color.Transparent)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.currentTab = index;
          })
        }, (tab: string, index: number) => index.toString())
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .border({ width: { bottom: 1 }, color: AppTokens.Colors.outline })

      // Page content
      Swiper() {
        MealsPage()
        ChatPage()
        StatsPage()
      }
      .index(this.currentTab)
      .loop(false)
      .indicator(false)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#1A0EA5E9', 0.0],
        ['#1A6366F1', 1.0]
      ]
    })
    .backgroundColor(AppTokens.Colors.background)
  }
}