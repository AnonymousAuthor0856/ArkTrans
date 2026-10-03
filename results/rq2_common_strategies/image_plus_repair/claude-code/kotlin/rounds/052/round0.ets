@Entry
@Component
struct CourseCatalogPage {
  @State currentIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  private courseCounts: number[] = [6, 3, 4]
  private tabTitles: string[] = ['All Courses', 'Enrolled', 'Completed']

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(this.currentIndex === index ? 22 : 18)
        .fontWeight(this.currentIndex === index ? FontWeight.SemiBold : FontWeight.Normal)
        .fontColor(this.currentIndex === index ? '#111111' : '#444444')
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.currentIndex === index ? '#E8E8E8' : '#FFFFFF')
    .borderRadius({ topLeft: 8, topRight: 8 })
  }

  @Builder
  CourseCard(index: number) {
    Row() {
      Column() {
        Text(`Course ${index + 1}`)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111111')
        Text(`Duration: ${5 + index} hrs`)
          .fontSize(16)
          .fontColor('#444444')
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .backgroundColor('#111111')
        .borderRadius(12)
        .padding({ left: 20, right: 20, top: 6, bottom: 6 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetY: 2
    })
  }

  @Builder
  CourseListPage(title: string, count: number) {
    Column() {
      Text(title)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#444444')
        .margin({ top: 8, bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(Array.from({ length: count }, (_, i) => i), (item: number) => {
        this.CourseCard(item)
          .margin({ bottom: 12 })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 16, bottom: 16, left: 4 })

      Tabs({
        barPosition: BarPosition.Start,
        index: this.currentIndex
      }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            Scroll() {
              this.CourseListPage(this.tabTitles[index], this.courseCounts[index])
            }
            .width('100%')
            .height('100%')
          }
          .tabBar(this.TabBuilder(title, index))
        }, (title: string, index: number) => `${title}_${index}`)
      }
      .barMode(BarMode.Fixed)
      .barHeight(64)
      .barBackgroundColor('#FFFFFF')
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ left: 20, right: 20 })
  }
}
