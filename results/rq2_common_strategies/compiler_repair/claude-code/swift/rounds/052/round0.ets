import prompt from '@ohos.promptAction';

// MARK: - AppTokens
class AppTokens {
  static class Colors {
    static readonly primary: Color = Color('#FF111111');
    static readonly secondary: Color = Color('#FF444444');
    static readonly background: Color = Color('#FFF5F5F5');
    static readonly surface: Color = Color('#FFFFFFFF');
    static readonly outline: Color = Color('#FFCCCCCC');
    static readonly onPrimary: Color = Color('#FFFFFFFF');
    static readonly onSurface: Color = Color('#FF111111');
  }

  static class TypographyTokens {
    static readonly displaySize: number = 28;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly headlineSize: number = 18;
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;
  }

  static class Shapes {
    static readonly small: number = 6;
    static readonly medium: number = 10;
    static readonly large: number = 14;
  }

  static class Spacing {
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
  }

  static class ElevationMapping {
    static readonly level1Radius: number = 4;
    static readonly level1Y: number = 2;
    static readonly level1Opacity: number = 0.1;
  }
}

// MARK: - CourseCard
@Component
struct CourseCard {
  @Prop courseNumber: number = 1;

  build() {
    Column() {
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
    }
    .width('100%')
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

        ForEach(Array.from({ length: this.count }, (_, i) => i + 1), (item: number) => {
          CourseCard({ courseNumber: item })
        }, (item: number) => item.toString())
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

  private tabUnderlineOffset(index: number): number {
    return index * (100 / this.tabs.length);
  }

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
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
            .onClick(() => {
              this.selectedTabIndex = index;
            })
        }, (tab: string, index: number) => `${tab}_${index}`)
      }
      .width('100%')

      // Underline indicator
      Rectangle()
        .width(`${100 / this.tabs.length}%`)
        .height(2)
        .fill(AppTokens.Colors.primary)
        .translate({ x: `${this.tabUnderlineOffset(this.selectedTabIndex)}%` })
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
      Rectangle()
        .width('100%')
        .height('100%')
        .fill(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })

        // Horizontal pager using Swiper
        Swiper(this.selectedTabIndex) {
          CourseList({ title: 'All Courses', count: 6 })
          CourseList({ title: 'Enrolled', count: 3 })
          CourseList({ title: 'Completed', count: 4 })
        }
        .index(this.selectedTabIndex)
        .indicator(false)
        .loop(false)
        .curve(Curve.EaseInOut)
        .onChange((index: number) => {
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
