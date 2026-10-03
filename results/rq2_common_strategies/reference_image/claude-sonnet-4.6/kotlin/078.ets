// entry/src/main/ets/pages/Index.ets

/**
 * Icon glyphs are plain Text symbols so the file compiles with zero extra resources.
 * Swap them for SymbolGlyph($r('sys.symbol.xxx')) or SVG Image resources for production.
 */

class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  isPrimary: boolean;

  constructor(title: string, subtitle: string, rating: string,
              bgColor: string, accentColor: string, isPrimary: boolean) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.isPrimary = isPrimary;
  }
}

// Palette (mirrors the Compose lightColorScheme)
const COLOR_PRIMARY: string = '#4E31AA';
const COLOR_BACKGROUND: string = '#F5F5F7';
const COLOR_ON_BACKGROUND: string = '#1C1B1F';
const COLOR_GREY: string = '#9E9E9E';
const COLOR_LIGHT_GREY: string = '#D0D0D0';
const COLOR_WHITE: string = '#FFFFFF';
const COLOR_ORANGE: string = '#FFA726';
const COLOR_DEEP_ORANGE: string = '#FF7043';
const COLOR_AMBER: string = '#FFB300';

@Entry
@Component
struct Index {
  @State selectedCategory: string = 'Design';

  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0', true),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', false),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', false)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      Column() {
        this.BottomNavigationBar()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(COLOR_GREY)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Text('🔔')
          .fontSize(22)
        Stack() {
          Text('☺')
            .fontSize(28)
            .fontColor(COLOR_PRIMARY)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#334E31AA')
        .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Column() {
      Row() {
        Text('🔍')
          .fontSize(18)
          .fontColor(COLOR_GREY)
        Text('Search for course...')
          .fontSize(16)
          .fontColor(COLOR_LIGHT_GREY)
          .margin({ left: 12 })
          .layoutWeight(1)
        Text('⚙')
          .fontSize(20)
          .fontColor(COLOR_PRIMARY)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .borderRadius(16)
      .backgroundColor(COLOR_WHITE)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#B3FFFFFF')
          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_WHITE)
            .margin({ top: 8 })

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor(COLOR_WHITE)
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .color(COLOR_ORANGE)
              .backgroundColor('#33FFFFFF')
              .style({ strokeWidth: 6 })
              .layoutWeight(1)
              .margin({ left: 8 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Stack() {
          Text('▶')
            .fontSize(26)
            .fontColor(COLOR_PRIMARY)
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(COLOR_WHITE)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .padding(20)
      .borderRadius(24)
      .backgroundColor(COLOR_PRIMARY)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    List({ space: 12 }) {
      ForEach(this.categories, (category: string) => {
        ListItem() {
          Text(category)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedCategory === category ? COLOR_WHITE : COLOR_GREY)
            .textAlign(TextAlign.Center)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(12)
            .backgroundColor(this.selectedCategory === category ? COLOR_DEEP_ORANGE : COLOR_WHITE)
            .onClick(() => {
              this.selectedCategory = category;
            })
        }
      }, (category: string) => category)
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(50)
    .padding({ left: 24, right: 24 })
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
        Text('See all')
          .fontSize(15)
          .fontColor(COLOR_GREY)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      }, (course: Course) => course.title)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack() {
        Text(course.isPrimary ? '✓' : '★')
          .fontSize(28)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
        Text(course.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)

        Row() {
          Text('★')
            .fontSize(14)
            .fontColor(COLOR_AMBER)
          Text(course.rating)
            .fontSize(12)
            .fontColor(COLOR_GREY)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding(16)

      Text('♡')
        .fontSize(22)
        .fontColor('#EEEEEE')
        .margin({ right: 20 })
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor(COLOR_WHITE)
    .clip(true)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('⌂')
        .fontSize(24)
        .fontColor(COLOR_WHITE)
      Text('🔍')
        .fontSize(20)
        .fontColor(COLOR_GREY)
      Text('♥')
        .fontSize(22)
        .fontColor(COLOR_GREY)
      Text('☺')
        .fontSize(22)
        .fontColor(COLOR_GREY)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24, bottom: 24 })
  }
}