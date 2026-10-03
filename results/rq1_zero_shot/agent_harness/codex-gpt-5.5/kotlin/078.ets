class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
  }
}

@Entry
@Component
struct MainActivity {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32')
  ];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#808080')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Row({ space: 8 }) {
        Text('!')
          .fontSize(22)
          .fontColor('#1C1B1F')
          .width(40)
          .height(40)
          .lineHeight(40)
          .textAlign(TextAlign.Center)
        Text('☺')
          .fontSize(24)
          .fontColor('#4E31AA')
          .width(48)
          .height(48)
          .lineHeight(48)
          .textAlign(TextAlign.Center)
          .backgroundColor('#334E31AA')
          .borderRadius(24)
      }
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('⌕')
        .fontSize(22)
        .fontColor('#808080')
      Text('Search for course...')
        .fontSize(14)
        .fontColor('#D3D3D3')
        .layoutWeight(1)
        .margin({ left: 16 })
      Text('⚙')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .width('100%')
      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#B3FFFFFF')
          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 8 })
          Row({ space: 8 }) {
            Text('75%')
              .fontSize(12)
              .fontColor('#FFFFFF')
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .layoutWeight(1)
              .height(6)
              .color('#FFA726')
              .backgroundColor('#33FFFFFF')
          }
          .width('100%')
          .margin({ top: 16 })
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('▶')
          .fontSize(32)
          .fontColor('#4E31AA')
          .textAlign(TextAlign.Center)
          .width(60)
          .height(60)
          .lineHeight(60)
          .backgroundColor('#FFFFFF')
          .borderRadius(30)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .padding(20)
      .margin({ top: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    Row({ space: 12 }) {
      ForEach(this.categories, (category: string) => {
        Text(category)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(category === 'Design' ? '#FFFFFF' : '#808080')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(category === 'Design' ? '#FF7043' : '#FFFFFF')
          .borderRadius(12)
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Text(course.title.indexOf('Mobile') >= 0 ? '✓' : '★')
        .fontSize(32)
        .fontColor(course.accentColor)
        .textAlign(TextAlign.Center)
        .width(100)
        .height(100)
        .lineHeight(100)
        .backgroundColor(course.bgColor)
      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 2 })
        Row({ space: 4 }) {
          Text('★')
            .fontSize(16)
            .fontColor('#FFB300')
          Text(course.rating)
            .fontSize(12)
            .fontColor('#808080')
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Text('♥')
        .fontSize(22)
        .fontColor('#EEEEEE')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(100)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('See all')
          .fontSize(14)
          .fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
        Blank().height(16)
      })
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('⌂').fontSize(22).fontColor('#FFFFFF')
      Text('⌕').fontSize(22).fontColor('#808080')
      Text('♥').fontSize(22).fontColor('#808080')
      Text('☺').fontSize(22).fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
    .margin(24)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
          Blank().height(80)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
