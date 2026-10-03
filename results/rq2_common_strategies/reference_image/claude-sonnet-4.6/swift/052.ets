// ============================================================================
// Index.ets  —  Course Catalog
// SwiftUI → ArkTS (ArkUI / HarmonyOS) 1:1 port
// ============================================================================

// MARK: - AppTokens

export class AppColors {
  static readonly primary: string = '#FF111111';
  static readonly secondary: string = '#FF444444';
  static readonly background: string = '#FFF5F5F5';
  static readonly surface: string = '#FFFFFFFF';
  static readonly outline: string = '#FFCCCCCC';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSurface: string = '#FF111111';
  static readonly shadow: string = '#1A000000'; // black @ 10% opacity
}

export class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
}

export class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

export class AppShapes {
  static readonly small: number = 6;   // RoundedCornerStyle.continuous -> plain radius in ArkUI
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

export class AppElevation {
  // ShadowSpec(blurRadius: 4, yOffset: 2, opacity: 0.1)
  static readonly level1Radius: number = 4;
  static readonly level1OffsetY: number = 2;
  static readonly level1Color: string = AppColors.shadow;
}

// MARK: - CourseCard

@Component
struct CourseCard {
  @Prop courseNumber: number = 1;

  build() {
    Row() {
      Column() {
        Text(`Course ${this.courseNumber}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.primary)

        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.secondary)
          .margin({ top: AppSpacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .height(24)
        .padding({ left: 12, right: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(12) // Capsule on a 24vp-tall box
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppElevation.level1Radius,
      color: AppElevation.level1Color,
      offsetX: 0,
      offsetY: AppElevation.level1OffsetY
    })
  }
}

// MARK: - CourseList

@Component
struct CourseList {
  @Prop title: string = '';
  @Prop count: number = 0;
  @State items: number[] = [];

  aboutToAppear(): void {
    const generated: number[] = [];
    for (let i = 1; i <= this.count; i++) {
      generated.push(i);
    }
    this.items = generated;
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: AppSpacing.md })

      List({ space: AppSpacing.md }) {
        ForEach(this.items, (item: number) => {
          ListItem() {
            CourseCard({ courseNumber: item })
          }
        }, (item: number) => `course-${this.title}-${item}`)
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
}

// MARK: - CustomTabRow

@Component
struct CustomTabRow {
  @Link selectedTabIndex: number;
  tabs: string[] = [];

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? AppTypography.headlineSize : AppTypography.bodySize)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.secondary)
            .width('100%')
            .height(46)
            .textAlign(TextAlign.Center)

          // Underline indicator
          Row()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .height(48)
        .onClick(() => {
          animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
            this.selectedTabIndex = index;
          });
        })
      }, (tab: string, index: number) => `tab-${index}-${tab}-${this.selectedTabIndex === index}`)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small)
    .clip(true)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;

  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private pageTitles: string[] = ['All Courses', 'Enrolled', 'Completed'];
  private pageCounts: number[] = [6, 3, 4];

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Course Catalog')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex
      })

      // HorizontalPager equivalent
      Swiper() {
        ForEach(this.tabs, (tab: string, index: number) => {
          CourseList({
            title: this.pageTitles[index],
            count: this.pageCounts[index]
          })
        }, (tab: string, index: number) => `page-${index}-${tab}`)
      }
      .index(this.selectedTabIndex)
      .loop(false)
      .indicator(false)
      .layoutWeight(1)
      .width('100%')
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
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