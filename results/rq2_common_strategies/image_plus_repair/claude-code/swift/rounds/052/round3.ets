@Entry
@Component
struct CourseCatalogApp {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Stack() {
      Column({ space: 12 }) {
        Text('Course Catalog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF111111')
          .width('100%')
          .textAlign(TextAlign.Start)

        Row() {
          ForEach(this.tabs, (item: string, index: number) => {
            Column() {
              Text(item)
                .fontSize(this.selectedTabIndex === index ? 18 : 14)
                .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Regular)
                .fontColor(this.selectedTabIndex === index ? '#FF111111' : '#FF444444')
                .padding({ top: 12, bottom: 12 })

              if (this.selectedTabIndex === index) {
                Divider()
                  .color('#FF111111')
                  .strokeWidth(2)
              } else {
                Divider()
                  .color(Color.Transparent)
                  .strokeWidth(2)
              }
            }
            .layoutWeight(1)
            .onClick(() => {
              this.selectedTabIndex = index;
            })
          }, (item: string, index: number) => index.toString())
        }
        .width('100%')
        .backgroundColor('#FFFFFFFF')
        .borderRadius(6)

        Swiper(this.swiperController) {
          ForEach(this.tabs, (_item: string, index: number) => {
            if (index === 0) {
              CourseList({ title: 'All Courses', count: 6 })
            } else if (index === 1) {
              CourseList({ title: 'Enrolled', count: 3 })
            } else {
              CourseList({ title: 'Completed', count: 4 })
            }
          }, (item: string, index: number) => index.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .index(this.selectedTabIndex)
        .indicator(false)
        .onChange((index: number) => {
          this.selectedTabIndex = index;
        })
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF5F5F5')
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF444444')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 4, bottom: 4 })

        ForEach(this.buildCourseArray(this.count), (item: number, index: number) => {
          CourseCard({ courseNumber: index + 1 })
        }, (item: number, index: number) => index.toString())
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }

  buildCourseArray(count: number): number[] {
    let result: number[] = [];
    for (let i: number = 0; i < count; i++) {
      result.push(i);
    }
    return result;
  }
}

@Component
struct CourseCard {
  courseNumber: number = 1;

  build() {
    Row() {
      Column({ space: 8 }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF111111')

        Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FF444444')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(14)
        .fontColor('#FFFFFFFF')
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor('#FF111111')
        .borderRadius(12)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(10)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }
}
