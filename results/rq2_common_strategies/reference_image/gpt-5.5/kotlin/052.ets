const NAME: string = '076*CourseCatalog*en'
const UI_TYPE: string = 'Education'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly PRIMARY: string = '#111111'
  static readonly SECONDARY: string = '#444444'
  static readonly BACKGROUND: string = '#F5F5F5'
  static readonly SURFACE: string = '#FFFFFF'
  static readonly OUTLINE: string = '#CCCCCC'
  static readonly SELECTED_TAB: string = '#E8E8E8'
  static readonly ON_PRIMARY: string = '#FFFFFF'
  static readonly CARD_BORDER: string = '#EEEEEE'
  static readonly SHADOW: string = '#1A000000'
}

class AppSpacing {
  static readonly SM: number = 8
  static readonly MD: number = 12
  static readonly LG: number = 16
}

class CoursePageData {
  title: string
  count: number

  constructor(title: string, count: number) {
    this.title = title
    this.count = count
  }
}

@Component
struct CourseCard {
  @Prop index: number = 0

  build() {
    Row() {
      Column({ space: AppSpacing.SM }) {
        Text(`Course ${this.index + 1}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.PRIMARY)

        Text(`Duration: ${5 + this.index} hrs`)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)

      Text('View')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.ON_PRIMARY)
        .height(24)
        .padding({ left: 12, right: 12 })
        .backgroundColor(AppColors.PRIMARY)
        .borderRadius(12)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.MD)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.SURFACE)
    .borderRadius(10)
    .border({ width: 0.5, color: AppColors.CARD_BORDER })
    .shadow({
      radius: 4,
      color: AppColors.SHADOW,
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct CourseList {
  @Prop title: string = ''
  @Prop count: number = 0

  private courseIndexes(): number[] {
    const items: number[] = []
    for (let i = 0; i < this.count; i++) {
      items.push(i)
    }
    return items
  }

  build() {
    Column({ space: AppSpacing.MD }) {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.SECONDARY)
        .width('100%')

      ForEach(this.courseIndexes(), (item: number) => {
        CourseCard({ index: item })
      }, (item: number) => item.toString())
    }
    .width('100%')
  }
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  private pages: CoursePageData[] = [
    new CoursePageData('All Courses', 6),
    new CoursePageData('Enrolled', 3),
    new CoursePageData('Completed', 4)
  ]

  private currentTitle(): string {
    return this.pages[this.selectedIndex].title
  }

  private currentCount(): number {
    return this.pages[this.selectedIndex].count
  }

  build() {
    Column({ space: AppSpacing.MD }) {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.PRIMARY)
        .width('100%')

      Row() {
        ForEach(this.tabs, (item: string, index: number) => {
          Column() {
            Row() {
              Text(item)
                .fontSize(this.selectedIndex === index ? 18 : 14)
                .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
                .fontColor(this.selectedIndex === index ? AppColors.PRIMARY : AppColors.SECONDARY)
            }
            .width('100%')
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Blank()
              .width('100%')
              .height(2)
              .backgroundColor(this.selectedIndex === index ? AppColors.PRIMARY : AppColors.OUTLINE)
          }
          .height('100%')
          .layoutWeight(1)
          .backgroundColor(this.selectedIndex === index ? AppColors.SELECTED_TAB : AppColors.SURFACE)
          .onClick(() => {
            this.selectedIndex = index
          })
        }, (item: string) => item)
      }
      .width('100%')
      .height(48)
      .backgroundColor(AppColors.SURFACE)

      Scroll() {
        CourseList({
          title: this.currentTitle(),
          count: this.currentCount()
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppSpacing.LG,
      right: AppSpacing.LG,
      top: AppSpacing.MD,
      bottom: AppSpacing.MD
    })
    .backgroundColor(AppColors.BACKGROUND)
  }
}