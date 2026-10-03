@Entry
@Component
struct CourseCatalog {
  @State selectedTab: number = 0

  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 28 })

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(this.selectedTab === index ? 30 : 28)
              .fontWeight(this.selectedTab === index ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.selectedTab === index ? '#111111' : '#444444')
              .height(56)
              .lineHeight(56)
              .textAlign(TextAlign.Center)
              .width('100%')

            Divider()
              .strokeWidth(2)
              .color(this.selectedTab === index ? '#111111' : '#00000000')
              .width('100%')
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTab = index
          })
        }, (tab: string) => tab)
      }
      .height(95)
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .clip(true)
      .margin({ bottom: 26 })

      if (this.selectedTab === 0) {
        this.courseList('All Courses', 6)
      } else if (this.selectedTab === 1) {
        this.courseList('Enrolled', 3)
      } else {
        this.courseList('Completed', 4)
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 28, bottom: 18 })
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  courseList(title: string, count: number) {
    Scroll() {
      Column() {
        Text(title)
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 22 })

        ForEach(this.courseNumbers(count), (courseNumber: number) => {
          this.courseCard(courseNumber)
        }, (courseNumber: number) => courseNumber.toString())
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .width('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  private courseNumbers(count: number): number[] {
    let numbers: number[] = []
    for (let index: number = 1; index <= count; index++) {
      numbers.push(index)
    }
    return numbers
  }

  @Builder
  courseCard(courseNumber: number) {
    Row() {
      Column() {
        Text(`Course ${courseNumber}`)
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(`Duration: ${courseNumber + 4} hrs`)
          .fontSize(28)
          .fontColor('#444444')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 12 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(28)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .height(50)
        .width(111)
        .lineHeight(50)
        .backgroundColor('#111111')
        .borderRadius(28)
    }
    .width('100%')
    .height(141)
    .padding({ left: 25, right: 24, top: 18, bottom: 18 })
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetY: 2
    })
    .margin({ bottom: 24 })
  }
}
