// entry/src/main/ets/pages/Index.ets
// NAME: 076*CourseCatalog*en
// UI_TYPE: Education
// STYLE_THEME: Monochrome
// LANG: en
// BASELINE_SIZE: 720x1280

import { window } from '@kit.ArkUI';

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
  static readonly tabSelectedBg: string = '#E8E8E8';
  static readonly shadowColor: string = 'rgba(0, 0, 0, 0.10)';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: FontWeight = FontWeight.Bold;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
}

@Entry
@Component
struct CourseCatalogPage {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private readonly titles: string[] = ['All', 'Enrolled', 'Completed'];
  private readonly sectionTitles: string[] = ['All Courses', 'Enrolled', 'Completed'];
  private readonly sectionCounts: number[] = [6, 3, 4];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch((err: Error) => {
      console.error(`window setup failed: ${err.message}`);
    });
  }

  private makeRange(count: number): number[] {
    const result: number[] = [];
    for (let i = 0; i < count; i++) {
      result.push(i);
    }
    return result;
  }

  @Builder
  TabBarItem(title: string, index: number) {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text(title)
          .fontSize(this.currentIndex === index ? AppTypography.headlineSize : AppTypography.bodySize)
          .fontWeight(this.currentIndex === index
            ? AppTypography.headlineWeight
            : AppTypography.bodyWeight)
          .fontColor(this.currentIndex === index ? AppColors.primary : AppColors.secondary)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)

      if (this.currentIndex === index) {
        Row()
          .width('100%')
          .height(ElevationMapping.level1.elevation)
          .backgroundColor(AppColors.primary)
      }
    }
    .height(48)
    .layoutWeight(1)
    .backgroundColor(this.currentIndex === index ? AppColors.tabSelectedBg : AppColors.surface)
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(index);
    })
  }

  @Builder
  TabBar() {
    Row() {
      ForEach(this.titles, (title: string, index: number) => {
        this.TabBarItem(title, index);
      }, (title: string) => title)
    }
    .width('100%')
    .height(48)
    .border({ width: { bottom: 1 }, color: AppColors.outline })
  }

  @Builder
  CourseCard(index: number) {
    Row() {
      Column() {
        Text(`Course ${index + 1}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.primary)
        Text(`Duration: ${index + 5} hrs`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.secondary)
          .margin({ top: AppSpacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Text('View')
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onPrimary)
      }
      .height(24)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.large)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: AppColors.shadowColor,
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  @Builder
  CourseList(title: string, count: number) {
    Column() {
      Text(title)
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.secondary)
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      List({ space: AppSpacing.md }) {
        ForEach(this.makeRange(count), (index: number) => {
          ListItem() {
            this.CourseCard(index);
          }
        }, (index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.primary)
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      this.TabBar();

      Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
        ForEach(this.titles, (title: string, index: number) => {
          TabContent() {
            this.CourseList(this.sectionTitles[index], this.sectionCounts[index]);
          }
        }, (title: string) => title)
      }
      .barHeight(0)
      .layoutWeight(1)
      .margin({ top: AppSpacing.md })
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
    .alignItems(HorizontalAlign.Start)
  }
}