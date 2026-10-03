@Entry
@Component
struct CourseCatalogPage {
  @State private selectedIndex: number = 0

  private readonly tabs: string[] = ['All', 'Enrolled', 'Completed']

  private getSectionTitle(): string {
    if (this.selectedIndex === 1) {
      return 'Enrolled'
    }
    if (this.selectedIndex === 2) {
      return 'Completed'
    }
    return 'All Courses'
  }

  private getCourseCount(): number {
    if (this.selectedIndex === 1) {
      return 3
    }
    if (this.selectedIndex === 2) {
      return 4
    }
    return 6
  }

  @Builder
  private TabItem(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(this.selectedIndex === index ? 26 : 28)
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.selectedIndex === index ? '#111111' : '#444444')
    }
    .width('33.3333%')
    .height(96)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.selectedIndex === index ? '#E7E7E7' : '#FFFFFF')
    .border({
      width: { bottom: this.selectedIndex === index ? 5 : 1 },
      color: { bottom: this.selectedIndex === index ? '#111111' : '#CFC8D5' }
    })
    .onClick(() => {
      this.selectedIndex = index
    })
  }

  @Builder
  private CourseCard(index: number) {
    Row() {
      Column({ space: 20 }) {
        Text(`Course ${index + 1}`)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')

        Text(`Duration: ${5 + index} hrs`)
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor('#444444')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(28)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Regular)
        .height(49)
        .padding({ left: 24, right: 24 })
        .backgroundColor('#111111')
        .borderRadius(25)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(139)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .margin({ top: 26, bottom: 27 })

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          this.TabItem(title, index)
        }, (title: string) => title)
      }
      .width('100%')
      .height(96)
      .backgroundColor('#FFFFFF')

      Text(this.getSectionTitle())
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor('#444444')
        .width('100%')
        .margin({ top: 24, bottom: 25 })

      Column({ space: 24 }) {
        ForEach(Array.from({ length: this.getCourseCount() }), (_: undefined, index: number) => {
          this.CourseCard(index)
        }, (_: undefined, index: number) => `${this.selectedIndex}-${index}`)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor('#F5F5F5')
  }
}
