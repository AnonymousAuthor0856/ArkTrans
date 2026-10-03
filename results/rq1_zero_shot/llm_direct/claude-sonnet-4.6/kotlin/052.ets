import { curves } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF111111';
    export const secondary: string = '#FF444444';
    export const background: string = '#FFF5F5F5';
    export const surface: string = '#FFFFFFFF';
    export const outline: string = '#FFCCCCCC';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSurface: string = '#FF111111';
  }

  export namespace Typography {
    export const displaySize: number = 28;
    export const headlineSize: number = 18;
    export const bodySize: number = 14;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
  }
}

@Component
struct CourseCard {
  index: number = 0;

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(`Course ${this.index + 1}`)
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Text(`Duration: ${5 + this.index} hrs`)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('View')
        .fontSize(AppTokens.Typography.bodySize)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .height(24)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.title)
        .fontSize(AppTokens.Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
        .width('100%')

      ForEach(Array.from({ length: this.count }, (_: Object, i: number) => i), (item: number) => {
        CourseCard({ index: item })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private controller: TabsController = new TabsController();

  @Builder
  tabBar(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(this.currentIndex === index
          ? AppTokens.Typography.headlineSize
          : AppTokens.Typography.bodySize)
        .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.currentIndex === index
          ? AppTokens.Colors.primary
          : AppTokens.Colors.secondary)
        .padding({ top: 8, bottom: 8 })

      Divider()
        .strokeWidth(2)
        .color(this.currentIndex === index ? AppTokens.Colors.primary : Color.Transparent)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Course Catalog')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ top: AppTokens.Spacing.md })

      Tabs({
        barPosition: BarPosition.Start,
        index: this.currentIndex,
        controller: this.controller
      }) {
        TabContent() {
          Scroll() {
            CourseList({ title: 'All Courses', count: 6 })
              .padding({ top: AppTokens.Spacing.md })
          }
          .scrollBar(BarState.Off)
          .width('100%')
          .height('100%')
        }
        .tabBar(this.tabBar(0, this.tabs[0]))

        TabContent() {
          Scroll() {
            CourseList({ title: 'Enrolled', count: 3 })
              .padding({ top: AppTokens.Spacing.md })
          }
          .scrollBar(BarState.Off)
          .width('100%')
          .height('100%')
        }
        .tabBar(this.tabBar(1, this.tabs[1]))

        TabContent() {
          Scroll() {
            CourseList({ title: 'Completed', count: 4 })
              .padding({ top: AppTokens.Spacing.md })
          }
          .scrollBar(BarState.Off)
          .width('100%')
          .height('100%')
        }
        .tabBar(this.tabBar(2, this.tabs[2]))
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .animationDuration(300)
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .backgroundColor(AppTokens.Colors.background)
    .alignItems(HorizontalAlign.Start)
  }
}