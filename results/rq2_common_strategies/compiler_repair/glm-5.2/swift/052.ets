interface ColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  outline: ResourceColor;
  onPrimary: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographyType {
  display: FontInfo;
  headline: FontInfo;
  body: FontInfo;
}

interface FontInfo {
  size: Length;
  weight: FontWeight;
}

interface ShapesType {
  small: Length;
  medium: Length;
  large: Length;
}

interface SpacingType {
  sm: Length;
  md: Length;
  lg: Length;
}

interface ShadowSpecType {
  blurRadius: number;
  yOffset: number;
  opacity: number;
  color: ResourceColor;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
}

class AppTokens {
  static Colors: ColorsType = {
    primary: '#FF111111',
    secondary: '#FF444444',
    background: '#FFF5F5F5',
    surface: '#FFFFFFFF',
    outline: '#FFCCCCCC',
    onPrimary: '#FFFFFFFF',
    onSurface: '#FF111111'
  };

  static TypographyTokens: TypographyType = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular }
  };

  static Shapes: ShapesType = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing: SpacingType = {
    sm: 8,
    md: 12,
    lg: 16
  };

  static ElevationMapping: ElevationMappingType = {
    level1: { blurRadius: 4, yOffset: 2, opacity: 0.1, color: '#000000' }
  };
}

@Entry
@Component
struct RootScreen {
  @State private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State private selectedTabIndex: number = 0;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppTokens.Spacing.lg })

        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: this.selectedTabIndex,
          onTabSelected: (index: number) => {
            this.selectedTabIndex = index;
          }
        })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .clip(true)

        if (this.selectedTabIndex === 0) {
          CourseList({ title: 'All Courses', count: 6 })
        } else if (this.selectedTabIndex === 1) {
          CourseList({ title: 'Enrolled', count: 3 })
        } else if (this.selectedTabIndex === 2) {
          CourseList({ title: 'Completed', count: 4 })
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CustomTabRow {
  private tabs: string[] = [];
  @Prop selectedTabIndex: number = 0;
  private onTabSelected: (index: number) => void = () => {};

  build() {
    Row({ space: 0 }) {
      ForEach(this.tabs, (tab: string, index: number) => {
        Button({ type: ButtonType.Normal }) {
          Column({ space: 0 }) {
            Text(tab)
              .fontSize(this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.size : AppTokens.TypographyTokens.body.size)
              .fontWeight(this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.weight : AppTokens.TypographyTokens.body.weight)
              .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .width('100%')
              .textAlign(TextAlign.Center)

            Row()
              .width('100%')
              .height(2)
              .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
          }
          .width('100%')
        }
        .onClick(() => {
          this.onTabSelected(index);
        })
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
      })
    }
    .width('100%')
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

@Component
struct CourseList {
  private title: string = '';
  private count: number = 0;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(this.generateArray(this.count), (item: number) => {
          CourseCard({ courseNumber: item })
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
  }

  private generateArray(count: number): number[] {
    let arr: number[] = [];
    for (let i = 1; i <= count; i++) {
      arr.push(i);
    }
    return arr;
  }
}

@Component
struct CourseCard {
  private courseNumber: number = 0;

  build() {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Course ' + this.courseNumber)
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.primary)

          Text('Duration: ' + (5 + this.courseNumber - 1) + ' hrs')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('View')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 12, right: 12 })
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: AppTokens.ElevationMapping.level1.color as string,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.yOffset
    })
  }
}