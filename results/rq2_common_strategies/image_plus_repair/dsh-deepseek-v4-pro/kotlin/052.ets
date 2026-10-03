const COLOR_PRIMARY: string = '#111111';
const COLOR_SECONDARY: string = '#444444';
const COLOR_BACKGROUND: string = '#F5F5F5';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_OUTLINE: string = '#CCCCCC';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#111111';

const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;

const SHAPE_SMALL: number = 6;
const SHAPE_MEDIUM: number = 10;
const SHAPE_LARGE: number = 14;

const FONT_DISPLAY: number = 28;
const FONT_HEADLINE: number = 18;
const FONT_BODY: number = 14;

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];

  private range(count: number): number[] {
    const arr: number[] = [];
    for (let i = 0; i < count; i++) {
      arr.push(i);
    }
    return arr;
  }

  @Builder
  TabItem(title: string, index: number) {
    Text(title)
      .fontSize(this.currentIndex === index ? FONT_HEADLINE : FONT_BODY)
      .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.currentIndex === index ? COLOR_PRIMARY : COLOR_SECONDARY)
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .padding({ top: SPACING_MD, bottom: SPACING_MD })
      .onClick(() => {
        this.currentIndex = index;
      })
  }

  @Builder
  ViewPill() {
    Row() {
      Text('View')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLOR_ON_PRIMARY)
        .textAlign(TextAlign.Center)
    }
    .height(24)
    .padding({ left: 12, right: 12 })
    .borderRadius(12)
    .backgroundColor(COLOR_PRIMARY)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CourseCard(index: number) {
    Row() {
      Column({ space: SPACING_SM }) {
        Text('Course ' + (index + 1))
          .fontSize(FONT_HEADLINE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_PRIMARY)
          .textAlign(TextAlign.Start)
        Text('Duration: ' + (5 + index) + ' hrs')
          .fontSize(FONT_BODY)
          .fontWeight(FontWeight.Normal)
          .fontColor(COLOR_SECONDARY)
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      this.ViewPill()
    }
    .width('100%')
    .padding(SPACING_MD)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_MEDIUM)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.1)', offsetY: 2 })
  }

  @Builder
  CourseList(title: string, count: number) {
    Column({ space: SPACING_MD }) {
      Text(title)
        .fontSize(FONT_HEADLINE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_SECONDARY)
        .textAlign(TextAlign.Start)
        .width('100%')

      ForEach(this.range(count), (index: number) => {
        this.CourseCard(index)
      }, (index: number) => index.toString())
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column({ space: SPACING_MD }) {
      Text('Course Catalog')
        .fontSize(FONT_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_PRIMARY)
        .textAlign(TextAlign.Start)
        .width('100%')

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          this.TabItem(title, index)
        }, (title: string, index: number) => title + '_' + index)
      }
      .width('100%')
      .backgroundColor(COLOR_SURFACE)

      Swiper() {
        this.CourseList('All Courses', 6)
        this.CourseList('Enrolled', 3)
        this.CourseList('Completed', 4)
      }
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(COLOR_BACKGROUND)
  }
}
