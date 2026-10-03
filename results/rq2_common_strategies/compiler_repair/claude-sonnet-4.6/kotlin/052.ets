import { curves } from '@kit.ArkUI'

const PRIMARY_COLOR = '#FF111111'
const SECONDARY_COLOR = '#FF444444'
const BACKGROUND_COLOR = '#FFF5F5F5'
const SURFACE_COLOR = '#FFFFFFFF'
const ON_PRIMARY_COLOR = '#FFFFFFFF'

const DISPLAY_FONT_SIZE = 28
const HEADLINE_FONT_SIZE = 18
const BODY_FONT_SIZE = 14

const SPACING_SM = 8
const SPACING_MD = 12
const SPACING_LG = 16

const SHAPE_MEDIUM = 10

interface CourseItem {
  index: number
  title: string
  duration: string
}

@Component
struct CourseCard {
  item: CourseItem = { index: 0, title: '', duration: '' }

  build() {
    Row() {
      Column() {
        Text(this.item.title)
          .fontSize(HEADLINE_FONT_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_COLOR)
        Text(this.item.duration)
          .fontSize(BODY_FONT_SIZE)
          .fontWeight(FontWeight.Normal)
          .fontColor(SECONDARY_COLOR)
          .margin({ top: SPACING_SM })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(BODY_FONT_SIZE)
        .fontColor(ON_PRIMARY_COLOR)
        .backgroundColor(PRIMARY_COLOR)
        .borderRadius(12)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    }
    .width('100%')
    .padding(SPACING_MD)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius(SHAPE_MEDIUM)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct CourseList {
  title: string = ''
  count: number = 0

  private buildItems(): CourseItem[] {
    let items: CourseItem[] = []
    for (let i = 0; i < this.count; i++) {
      items.push({
        index: i,
        title: `Course ${i + 1}`,
        duration: `Duration: ${5 + i} hrs`
      })
    }
    return items
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(HEADLINE_FONT_SIZE)
        .fontWeight(FontWeight.Medium)
        .fontColor(SECONDARY_COLOR)
        .margin({ bottom: SPACING_MD })

      ForEach(this.buildItems(), (item: CourseItem) => {
        CourseCard({ item: item })
          .margin({ bottom: SPACING_MD })
      }, (item: CourseItem) => item.index.toString())
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  @State currentTab: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Column() {
        Text('Course Catalog')
          .fontSize(DISPLAY_FONT_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_COLOR)
          .margin({ bottom: SPACING_MD })

        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Column() {
              Text(tab)
                .fontSize(this.currentTab === index ? HEADLINE_FONT_SIZE : BODY_FONT_SIZE)
                .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.currentTab === index ? PRIMARY_COLOR : SECONDARY_COLOR)
                .padding({ top: 8, bottom: 8 })

              Divider()
                .strokeWidth(2)
                .color(this.currentTab === index ? PRIMARY_COLOR : 'transparent')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.currentTab = index
              this.swiperController.changeIndex(index, true)
            })
          }, (tab: string) => tab)
        }
        .width('100%')
        .backgroundColor(SURFACE_COLOR)
      }
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD })
      .alignItems(HorizontalAlign.Start)

      Swiper(this.swiperController) {
        Scroll() {
          CourseList({ title: 'All Courses', count: 6 })
            .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD })
        }
        .scrollBar(BarState.Off)

        Scroll() {
          CourseList({ title: 'Enrolled', count: 3 })
            .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD })
        }
        .scrollBar(BarState.Off)

        Scroll() {
          CourseList({ title: 'Completed', count: 4 })
            .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD })
        }
        .scrollBar(BarState.Off)
      }
      .index(this.currentTab)
      .loop(false)
      .indicator(false)
      .onChange((index: number) => {
        this.currentTab = index
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}