// MARK: - AppTokens

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  blurRadius: number;
  yOffset: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    body: { size: 14, weight: FontWeight.Regular },
  };

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { blurRadius: 4, yOffset: 2, opacity: 0.1 },
  };
}

@Component
struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Button() {
          Column() {
            Text(tab)
              .fontSize(this.selectedTabIndex === index ? AppTokens.Typography.headline.size : AppTokens.Typography.body.size)
              .fontWeight(this.selectedTabIndex === index ? AppTokens.Typography.headline.weight : AppTokens.Typography.body.weight)
              .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .width('100%')
              .textAlign(TextAlign.Center)

            if (this.selectedTabIndex === index) {
              Row()
                .height(2)
                .width('100%')
                .backgroundColor(AppTokens.Colors.primary)
            } else {
              Row()
                .height(2)
                .width('100%')
                .backgroundColor('#00000000')
            }
          }
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index;
        })
      }, (tab: string, index: number) => index.toString())
    }
    .width('100%')
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  private get indices(): number[] {
    const result: number[] = [];
    for (let i = 0; i < this.count; i++) {
      result.push(i);
    }
    return result;
  }

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.secondary)

        ForEach(this.indices, (index: number) => {
          CourseCard({ courseNumber: index + 1 })
        }, (index: number) => index.toString())
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CourseCard {
  courseNumber: number = 0;

  build() {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Course ' + this.courseNumber)
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.primary)
          Text('Duration: ' + (5 + this.courseNumber - 1) + ' hrs')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('View')
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 12, right: 12 })
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
      }
      .alignItems(VerticalAlign.Center)
      .padding(AppTokens.Spacing.md)
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.yOffset
    })
    .width('100%')
  }
}

@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({ tabs: this.tabs, selectedTabIndex: this.selectedTabIndex })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)

        Tabs({ barPosition: BarPosition.End, index: this.selectedTabIndex }) {
          TabContent() {
            CourseList({ title: 'All Courses', count: 6 })
          }
          TabContent() {
            CourseList({ title: 'Enrolled', count: 3 })
          }
          TabContent() {
            CourseList({ title: 'Completed', count: 4 })
          }
        }
        .barHeight(0)
        .layoutWeight(1)
        .onChange((index: number) => {
          this.selectedTabIndex = index;
        })
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) + ignoresSafeArea in SwiftUI -> full-screen root.
    RootScreen()
  }
}
