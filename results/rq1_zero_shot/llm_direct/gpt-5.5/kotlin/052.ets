const NAME: string = '076*CourseCatalog*en';
const UI_TYPE: string = 'Education';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#444444';
  static readonly background: string = '#F5F5F5';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CCCCCC';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#111111';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 18;
  static readonly bodySize: number = 14;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
}

@Component
struct CourseCard {
  index: number = 0;

  build() {
    Row() {
      Column({ space: AppSpacing.sm }) {
        Text(`Course ${this.index + 1}`)
          .fontSize(AppTypographyTokens.headlineSize)
          .fontWeight(AppTypographyTokens.headlineWeight)
          .fontColor(AppColors.primary)

        Text(`Duration: ${5 + this.index} hrs`)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(AppTypographyTokens.bodyWeight)
          .fontColor(AppColors.secondary)
      }

      Row() {
        Text('View')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(AppTypographyTokens.bodyWeight)
          .fontColor(AppColors.onPrimary)
      }
      .height(24)
      .padding({ left: 12, right: 12 })
      .borderRadius(12)
      .backgroundColor(AppColors.primary)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  private getItems(): number[] {
    return Array.from({ length: this.count }, (_: Object, index: number) => index);
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text(this.title)
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.secondary)
        .width('100%')

      ForEach(this.getItems(), (item: number) => {
        CourseCard({ index: item })
      }, (item: number) => item.toString())
    }
    .width('100%')
  }
}

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0;

  @Builder
  tabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(this.currentIndex === index ? AppTypographyTokens.headlineSize : AppTypographyTokens.bodySize)
        .fontWeight(this.currentIndex === index ? AppTypographyTokens.headlineWeight : AppTypographyTokens.bodyWeight)
        .fontColor(this.currentIndex === index ? AppColors.primary : AppColors.secondary)

      Divider()
        .width(32)
        .height(2)
        .margin({ top: 6 })
        .backgroundColor(this.currentIndex === index ? AppColors.primary : 'transparent')
    }
    .height(48)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.surface)
    .onClick(() => {
      this.currentIndex = index;
    })
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Course Catalog')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(AppTypographyTokens.displayWeight)
        .fontColor(AppColors.primary)
        .width('100%')

      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        TabContent() {
          CourseList({ title: 'All Courses', count: 6 })
        }
        .tabBar(this.tabBuilder('All', 0))

        TabContent() {
          CourseList({ title: 'Enrolled', count: 3 })
        }
        .tabBar(this.tabBuilder('Enrolled', 1))

        TabContent() {
          CourseList({ title: 'Completed', count: 4 })
        }
        .tabBar(this.tabBuilder('Completed', 2))
      }
      .width('100%')
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .animationDuration(300)
      .backgroundColor(AppColors.background)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}