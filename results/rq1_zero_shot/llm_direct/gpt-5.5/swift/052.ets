import { window } from '@kit.ArkUI';

interface AppColorTokens {
  primary: ResourceColor;
  secondary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  outline: ResourceColor;
  onPrimary: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographySpec {
  size: number;
  weight: FontWeight;
}

interface AppTypographyTokens {
  display: TypographySpec;
  headline: TypographySpec;
  body: TypographySpec;
}

interface ShapeSpec {
  radius: number;
}

interface AppShapeTokens {
  small: ShapeSpec;
  medium: ShapeSpec;
  large: ShapeSpec;
}

interface AppSpacingTokens {
  sm: number;
  md: number;
  lg: number;
}

interface ShadowSpec {
  blurRadius: number;
  yOffset: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ShadowSpec;
}

class AppTokens {
  static readonly Colors: AppColorTokens = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111'
  };

  static readonly TypographyTokens: AppTypographyTokens = {
    display: {
      size: 28,
      weight: FontWeight.Bold
    },
    headline: {
      size: 18,
      weight: FontWeight.Medium
    },
    body: {
      size: 14,
      weight: FontWeight.Regular
    }
  };

  static readonly Shapes: AppShapeTokens = {
    small: {
      radius: 6
    },
    medium: {
      radius: 10
    },
    large: {
      radius: 14
    }
  };

  static readonly Spacing: AppSpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16
  };

  static readonly ElevationMapping: ElevationTokens = {
    level1: {
      blurRadius: 4,
      yOffset: 2,
      opacity: 0.1
    }
  };

  static readonly ShadowLevel1Color: ResourceColor = '#1A000000';
}

@Entry
@Component
struct CourseCatalogApp {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private swiperController: SwiperController = new SwiperController();

  @State selectedTabIndex: number = 0;

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: $selectedTabIndex,
          onSelect: (index: number): void => {
            animateTo({
              duration: 200,
              curve: Curve.EaseInOut
            }, () => {
              this.selectedTabIndex = index;
            });
            this.swiperController.changeIndex(index, true);
          }
        })
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small.radius)

        Swiper(this.swiperController) {
          CourseList({
            title: 'All Courses',
            count: 6
          })

          CourseList({
            title: 'Enrolled',
            count: 3
          })

          CourseList({
            title: 'Completed',
            count: 4
          })
        }
        .index(this.selectedTabIndex)
        .indicator(false)
        .loop(false)
        .layoutWeight(1)
        .width('100%')
        .onChange((index: number) => {
          animateTo({
            duration: 200,
            curve: Curve.EaseInOut
          }, () => {
            this.selectedTabIndex = index;
          });
        })
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
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;
  onSelect: (index: number) => void = (index: number): void => {};

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.size : AppTokens.TypographyTokens.body.size)
            .fontWeight(this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.weight : AppTokens.TypographyTokens.body.weight)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({
              top: AppTokens.Spacing.md,
              bottom: AppTokens.Spacing.md
            })

          Blank()
            .height(2)
            .width('100%')
            .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          if (this.selectedTabIndex !== index) {
            this.onSelect(index);
          }
        })
      }, (tab: string, index: number) => `${tab}_${index}`)
    }
    .width('100%')
    .animation({
      duration: 200,
      curve: Curve.EaseInOut
    })
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  private getCourses(): number[] {
    const courses: number[] = [];
    for (let i = 1; i <= this.count; i++) {
      courses.push(i);
    }
    return courses;
  }

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(this.getCourses(), (courseNumber: number) => {
          CourseCard({
            courseNumber: courseNumber
          })
        }, (courseNumber: number) => courseNumber.toString())
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct CourseCard {
  courseNumber: number = 1;

  build() {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          Text(`Course ${this.courseNumber}`)
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.primary)

          Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Text('View')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .height(24)
          .padding({
            left: 12,
            right: 12
          })
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium.radius)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: AppTokens.ShadowLevel1Color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.yOffset
    })
  }
}