@Entry
@Component
struct RootScreen {
  @State private var selectedTabIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Stack() {
      Column({ space: 12 }) {
        Text('Course Catalog')
          .font({ size: 28, weight: FontWeight.Bold })
          .fontColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({
          tabs: this.tabs,
          selectedTabIndex: $selectedTabIndex
        })
          .backgroundColor('#FFFFFF')
          .borderRadius(6)

        Swiper() {
          ForEach(this.tabs, (tab: string, index: number) => {
            if (index === 0) {
              CourseList({ title: 'All Courses', count: 6 })
            } else if (index === 1) {
              CourseList({ title: 'Enrolled', count: 3 })
            } else {
              CourseList({ title: 'Completed', count: 4 })
            }
          }, (tab: string, index: number) => `${tab}_${index}`)
        }
        .index($selectedTabIndex)
        .indicator(false)
        .loop(false)
        .duration(300)
        .curve(Curve.EaseInOut)
        .width('100%')
        .layoutWeight(1)
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#F5F5F5')
    .width('100%')
    .height('100%')
  }
}

@Component
struct CustomTabRow {
  @Prop tabs: string[] = []
  @Link selectedTabIndex: number = 0

  build() {
    Row({ space: 0 }) {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column({ space: 0 }) {
          Text(tab)
            .font({ size: this.selectedTabIndex === index ? 18 : 14,
              weight: this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Regular })
            .fontColor(this.selectedTabIndex === index ? '#111111' : '#444444')
            .padding({ top: 12, bottom: 12 })
            .width('100%')
            .textAlign(TextAlign.Center)

          if (this.selectedTabIndex === index) {
            Row()
              .backgroundColor('#111111')
              .height(2)
              .width('100%')
              .animation({ duration: 200, curve: Curve.EaseInOut })
          } else {
            Row()
              .backgroundColor(Color.Transparent)
              .height(2)
              .width('100%')
          }
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index
        })
      }, (tab: string, index: number) => `${tab}_${index}`)
    }
    .width('100%')
  }
}

@Component
struct CourseList {
  @Prop title: string = ''
  @Prop count: number = 0

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Text(this.title)
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor('#444444')
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(Array.from({ length: this.count }, (_, i) => i + 1), (item: number) => {
          CourseCard({ courseNumber: item })
        }, (item: number) => `${item}`)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .align(Alignment.TopStart)
  }
}

@Component
struct CourseCard {
  @Prop courseNumber: number = 0

  build() {
    Column() {
      Row() {
        Column({ space: 8 }) {
          Text(`Course ${this.courseNumber}`)
            .font({ size: 18, weight: FontWeight.Medium })
            .fontColor('#111111')

          Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
            .font({ size: 14, weight: FontWeight.Regular })
            .fontColor('#444444')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('View')
          .font({ size: 14, weight: FontWeight.Regular })
          .fontColor('#FFFFFF')
          .padding({ left: 12, right: 12 })
          .height(24)
          .backgroundColor('#111111')
          .borderRadius(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding(12)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }
}