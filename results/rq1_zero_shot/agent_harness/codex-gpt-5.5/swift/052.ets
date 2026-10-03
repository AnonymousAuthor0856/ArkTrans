class AppColors {
  static primary: string = '#111111';
  static secondary: string = '#444444';
  static background: string = '#F5F5F5';
  static surface: string = '#FFFFFF';
  static outline: string = '#CCCCCC';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#111111';
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
}

@Entry
@Component
struct RootScreen {
  @State private selectedTabIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];

  private titleForIndex(index: number): string {
    if (index === 0) {
      return 'All Courses';
    }
    if (index === 1) {
      return 'Enrolled';
    }
    return 'Completed';
  }

  private countForIndex(index: number): number {
    if (index === 0) {
      return 6;
    }
    if (index === 1) {
      return 3;
    }
    return 4;
  }

  @Builder
  private CustomTabRow() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column({ space: 0 }) {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? 18 : 14)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.SemiBold : FontWeight.Regular)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.secondary)
            .width('100%')
            .height(46)
            .textAlign(TextAlign.Center)
          Rect()
            .width('100%')
            .height(2)
            .fill(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index;
        })
      })
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
  }

  @Builder
  private CourseList(title: string, count: number) {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(Array.from({ length: count }, (_: Object, index: number) => index + 1), (courseNumber: number) => {
          this.CourseCard(courseNumber)
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  private CourseCard(courseNumber: number) {
    Row() {
      Column({ space: AppSpacing.sm }) {
        Text(`Course ${courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.primary)
        Text(`Duration: ${5 + courseNumber - 1} hrs`)
          .fontSize(14)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(14)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .textAlign(TextAlign.Center)
    }
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)

      this.CustomTabRow()

      this.CourseList(this.titleForIndex(this.selectedTabIndex), this.countForIndex(this.selectedTabIndex))
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
