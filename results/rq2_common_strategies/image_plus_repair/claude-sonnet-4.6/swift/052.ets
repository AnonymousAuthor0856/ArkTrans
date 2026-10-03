// AppTokens
class ColorsToken {
  primary: string = '#FF111111';
  secondary: string = '#FF444444';
  background: string = '#FFF5F5F5';
  surface: string = '#FFFFFFFF';
  outline: string = '#FFCCCCCC';
  onPrimary: string = '#FFFFFFFF';
  onSurface: string = '#FF111111';
}

class SpacingToken {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
}

class ShapesToken {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

class ShadowLevel {
  blurRadius: number = 4;
  yOffset: number = 2;
  opacity: number = 0.1;
}

class ShadowToken {
  level1: ShadowLevel = new ShadowLevel();
}

const Colors: ColorsToken = new ColorsToken();
const Spacing: SpacingToken = new SpacingToken();
const Shapes: ShapesToken = new ShapesToken();
const Shadow: ShadowToken = new ShadowToken();

@Entry
@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: Spacing.md })

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: this.selectedTabIndex,
        onTabSelected: (index: number) => {
          this.selectedTabIndex = index;
          this.tabsController.changeIndex(index);
        }
      })
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.small)
        .margin({ bottom: Spacing.md })

      Tabs({ barPosition: BarPosition.Start, index: this.selectedTabIndex, controller: this.tabsController }) {
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
      .animationDuration(200)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
  }
}

@Component
struct CustomTabRow {
  tabs: string[] = [];
  @Prop selectedTabIndex: number = 0;
  onTabSelected: (index: number) => void = () => {};

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? 18 : 14)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedTabIndex === index ? Colors.primary : Colors.secondary)
            .padding({ top: Spacing.md, bottom: Spacing.md })
            .width('100%')
            .textAlign(TextAlign.Center)

          Divider()
            .strokeWidth(2)
            .color(this.selectedTabIndex === index ? Colors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.onTabSelected(index);
        })
      })
    }
    .width('100%')
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column({ space: Spacing.md }) {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(Array.from({ length: this.count }, (_: Object, i: number) => i), (index: number) => {
          CourseCard({ courseNumber: index + 1 })
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ bottom: Spacing.md })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CourseCard {
  courseNumber: number = 1;

  build() {
    Row() {
      Column({ space: Spacing.sm }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Text(`Duration: ${4 + this.courseNumber} hrs`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(14)
        .fontColor(Colors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(32)
        .backgroundColor(Colors.primary)
        .borderRadius(16)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.medium)
    .shadow({
      color: `rgba(0,0,0,${Shadow.level1.opacity})`,
      radius: Shadow.level1.blurRadius,
      offsetX: 0,
      offsetY: Shadow.level1.yOffset,
    })
    .alignItems(VerticalAlign.Center)
  }
}