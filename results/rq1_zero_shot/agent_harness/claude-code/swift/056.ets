// AppTokens (Atomic Design System)
class AppTokens {
  static Colors(): void {
  }
}

namespace AppTokens.Colors {
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

namespace AppTokens.TypographyTokens {
  export const display: object = { fontSize: 28, fontWeight: FontWeight.Bold };
  export const headline: object = { fontSize: 20, fontWeight: FontWeight.Medium };
  export const title: object = { fontSize: 16, fontWeight: FontWeight.Medium };
  export const body: object = { fontSize: 14, fontWeight: FontWeight.Normal };
  export const label: object = { fontSize: 12, fontWeight: FontWeight.Medium };
}

namespace AppTokens.Shapes {
  export const small: number = 8;
  export const medium: number = 12;
  export const large: number = 16;
}

namespace AppTokens.Spacing {
  export const xs: number = 4;
  export const sm: number = 8;
  export const md: number = 12;
  export const lg: number = 16;
  export const xl: number = 24;
  export const xxl: number = 36;
}

// Helper: clamp a value between min and max
function clamp(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(value, max));
}

// MealsPage builder
@Builder
function MealsPage() {
  Column() {
    Text('Today\'s Meals')
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onSurface)
      .margin({ bottom: AppTokens.Spacing.md })
      .width('100%')
      .textAlign(TextAlign.Start);

    ForEach([0, 1, 2], (it: number) => {
      Stack() {
        Text(`Meal ${it + 1}`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .width('100%')
      .height(80)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .margin({ bottom: AppTokens.Spacing.md });
    }, (it: number) => it.toString());

    Blank();
  }
  .width('100%')
  .height('100%')
  .padding(AppTokens.Spacing.lg)
  .alignItems(HorizontalAlign.Start)
  .justifyContent(FlexAlign.Start)
  .backgroundColor(Color.Transparent);
}

// ChatPage builder
@Builder
function ChatPage() {
  Column() {
    Text('Diet Chat')
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onSurface)
      .margin({ bottom: AppTokens.Spacing.sm })
      .width('100%')
      .textAlign(TextAlign.Start);

    ForEach([0, 1, 2, 3, 4], (it: number) => {
      Row() {
        if (it % 2 === 0) {
          Text(`Message ${it + 1}`)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium);
          Blank();
        } else {
          Blank();
          Text(`Message ${it + 1}`)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium);
        }
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm });
    }, (it: number) => it.toString());

    Blank();
  }
  .width('100%')
  .height('100%')
  .padding(AppTokens.Spacing.lg)
  .alignItems(HorizontalAlign.Start)
  .justifyContent(FlexAlign.Start)
  .backgroundColor(Color.Transparent);
}

// StatsPage builder
@Builder
function StatsPage() {
  Column() {
    Text('Weekly Calories')
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onSurface)
      .margin({ bottom: AppTokens.Spacing.md })
      .width('100%')
      .textAlign(TextAlign.Start);

    ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
      Row() {
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(`${clamp(0.3 + it * 0.1, 0, 1) * 100}%`)
          .height('100%')
          .radius(AppTokens.Shapes.small);
        Blank();
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .margin({ bottom: AppTokens.Spacing.md });
    }, (it: number) => it.toString());

    Blank()
      .height(AppTokens.Spacing.lg);

    Button('Share Report')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onSecondary)
      .width('60%')
      .height(48)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.large)
      .onClick(() => {});
  }
  .width('100%')
  .height('100%')
  .padding(AppTokens.Spacing.lg)
  .justifyContent(FlexAlign.Start)
  .backgroundColor(Color.Transparent);
}

// RootScreen — main entry
@Entry
@Component
struct DietLogApp {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background gradient using a colored Rect + Column
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[AppTokens.Colors.primary, 0.1], [AppTokens.Colors.secondary, 0.1]]
      });

      Column() {
        // Title bar
        Row() {
          Text('Diet Log')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground);
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg);

        // Tabs
        Stack({ alignContent: Alignment.BottomStart }) {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .height('100%')
                .onClick(() => {
                  this.selectedTab = index;
                });
            }, (tab: string, index: number) => tab + index);
          }
          .width('100%')
          .height(48);

          // Tab indicator
          Row() {
            Column()
              .width('100%')
              .height(2)
              .backgroundColor(AppTokens.Colors.primary);
          }
          .width(`${100 / this.tabs.length}%`)
          .justifyContent(FlexAlign.Center)
          .offset({ x: `${this.selectedTab * (100 / this.tabs.length)}%` })
          .animation({
            duration: 200,
            curve: Curve.EaseInOut
          });
        }
        .width('100%')
        .height(48)
        .backgroundColor(AppTokens.Colors.surface);

        // Content pager
        Swiper({
          index: this.selectedTab,
          loop: false,
          indicator: false
        }) {
          MealsPage();
          ChatPage();
          StatsPage();
        }
        .width('100%')
        .layoutWeight(1)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Transparent);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}
