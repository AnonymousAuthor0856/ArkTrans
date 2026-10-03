class AppColors {
  static readonly primary: ResourceColor = '#111111'
  static readonly secondary: ResourceColor = '#444444'
  static readonly background: ResourceColor = '#F5F5F5'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly outline: ResourceColor = '#CCCCCC'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSurface: ResourceColor = '#111111'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 18
  static readonly bodySize: number = 14
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

class ShapeToken {
  radius: number

  constructor(radius: number) {
    this.radius = radius
  }
}

class AppShapes {
  static readonly small: ShapeToken = new ShapeToken(6)
  static readonly medium: ShapeToken = new ShapeToken(10)
  static readonly large: ShapeToken = new ShapeToken(14)
}

class ShadowSpec {
  blurRadius: number
  yOffset: number
  opacityColor: ResourceColor

  constructor(blurRadius: number, yOffset: number, opacityColor: ResourceColor) {
    this.blurRadius = blurRadius
    this.yOffset = yOffset
    this.opacityColor = opacityColor
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 2, '#1A000000')
}

function makeCourseNumbers(count: number): number[] {
  const result: number[] = []
  for (let index = 1; index <= count; index++) {
    result.push(index)
  }
  return result
}

@Entry
@Component
struct CourseCatalogApp {
  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  @State selectedTabIndex: number = 0

  build() {
    Stack() {
      Column({ space: AppSpacing.md }) {
        Text('Course Catalog')
          .width('100%')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Start)

        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: $selectedTabIndex
        })

        if (this.selectedTabIndex === 0) {
          CourseList({
            title: 'All Courses',
            count: 6
          })
        } else if (this.selectedTabIndex === 1) {
          CourseList({
            title: 'Enrolled',
            count: 3
          })
        } else {
          CourseList({
            title: 'Completed',
            count: 4
          })
        }
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
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct CustomTabRow {
  @Prop tabs: string[] = []
  @Link selectedTabIndex: number

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          Text(tab)
            .width('100%')
            .fontSize(this.selectedTabIndex === index ? AppTypography.headlineSize : AppTypography.bodySize)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.Bold : FontWeight.Regular)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.secondary)
            .textAlign(TextAlign.Center)
            .padding({
              top: AppSpacing.md,
              bottom: AppSpacing.md
            })

          Divider()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index
        })
      }, (tab: string) => tab)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small.radius)
  }
}

@Component
struct CourseList {
  @Prop title: string = ''
  @Prop count: number = 0

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        Text(this.title)
          .width('100%')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.Start)

        ForEach(makeCourseNumbers(this.count), (courseNumber: number) => {
          CourseCard({
            courseNumber: courseNumber
          })
        }, (courseNumber: number) => courseNumber.toString())
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct CourseCard {
  @Prop courseNumber: number = 1

  build() {
    Row() {
      Column({ space: AppSpacing.sm }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .height(24)
        .padding({
          left: 12,
          right: 12
        })
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium.radius)
    .shadow({
      radius: AppElevation.level1.blurRadius,
      color: AppElevation.level1.opacityColor,
      offsetX: 0,
      offsetY: AppElevation.level1.yOffset
    })
  }
}