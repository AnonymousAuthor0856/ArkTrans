@Entry
@Component
struct CourseCatalog {
  @State currentTab: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .margin({ bottom: 12 })

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(index === this.currentTab ? 18 : 14)
              .fontWeight(index === this.currentTab ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(index === this.currentTab ? '#111111' : '#444444')
              .textAlign(TextAlign.Center)
              .width('100%')
              .padding({ top: 12, bottom: 12 })
          }
          .width('33.33%')
          .backgroundColor('#FFFFFF')
          .borderWidth({ bottom: index === this.currentTab ? 2 : 0 })
          .borderColor('#111111')
          .onClick(() => {
            this.currentTab = index
          })
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')

      Column() {
        Text(this.getSectionTitle())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#444444')
          .margin({ top: 12, bottom: 12 })

        List() {
          ForEach(this.getCourses(), (course: string, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Text(course)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                  Text(`Duration: ${this.getDuration(index)} hrs`)
                    .fontSize(14)
                    .fontColor('#444444')
                    .margin({ top: 4 })
                }
                .layoutWeight(1)

                Button('View')
                  .backgroundColor('#111111')
                  .fontColor('#FFFFFF')
                  .borderRadius(16)
                  .height(24)
                  .margin({ left: 12 })
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }

  getSectionTitle(): string {
    switch (this.currentTab) {
      case 0: return 'All Courses'
      case 1: return 'Enrolled'
      case 2: return 'Completed'
      default: return ''
    }
  }

  getCourses(): string[] {
    const count = [6, 3, 4][this.currentTab] || 0
    const courses: string[] = []
    for (let i = 0; i < count; i++) {
      courses.push(`Course ${i + 1}`)
    }
    return courses
  }

  getDuration(index: number): number {
    return 5 + index
  }
}