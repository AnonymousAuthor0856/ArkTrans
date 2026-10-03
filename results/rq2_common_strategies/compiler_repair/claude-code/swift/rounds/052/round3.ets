import prompt from '@ohos.promptAction';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF111111';
    export const secondary: ResourceColor = '#FF444444';
    export const background: ResourceColor = '#FFF5F5F5';
    export const surface: ResourceColor = '#FFFFFFFF';
    export const outline: ResourceColor = '#FFCCCCCC';
    export const onPrimary: ResourceColor = '#FFFFFFFF';
    export const onSurface: ResourceColor = '#FF111111';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const displayWeight: number = FontWeight.Bold;
    export const headlineSize: number = 18;
    export const headlineWeight: number = 600;
    export const bodySize: number = 14;
    export const bodyWeight: number = FontWeight.Normal;
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

  export namespace ElevationMapping {
    export const level1Radius: number = 4;
    export const level1Y: number = 2;
    export const level1Opacity: number = 0.1;
  }
}

// MARK: - CourseCard
@Component
struct CourseCard {
  @Prop courseNumber: number = 1;

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(AppTokens.TypographyTokens.headlineWeight)
          .fontColor(AppTokens.Colors.primary)
        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('View')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
        .onClick(() => {
          prompt.showToast({ message: `View Course ${this.courseNumber}` });
        })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1Radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1Y
    });
  }
}

// MARK: - CourseList
@Component
struct CourseList {
  @Prop title: string = '';
  @Prop count: number = 0;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(AppTokens.TypographyTokens.headlineWeight)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(
          Array.from<number>({ length: this.count }, (_: number, i: number): number => i + 1),
          (item: number): void => {
            CourseCard({ courseNumber: item })
          },
          (item: number): string => item.toString()
        )
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - CustomTabRow
@Component
struct CustomTabRow {
  @Prop tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Row() {
        ForEach(
          this.tabs,
          (tab: string, index: number): void => {
            Text(tab)
              .fontSize(this.selectedTabIndex === index
                ? AppTokens.TypographyTokens.headlineSize
                : AppTokens.TypographyTokens.bodySize)
              .fontWeight(this.selectedTabIndex === index
                ? AppTokens.TypographyTokens.headlineWeight
                : AppTokens.TypographyTokens.bodyWeight)
              .fontColor(this.selectedTabIndex === index
                ? AppTokens.Colors.primary
                : AppTokens.Colors.secondary)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .width(`${100 / this.tabs.length}%`)
              .textAlign(TextAlign.Center)
              .onClick((): void => {
                this.selectedTabIndex = index;
              })
          },
          (tab: string, index: number): string => `${tab}_${index}`
        )
      }
      .width('100%')

      // Underline indicator with sliding animation
      Column()
        .width(`${100 / this.tabs.length}%`)
        .height(2)
        .backgroundColor(AppTokens.Colors.primary)
        .translate({ x: this.selectedTabIndex * (100 / this.tabs.length), y: 0 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .clip(true)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })

        // Horizontal pager using Swiper
        Swiper() {
          CourseList({ title: 'All Courses', count: 6 })
          CourseList({ title: 'Enrolled', count: 3 })
          CourseList({ title: 'Completed', count: 4 })
        }
        .index(this.selectedTabIndex)
        .indicator(false)
        .loop(false)
        .curve(Curve.EaseInOut)
        .onChange((index: number): void => {
          this.selectedTabIndex = index;
        })
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
  }
}
