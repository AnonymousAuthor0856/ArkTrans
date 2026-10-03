@Entry
@Component
struct CourseCatalogPage {
  @State currentIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private courseCounts: number[] = [6, 3, 4];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .margin({ top: 12, bottom: 12 });

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Text(title)
            .fontSize(this.currentIndex === index ? 18 : 14)
            .fontWeight(this.currentIndex === index ? FontWeight.SemiBold : FontWeight.Normal)
            .fontColor(this.currentIndex === index ? '#111111' : '#444444')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .onClick(() => {
              this.currentIndex = index;
              this.swiperController.changeIndex(index);
            })
        }, (title: string) => title)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(10)
      .justifyContent(FlexAlign.SpaceAround);

      Swiper(this.swiperController) {
        ForEach([0, 1, 2], (page: number) => {
          CourseList({ title: page === 0 ? 'All Courses' : this.tabs[page], count: this.courseCounts[page] })
        }, (page: number) => page.toString())
      }
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width('100%')
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 });
  }
}

@Component
struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column() {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#444444')
          .width('100%')
          .margin({ bottom: 12 });

        ForEach(Array.from({ length: this.count }, (_, i) => i), (index: number) => {
          CourseCard({ courseIndex: index })
        }, (index: number) => index.toString())
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off);
  }
}

@Component
struct CourseCard {
  courseIndex: number = 0;

  build() {
    Row() {
      Column() {
        Text(`Course ${this.courseIndex + 1}`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111111');
        Text(`Duration: ${5 + this.courseIndex} hrs`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#444444')
          .margin({ top: 8 });
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1);

      Text('View')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#FFFFFF')
        .backgroundColor('#111111')
        .borderRadius(12)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .height(24);
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .margin({ bottom: 12 });
  }
}
