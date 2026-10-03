import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: ResourceColor = 0xFF111111;
  static readonly secondary: ResourceColor = 0xFF444444;
  static readonly background: ResourceColor = 0xFFF5F5F5;
  static readonly surface: ResourceColor = 0xFFFFFFFF;
  static readonly outline: ResourceColor = 0xFFCCCCCC;
  static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  static readonly onSurface: ResourceColor = 0xFF111111;
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
}

class AppShapes {
  static readonly smallRadius: number = 6;
  static readonly mediumRadius: number = 10;
  static readonly largeRadius: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AppElevation {
  static readonly level1BlurRadius: number = 4;
  static readonly level1YOffset: number = 2;
  static readonly level1Opacity: number = 0.1;
}

// MARK: - CourseCard Component
@Component
struct CourseCard {
  courseNumber: number = 1;

  build() {
    Row() {
      Column() {
        Text(`Course ${this.courseNumber}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.primary)
          .margin({ bottom: AppSpacing.sm })

        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.mediumRadius)
    .shadow({
      color: `rgba(0,0,0,${AppElevation.level1Opacity})`,
      radius: AppElevation.level1BlurRadius,
      offsetX: 0,
      offsetY: AppElevation.level1YOffset
    })
  }
}

// MARK: - CourseList Component
@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column() {
        Text(this.title)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.secondary)
          .width('100%')
          .margin({ bottom: AppSpacing.md })

        ForEach(
          Array.from({ length: this.count }, (_, i) => i + 1),
          (item: number) => {
            CourseCard({ courseNumber: item })
              .margin({ bottom: AppSpacing.md })
          },
          (item: number) => item.toString()
        )
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .scrollBar(BarState.Off)
  }
}

// MARK: - CustomTabRow Component
@Component
struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Row() {
      ForEach(
        this.tabs,
        (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(
                this.selectedTabIndex === index
                  ? AppTypography.headlineSize
                  : AppTypography.bodySize
              )
              .fontWeight(
                this.selectedTabIndex === index
                  ? AppTypography.headlineWeight
                  : AppTypography.bodyWeight
              )
              .fontColor(
                this.selectedTabIndex === index
                  ? AppColors.primary
                  : AppColors.secondary
              )
              .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
              .width('100%')
              .textAlign(TextAlign.Center)

            Divider()
              .strokeWidth(2)
              .color(
                this.selectedTabIndex === index
                  ? AppColors.primary
                  : Color.Transparent
              )
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTabIndex = index;
          })
          .animation({
            duration: 200,
            curve: Curve.EaseInOut
          })
        },
        (tab: string) => tab
      )
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.smallRadius)
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State private selectedTabIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  build() {
    Stack() {
      Column() {
        Text('Course Catalog')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: AppSpacing.md })

        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: $selectedTabIndex
        })
          .margin({ bottom: AppSpacing.md })

        Tabs({
          index: this.selectedTabIndex,
          controller: this.tabsController
        }) {
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
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
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
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}