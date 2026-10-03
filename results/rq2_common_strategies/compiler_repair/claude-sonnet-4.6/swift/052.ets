import { curves } from '@kit.ArkUI';

// AppTokens
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

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace Shadow {
    export const blurRadius: number = 4;
    export const yOffset: number = 2;
    export const opacity: number = 0.1;
  }
}

function buildIndexArray(count: number): number[] {
  const arr: number[] = [];
  for (let i = 0; i < count; i++) {
    arr.push(i);
  }
  return arr;
}

// CourseCard Component
@Component
struct CourseCard {
  courseNumber: number = 1;

  build() {
    Row() {
      Column() {
        Text(`Course ${this.courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.sm })
        Text(`Duration: ${4 + this.courseNumber} hrs`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(14)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.Shadow.blurRadius,
      color: `rgba(0,0,0,${AppTokens.Shadow.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Shadow.yOffset
    })
    .alignItems(VerticalAlign.Center)
  }
}

// CourseList Component
@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(buildIndexArray(this.count), (index: number) => {
          CourseCard({ courseNumber: index + 1 })
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}

// CustomTabRow Component
@Component
struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? 18 : 14)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .textAlign(TextAlign.Center)

          Row()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index;
        })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
      })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;
  private tabCounts: number[] = [6, 3, 4];
  private tabTitles: string[] = ['All Courses', 'Enrolled', 'Completed'];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex
      })

      Swiper(this.swiperController) {
        ForEach(this.tabs, (_: string, index: number) => {
          CourseList({
            title: this.tabTitles[index],
            count: this.tabCounts[index]
          })
        })
      }
      .index(this.selectedTabIndex)
      .loop(false)
      .indicator(false)
      .duration(200)
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .alignItems(HorizontalAlign.Start)
  }
}