@Entry
@Component
struct CourseCatalogApp {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Stack() {
      Column({ space: 12 }) {
        Text('Course Catalog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Custom Tab Row
        Row({ space: 0 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button() {
              Column({ space: 0 }) {
                Text(tab)
                  .fontSize(this.selectedTabIndex === index ? 18 : 14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.selectedTabIndex === index ? '#111111' : '#444444')
                  .padding({ top: 12, bottom: 12 })
                  .width('100%')
                  .textAlign(TextAlign.Center)
                Divider()
                  .height(this.selectedTabIndex === index ? 2 : 2)
                  .color(this.selectedTabIndex === index ? '#111111' : '#FFFFFF')
              }
              .width('100%')
            }
            .width('33.33%')
            .height(50)
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              this.selectedTabIndex = index
            })
          })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(6)

        // Content area based on selected tab
        if (this.selectedTabIndex === 0) {
          this.buildCourseList('All Courses', 6)
        } else if (this.selectedTabIndex === 1) {
          this.buildCourseList('Enrolled', 3)
        } else {
          this.buildCourseList('Completed', 4)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildCourseList(title: string, count: number) {
    Column({ space: 12 }) {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#444444')
        .width('100%')

      List({ space: 12 }) {
        // Generate list items using a loop
        ForEach(this.generateArray(count), (item: number) => {
          ListItem() {
            this.buildCourseCard(item + 1)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
  }

  // Helper to generate an array of numbers
  generateArray(count: number): number[] {
    let arr: number[] = []
    for (let i = 0; i < count; i++) {
      arr.push(i)
    }
    return arr
  }

  @Builder
  buildCourseCard(courseNumber: number) {
    Row({ space: 0 }) {
      Column({ space: 8 }) {
        Text('Course ' + courseNumber)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#111111')
        Text('Duration: ' + (5 + courseNumber - 1) + ' hrs')
          .fontSize(14)
          .foregroundColor('#444444')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()

      Button() {
        Text('View')
          .fontSize(14)
          .foregroundColor('#FFFFFF')
          .padding({ left: 12, right: 12 })
          .height(24)
          .textAlign(TextAlign.Center)
      }
      .height(24)
      .backgroundColor('#111111')
      .borderRadius(12)
    }
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
    .width('100%')
  }
}