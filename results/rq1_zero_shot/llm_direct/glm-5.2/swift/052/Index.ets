// AppTokens.ets
export class AppTokens {
  static Colors = {
    primary: '#FF111111',
    secondary: '#FF444444',
    background: '#FFF5F5F5',
    surface: '#FFFFFFFF',
    outline: '#FFCCCCCC',
    onPrimary: '#FFFFFFFF',
    onSurface: '#FF111111'
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  };

  static ElevationMapping = {
    level1: { blurRadius: 4, yOffset: 2, opacity: 0.1, color: '#000000' }
  };
}

// Helper to build font
function fontToken(token: { size: number, weight: FontWeight }) {
  return { size: token.size, weight: token.weight };
}

// RootScreen.ets
@Component
export struct RootScreen {
  @State tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Content
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(fontToken(AppTokens.TypographyTokens.display).size)
          .fontWeight(fontToken(AppTokens.TypographyTokens.display).weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

        // Custom Tab Row
        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: this.selectedTabIndex,
          onTabSelected: (index: number) => {
            this.selectedTabIndex = index;
          }
        })
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .clip(true)

        // Pager Content
        Column() {
          if (this.selectedTabIndex === 0) {
            CourseList({ title: 'All Courses', count: 6 })
          } else if (this.selectedTabIndex === 1) {
            CourseList({ title: 'Enrolled', count: 3 })
          } else if (this.selectedTabIndex === 2) {
            CourseList({ title: 'Completed', count: 4 })
          }
        }
        .layoutWeight(1)
        .width('100%')
        .animation({ duration: 200, curve: Curve.EaseInOut })
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.All])
  }
}

// CustomTabRow.ets
@Component
export struct CustomTabRow {
  tabs: string[] = [];
  selectedTabIndex: number = 0;
  onTabSelected: (index: number) => void = () => {};

  build() {
    Row({ space: 0 }) {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? fontToken(AppTokens.TypographyTokens.headline).size : fontToken(AppTokens.TypographyTokens.body).size)
            .fontWeight(this.selectedTabIndex === index ? fontToken(AppTokens.TypographyTokens.headline).weight : fontToken(AppTokens.TypographyTokens.body).weight)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .textAlign(TextAlign.Center)

          // Underline indicator
          Divider()
            .stroke(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
            .color(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
            .height(2)
            .width('100%')
        }
        .layoutWeight(1)
        .onClick(() => {
          this.onTabSelected(index);
        })
        .animation({ duration: 200, curve: Curve.EaseInOut })
      })
    }
    .width('100%')
  }
}

// CourseList.ets
@Component
export struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(fontToken(AppTokens.TypographyTokens.headline).size)
          .fontWeight(fontToken(AppTokens.TypographyTokens.headline).weight)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')

        ForEach(Array.from({ length: this.count }, (_, i) => i + 1), (num: number) => {
          CourseCard({ courseNumber: num })
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
    .width('100%')
  }
}

// CourseCard.ets
@Component
export struct CourseCard {
  courseNumber: number = 0;

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(fontToken(AppTokens.TypographyTokens.headline).size)
          .fontWeight(fontToken(AppTokens.TypographyTokens.headline).weight)
          .fontColor(AppTokens.Colors.primary)

        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(fontToken(AppTokens.TypographyTokens.body).size)
          .fontWeight(fontToken(AppTokens.TypographyTokens.body).weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // View Button
      Text('View')
        .fontSize(fontToken(AppTokens.TypographyTokens.body).size)
        .fontWeight(fontToken(AppTokens.TypographyTokens.body).weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12) // Capsule approximation
        .height(24)
        .padding({ left: 12, right: 12 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: AppTokens.ElevationMapping.level1.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.yOffset
    })
  }
}