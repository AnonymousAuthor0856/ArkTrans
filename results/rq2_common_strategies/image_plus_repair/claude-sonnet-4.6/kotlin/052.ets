@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column() {
      // Title
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .margin({ bottom: 12 })
        .alignSelf(ItemAlign.Start)

      // Tab Row
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(this.selectedTab === index ? 18 : 14)
              .fontWeight(this.selectedTab === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.selectedTab === index ? '#111111' : '#444444')
              .padding({ top: 10, bottom: 10 })
            Divider()
              .strokeWidth(this.selectedTab === index ? 2 : 0)
              .color('#111111')
          }
          .layoutWeight(1)
          .backgroundColor('#FFFFFF')
          .onClick(() => {
            this.selectedTab = index
          })
        })
      }
      .width('100%')
      .margin({ bottom: 12 })

      // Content
      Scroll() {
        Column() {
          if (this.selectedTab === 0) {
            CourseList({ title: 'All Courses', count: 6 })
          } else if (this.selectedTab === 1) {
            CourseList({ title: 'Enrolled', count: 3 })
          } else {
            CourseList({ title: 'Completed', count: 4 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }
}

@Component
struct CourseList {
  title: string = ''
  count: number = 0

  build() {
    Column({ space: 12 }) {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#444444')
        .alignSelf(ItemAlign.Start)

      ForEach(Array.from({ length: this.count }, (_: Object, i: number) => i), (i: number) => {
        Row() {
          Column({ space: 8 }) {
            Text(`Course ${i + 1}`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
            Text(`Duration: ${5 + i} hrs`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#444444')
          }
          .alignItems(HorizontalAlign.Start)

          Text('View')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#FFFFFF')
            .backgroundColor('#111111')
            .borderRadius(12)
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(10)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}