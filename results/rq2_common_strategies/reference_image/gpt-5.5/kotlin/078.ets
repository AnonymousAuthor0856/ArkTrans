class Course {
  title: string
  subtitle: string
  rating: string
  bgColor: ResourceColor
  accentColor: ResourceColor

  constructor(title: string, subtitle: string, rating: string, bgColor: ResourceColor, accentColor: ResourceColor) {
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  private readonly primaryColor: ResourceColor = '#4E31AA'
  private readonly backgroundColor: ResourceColor = '#F5F5F7'
  private readonly textColor: ResourceColor = '#1C1B1F'
  private readonly categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private readonly courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32')
  ]

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
        .padding({ bottom: 108 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text('Let\'s start learning!')
          .fontSize(20)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('♟')
          .fontSize(28)
          .fontColor(this.textColor)
          .width(40)
          .height(48)
          .textAlign(TextAlign.Center)

        Blank()
          .width(8)

        Stack({ alignContent: Alignment.Center }) {
          Text('☻')
            .fontSize(28)
            .fontColor(this.primaryColor)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#D7CFF0')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 30, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('⌕')
        .fontSize(34)
        .fontColor('#888888')

      Blank()
        .width(16)

      Text('Search for course...')
        .fontSize(20)
        .fontColor('#C7C7C7')
        .layoutWeight(1)

      Text('⚙')
        .fontSize(32)
        .fontColor(this.primaryColor)
    }
    .width('calc(100% - 48vp)')
    .height(56)
    .margin({ left: 24, right: 24 })
    .padding({ left: 16, right: 16 })
    .borderRadius(16)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(16)
            .fontColor('#CFC4F4')

          Text('Blender Basic')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ top: 8 })

          Row() {
            Text('75%')
              .fontSize(14)
              .fontColor(Color.White)

            Blank()
              .width(8)

            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .color('#FFA726')
              .backgroundColor('#7356C2')
              .height(6)
              .borderRadius(4)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16 })
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Blank()
          .width(16)

        Stack({ alignContent: Alignment.Center }) {
          Text('▶')
            .fontSize(34)
            .fontColor(this.primaryColor)
            .margin({ left: 4 })
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(Color.White)
      }
      .width('100%')
      .height(140)
      .margin({ top: 16 })
      .padding(20)
      .borderRadius(24)
      .backgroundColor(this.primaryColor)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : '#888888')
            .textAlign(TextAlign.Center)
            .height(56)
            .padding({ left: 24, right: 24 })
            .borderRadius(12)
            .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
            .margin({ right: 12 })
        }, (category: string) => category)
      }
      .padding({ left: 24, right: 12 })
    }
    .width('100%')
    .height(72)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text('See all')
          .fontSize(18)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(16)

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)

        Blank()
          .height(16)
      }, (course: Course) => course.title)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(course.title.indexOf('Mobile') >= 0 ? '✓' : '★')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)

        Text(course.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .margin({ top: 4 })

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor('#FFB300')

          Blank()
            .width(4)

          Text(course.rating)
            .fontSize(12)
            .fontColor('#888888')
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .height('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Text('♥')
        .fontSize(28)
        .fontColor('#EEEEEE')
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .clip(true)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('⌂')
        .fontSize(34)
        .fontColor(Color.White)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('⌕')
        .fontSize(34)
        .fontColor('#888888')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('♥')
        .fontSize(32)
        .fontColor('#888888')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('☻')
        .fontSize(32)
        .fontColor('#888888')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('calc(100% - 48vp)')
    .height(80)
    .margin({ left: 24, right: 24, bottom: 24 })
    .padding({ left: 8, right: 8 })
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .shadow({ radius: 24, color: '#33000000', offsetX: 0, offsetY: 8 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}