const NAME: string = "076*CourseCatalog*en";
const UI_TYPE: string = "Education";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#444444';
  static readonly background: string = '#F5F5F5';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CCCCCC';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#111111';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class CourseTab {
  title: string;
  heading: string;
  count: number;

  constructor(title: string, heading: string, count: number) {
    this.title = title;
    this.heading = heading;
    this.count = count;
  }
}

@Entry
@Component
struct MainActivity {
  @State selectedTab: number = 0;

  private tabs: CourseTab[] = [
    new CourseTab('All', 'All Courses', 6),
    new CourseTab('Enrolled', 'Enrolled', 3),
    new CourseTab('Completed', 'Completed', 4)
  ];

  @Builder
  TabStrip() {
    Row() {
      ForEach(this.tabs, (tab: CourseTab, index: number) => {
        Column() {
          Text(tab.title)
            .fontSize(this.selectedTab === index ? 18 : 14)
            .fontWeight(this.selectedTab === index ? FontWeight.SemiBold : FontWeight.Normal)
            .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.secondary)
            .textAlign(TextAlign.Center)
            .width('100%')
          Rect()
            .width(this.selectedTab === index ? 42 : 0)
            .height(3)
            .fill(AppColors.primary)
            .radius(2)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .height(54)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedTab = index;
        })
      })
    }
    .width('100%')
    .height(58)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  CourseList(title: string, count: number) {
    Column({ space: AppSpacing.md }) {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.secondary)
        .width('100%')

      ForEach(Array.from({ length: count }), (_: number, index: number) => {
        Row() {
          Column({ space: AppSpacing.sm }) {
            Text(`Course ${index + 1}`)
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.primary)
            Text(`Duration: ${5 + index} hrs`)
              .fontSize(14)
              .fontColor(AppColors.secondary)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Text('View')
            .fontSize(14)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 12, right: 12 })
            .height(24)
            .lineHeight(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(12)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(10)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
      })
    }
    .width('100%')
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')

      this.TabStrip()

      Scroll() {
        Column() {
          this.CourseList(this.tabs[this.selectedTab].heading, this.tabs[this.selectedTab].count)
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}
