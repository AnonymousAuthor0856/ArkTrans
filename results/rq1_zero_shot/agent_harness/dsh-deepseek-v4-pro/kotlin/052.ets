const Colors = {
  primary: '#111111',
  secondary: '#444444',
  background: '#F5F5F5',
  surface: '#FFFFFF',
  outline: '#CCCCCC',
  onPrimary: '#FFFFFF',
  onSurface: '#111111'
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column({ space: 12 }) {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Text(title)
            .fontSize(this.currentPage === index ? 18 : 14)
            .fontWeight(this.currentPage === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentPage === index ? Colors.primary : Colors.secondary)
            .padding({ left: 12, right: 12, top: 10, bottom: 10 })
            .onClick(() => {
              this.currentPage = index
            })
        }, (title: string) => title)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor(Colors.surface)

      Swiper(this.currentPage) {
        this.CourseList('All Courses', 6)
        this.CourseList('Enrolled', 3)
        this.CourseList('Completed', 4)
      }
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentPage = index
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(Colors.background)
  }

  @Builder
  CourseList(title: string, count: number) {
    Column({ space: 12 }) {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.secondary)
      ForEach(Array.from({ length: count }, (v, i) => i), (i: number) => {
        Row() {
          Column({ space: 8 }) {
            Text('Course ' + (i + 1))
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.primary)
            Text('Duration: ' + (5 + i) + ' hrs')
              .fontSize(14)
              .fontColor(Colors.secondary)
          }
          .alignItems(HorizontalAlign.Start)

          Text('View')
            .fontSize(14)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(12)
            .height(24)
            .padding({ left: 12, right: 12 })
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .padding(12)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
        .borderRadius(10)
        .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })
      }, (i: number) => i.toString())
    }
    .width('100%')
  }
}
