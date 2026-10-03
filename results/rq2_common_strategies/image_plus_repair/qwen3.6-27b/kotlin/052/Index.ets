@Entry
@Component
struct CourseCatalog {
  @State selectedTab: number = 0;
  private tabs: string[] = ["All", "Enrolled", "Completed"];

  build() {
    Column() {
      Text("Course Catalog")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .margin({ bottom: 12 })

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(index === this.selectedTab ? 18 : 14)
            .fontWeight(index === this.selectedTab ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(index === this.selectedTab ? '#111111' : '#444444')
            .width('33%')
            .textAlign(TextAlign.Center)
            .padding({ top: 12, bottom: 12 })
            .onClick(() => {
              this.selectedTab = index;
            })
        })
      }
      .backgroundColor('#FFFFFF')
      .borderWidth({ bottom: 2 })
      .borderColor('#111111')

      Column() {
        Text(this.getCourseListTitle())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#444444')
          .margin({ top: 16, bottom: 12 })

        List({ space: 12 }) {
          ForEach(this.getCourses(), (course: Course) => {
            ListItem() {
              Row() {
                Column() {
                  Text(course.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                  
                  Text(`Duration: ${course.duration} hrs`)
                    .fontSize(14)
                    .fontColor('#444444')
                    .margin({ top: 4 })
                }
                
                Button("View")
                  .backgroundColor('#111111')
                  .fontColor('#FFFFFF')
                  .borderRadius(12)
                  .height(24)
                  .margin({ left: 'auto' })
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
            }
          })
        }
        .layoutWeight(1)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }

  getCourseListTitle(): string {
    switch (this.selectedTab) {
      case 0: return "All Courses";
      case 1: return "Enrolled";
      case 2: return "Completed";
      default: return "";
    }
  }

  getCourses(): Course[] {
    const courses: Course[] = [];
    const count = this.selectedTab === 0 ? 6 : this.selectedTab === 1 ? 3 : 4;
    
    for (let i = 0; i < count; i++) {
      courses.push({
        title: `Course ${i + 1}`,
        duration: 5 + i
      });
    }
    
    return courses;
  }
}

interface Course {
  title: string;
  duration: number;
}