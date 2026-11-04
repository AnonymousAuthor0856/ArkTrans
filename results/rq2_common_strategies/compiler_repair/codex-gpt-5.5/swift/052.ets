@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  private currentTitle(): string {
    if (this.selectedTabIndex === 1) {
      return 'Enrolled'
    }
    if (this.selectedTabIndex === 2) {
      return 'Completed'
    }
    return 'All Courses'
  }

  private currentCount(): number {
    if (this.selectedTabIndex === 1) {
      return 3
    }
    if (this.selectedTabIndex === 2) {
      return 4
    }
    return 6
  }

  @Builder
  TabButton(label: string, index: number) {
    Column() {
      Button(label)
        .fontSize(this.selectedTabIndex === index ? 18 : 14)
        .fontWeight(this.selectedTabIndex === index ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.selectedTabIndex === index ? '#111111' : '#444444')
        .width('100%')
        .height(46)
        .backgroundColor('#FFFFFF')
        .onClick(() => {
          this.selectedTabIndex = index
        })
      Rect()
        .width('100%')
        .height(2)
        .fill(this.selectedTabIndex === index ? '#111111' : '#00FFFFFF')
    }
    .layoutWeight(1)
  }

  @Builder
  TabRow() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        this.TabButton(tab, index)
      }, (tab: string) => tab)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(6)
  }

  @Builder
  CourseCard(courseNumber: number) {
    Row() {
      Column() {
        Text(`Course ${courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')
        Text(`Duration: ${5 + courseNumber - 1} hrs`)
          .fontSize(14)
          .fontColor('#444444')
          .width('100%')
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('View')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .height(24)
        .padding({ left: 12, right: 12 })
        .backgroundColor('#111111')
        .borderRadius(12)
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  @Builder
  CourseList() {
    Scroll() {
      Column() {
        Text(this.currentTitle())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')

        ForEach([1, 2, 3, 4, 5, 6], (courseNumber: number) => {
          if (courseNumber <= this.currentCount()) {
            Column() {
              this.CourseCard(courseNumber)
            }
            .margin({ top: 12 })
          }
        }, (courseNumber: number) => courseNumber.toString())
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }

  build() {
    Stack() {
      Column() {
        Text('Course Catalog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')

        Column() {
          this.TabRow()
        }
        .margin({ top: 12 })

        Column() {
          this.CourseList()
        }
        .layoutWeight(1)
        .margin({ top: 12 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
