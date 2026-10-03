import { curves } from '@kit.ArkUI';

// App Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#111827';
    export const secondary: string = '#374151';
    export const tertiary: string = '#6B7280';
    export const background: string = '#F9FAFB';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E5E7EB';
    export const outline: string = '#D1D5DB';
    export const success: string = '#16A34A';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#111827';
    export const onBackground: string = '#111827';
    export const onSurface: string = '#1F2937';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const headlineSize: number = 20;
    export const titleSize: number = 16;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }

  export namespace Radius {
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 16;
  }
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private controller: TabsController = new TabsController();

  build() {
    Column() {
      // Header
      Row() {
        Text('Step Challenge')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppTokens.Spacing.lg)

      // Tab Bar
      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Column() {
            Text(title)
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIndex === index
                ? AppTokens.Colors.primary
                : AppTokens.Colors.onSurface)
              .padding({ top: 10, bottom: 10 })
            Divider()
              .strokeWidth(this.currentIndex === index ? 2 : 0)
              .color(AppTokens.Colors.primary)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentIndex = index;
            this.controller.changeIndex(index);
          })
        })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)

      // Pager
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
          OverviewPage()
        }

        TabContent() {
          RankingPage()
        }

        TabContent() {
          StatsPage()
        }
      }
      .barHeight(0)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .animationDuration(300)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.surface, 1.0]
      ]
    })
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Radius.large)
        .width('60%')
        .height(48)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct RankingPage {
  private users: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.users, (item: number) => {
        Row() {
          Text(`User ${item + 1}`)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontColor(AppTokens.Colors.onSurface)

          Text(`${9000 - item * 500} steps`)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.medium)
        .padding(AppTokens.Spacing.md)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.days, (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          // Background bar
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Radius.small)

          // Progress bar
          Row()
            .width(`${Math.min((0.3 + item * 0.1) * 100, 100)}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Radius.small)
        }
        .width('100%')
        .height(20)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}