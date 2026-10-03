@Entry
@Component
struct CourseCatalogApp {
  @State selectedTabIndex: number = 0;
  @State courseCounts: number[] = [6, 3, 4];
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private swiperController: SwiperController = new SwiperController();

  aboutToAppear(): void {
    this.swiperController.swipeTo(this.selectedTabIndex);
  }

  build() {
    Column() {
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
              this.swiperController.swipeTo(index);
            })
          }, (item: string, index: number) => index.toString())
        }
        .width('100%')
        .backgroundColor('#FFFFFFFF')
        .borderRadius(6)

        Swiper(this.swiperController) {
          CourseList({ title: 'All Courses', count: 6 })
          CourseList({ title: 'Enrolled', count: 3 })
          CourseList({ title: 'Completed', count: 4 })
        }
        .width('100%')
        .layoutWeight(1)
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
  @State courseIndices: number[] = [];

  aboutToAppear(): void {
    let arr: number[] = [];
    for (let i: number = 0; i < this.count; i++) {
      arr.push(i);
    }
    this.courseIndices = arr;
  }

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

        ForEach(this.courseIndices, (item: number, index: number) => {
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
}

@Component
struct CourseCard {
  courseNumber: number = 1;
  @State durationText: string = '';

  aboutToAppear(): void {
    this.durationText = 'Duration: ' + (5 + this.courseNumber - 1).toString() + ' hrs';
  }

  build() {
    Row() {
      Column({ space: 8 }) {
        Text('Course ' + this.courseNumber.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF111111')

        Text(this.durationText)
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
