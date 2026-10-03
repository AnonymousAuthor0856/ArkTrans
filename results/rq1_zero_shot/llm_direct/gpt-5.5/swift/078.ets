class AppTheme {
  static readonly primary: string = '#4E31AA'
  static readonly secondary: string = '#3A1C71'
  static readonly background: string = '#F5F5F7'
  static readonly surface: string = '#FFFFFF'
  static readonly onBackground: string = '#1C1B1F'
  static readonly progressColor: string = '#FFA726'
  static readonly selectedCategoryColor: string = '#FF7043'
}

interface Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string
}

const recommendedCourses: Course[] = [
  {
    title: 'Mobile Dev',
    subtitle: 'Android Compose',
    rating: '4.9',
    bgColor: '#E3F2FD',
    accentColor: '#1565C0',
    iconName: '✓'
  },
  {
    title: 'Photography',
    subtitle: 'Master Lighting',
    rating: '4.7',
    bgColor: '#FCE4EC',
    accentColor: '#C2185B',
    iconName: '★'
  },
  {
    title: 'Finance',
    subtitle: 'Crypto Trading',
    rating: '4.5',
    bgColor: '#E8F5E9',
    accentColor: '#2E7D32',
    iconName: '★'
  }
]

@Entry
@Component
struct CourseApp {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    CourseDashboardScreen()
  }
}

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
            .height(100)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      Column() {
        BottomNavigationBar()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
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
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Text('🔔')
          .fontSize(24)
          .fontColor(AppTheme.onBackground)

        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('rgba(78, 49, 170, 0.2)')

          Text('☺')
            .fontSize(24)
            .fontColor(AppTheme.primary)
        }
        .width(48)
        .height(48)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Text('⌕')
        .fontSize(22)
        .fontColor('#8E8E93')

      Blank()
        .width(16)

      Text('Search for course...')
        .fontSize(16)
        .fontColor('#C7C7CC')

      Blank()

      Text('☰')
        .fontSize(22)
        .fontColor(AppTheme.primary)
    }
    .width('calc(100% - 48vp)')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppTheme.surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
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

      Row({ space: 16 }) {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('rgba(255, 255, 255, 0.7)')

          Blank()
            .height(8)

          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')

          Blank()
            .height(16)

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor('#FFFFFF')

            Blank()
              .width(8)

            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(6)
                .backgroundColor('rgba(255, 255, 255, 0.2)')
                .borderRadius(4)

              Row()
                .width('75%')
                .height(6)
                .backgroundColor(AppTheme.progressColor)
                .borderRadius(4)
            }
            .height(6)
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Stack() {
          Circle()
            .width(60)
            .height(60)
            .fill('#FFFFFF')

          Text('▶')
            .fontSize(30)
            .fontColor(AppTheme.primary)
            .translate({ x: 2 })
        }
        .width(60)
        .height(60)
      }
      .width('100%')
      .height(140)
      .padding(20)
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
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
            .fontColor(category === 'Design' ? '#FFFFFF' : '#8E8E93')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : AppTheme.surface)
            .borderRadius(12)
        }, (category: string) => category)

        Blank()
          .width(12)
      }
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = recommendedCourses

  build() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)

        Blank()

        Text('See all')
          .fontSize(14)
          .fontColor('#8E8E93')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
      }, (course: Course) => course.title)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CourseCard {
  course: Course

  build() {
    Row({ space: 0 }) {
      Stack() {
        Text(this.course.iconName)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(this.course.bgColor)
      .borderRadius({
        topLeft: 20,
        topRight: 0,
        bottomLeft: 20,
        bottomRight: 0
      })

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
            .fontSize(12)
            .fontColor('#FFB300')

          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#8E8E93')
        }
        .alignItems(VerticalAlign.Center)
      }
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('♥')
        .fontSize(20)
        .fontColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(AppTheme.surface)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()

      Text('⌂')
        .fontSize(24)
        .fontColor('#FFFFFF')

      Blank()

      Text('⌕')
        .fontSize(24)
        .fontColor('#8E8E93')

      Blank()

      Text('♥')
        .fontSize(22)
        .fontColor('#8E8E93')

      Blank()

      Text('●')
        .fontSize(22)
        .fontColor('#8E8E93')

      Blank()
    }
    .width('calc(100% - 48vp)')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.2)',
      offsetX: 0,
      offsetY: 4
    })
  }
}