class AppTheme {
  static readonly primary: string = '#4E31AA'
  static readonly secondary: string = '#3A1C71'
  static readonly background: string = '#F5F5F7'
  static readonly surface: string = '#FFFFFF'
  static readonly onBackground: string = '#1C1B1F'
  static readonly progressColor: string = '#FFA726'
  static readonly selectedCategoryColor: string = '#FF7043'
  static readonly gray: string = '#8E8E93'
  static readonly lightGray: string = '#B0B0B4'
}

class Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, iconName: string) {
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
    this.iconName = iconName
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          Blank()
            .height(120)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      BottomNavigationBar()
        .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)

        Text('Let\'s start learning!')
          .fontSize(16)
          .fontColor(AppTheme.gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 12 }) {
        Text('●')
          .fontSize(20)
          .fontColor(AppTheme.onBackground)
          .width(32)
          .height(48)
          .textAlign(TextAlign.Center)

        Stack({ alignContent: Alignment.Center }) {
          Text('☺')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.primary)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#D7CDEE')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 52, bottom: 24 })
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Text('⌕')
        .fontSize(31)
        .fontColor(AppTheme.gray)

      Text('Search for course...')
        .fontSize(18)
        .fontColor(AppTheme.lightGray)
        .margin({ left: 16 })

      Blank()

      Text('☷')
        .fontSize(28)
        .fontColor(AppTheme.primary)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppTheme.surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)
        .width('100%')

      Row({ space: 16 }) {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#B3FFFFFF')

          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 8 })

          Blank()
            .height(16)

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor('#FFFFFF')

            Stack({ alignContent: Alignment.Start }) {
              Blank()
                .width('100%')
                .height(6)
                .backgroundColor('#55FFFFFF')
                .borderRadius(4)

              Blank()
                .width('75%')
                .height(6)
                .backgroundColor(AppTheme.progressColor)
                .borderRadius(4)
            }
            .height(6)
            .layoutWeight(1)
            .margin({ left: 8 })
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Text('▶')
            .fontSize(30)
            .fontColor(AppTheme.primary)
            .margin({ left: 4 })
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height(140)
      .padding(20)
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        Blank()
          .width(12)

        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? '#FFFFFF' : AppTheme.gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : '#FFFFFF')
            .borderRadius(12)
        }, (category: string) => category)

        Blank()
          .width(12)
      }
      .height(58)
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0', '✓'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', '★'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', '★')
  ]

  build() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)

        Blank()

        Text('See all')
          .fontSize(16)
          .fontColor(AppTheme.gray)
      }
      .width('100%')

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
      }, (course: Course) => course.title)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
  }
}

@Component
struct CourseCard {
  course: Course = new Course('', '', '', '#FFFFFF', '#000000', '★')

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.course.iconName)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(this.course.bgColor)
      .borderRadius({ topLeft: 20, bottomLeft: 20 })

      Column({ space: 4 }) {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.primary)

        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)

        Row({ space: 4 }) {
          Text('★')
            .fontSize(14)
            .fontColor('#FFB300')

          Text(this.course.rating)
            .fontSize(12)
            .fontColor(AppTheme.gray)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
      .height('100%')
      .padding({ left: 16, right: 16 })

      Text('♥')
        .fontSize(24)
        .fontColor('#E5E5EA')
        .padding({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .clip(true)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()

      Text('⌂')
        .fontSize(28)
        .fontColor('#FFFFFF')

      Blank()

      Text('⌕')
        .fontSize(28)
        .fontColor('#9A9A9D')

      Blank()

      Text('♥')
        .fontSize(24)
        .fontColor('#9A9A9D')

      Blank()

      Text('♟')
        .fontSize(24)
        .fontColor('#9A9A9D')

      Blank()
    }
    .width('100%')
    .height(72)
    .backgroundColor('#1E1E1E')
    .borderRadius(36)
    .shadow({
      radius: 16,
      color: '#33000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}