class AppTheme {
  static primary: string = '#4E31AA'
  static secondary: string = '#3A1C71'
  static background: string = '#F5F5F7'
  static surface: string = '#FFFFFF'
  static onBackground: string = '#1C1B1F'
  static progressColor: string = '#FFA726'
  static selectedCategoryColor: string = '#FF7043'
  static gray: string = '#808080'
  static lightGray: string = '#D3D3D3'
  static amber: string = '#FFB300'
  static navDark: string = '#1E1E1E'
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
struct Index {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1466BF', 'Check'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', 'Star'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', 'Star')
  ]

  @Builder
  HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(AppTheme.gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row({ space: 8 }) {
        Button('Bell')
          .fontSize(12)
          .fontColor(AppTheme.onBackground)
          .backgroundColor('#00000000')
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#334E31AA')
          Text('Face')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.primary)
        }
        .width(48)
        .height(48)
      }
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('Search')
        .fontSize(12)
        .fontColor(AppTheme.gray)
      Blank()
        .width(16)
      Text('Search for course...')
        .fontSize(14)
        .fontColor(AppTheme.lightGray)
      Blank()
        .layoutWeight(1)
      Text('Filter')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTheme.primary)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppTheme.surface)
    .borderRadius(16)
  }

  @Builder
  ProgressBar(percent: number) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(6)
        .fill('#33FFFFFF')
        .radius(4)
      Rect()
        .width(percent.toString() + '%')
        .height(6)
        .fill(AppTheme.progressColor)
        .radius(4)
    }
    .width('100%')
    .height(6)
  }

  @Builder
  OngoingCourseSection() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)
        .width('100%')

      Stack() {
        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#B3FFFFFF')
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
              this.ProgressBar(75)
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            Circle()
              .width(60)
              .height(60)
              .fill('#FFFFFF')
            Text('Play')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTheme.primary)
          }
          .width(60)
          .height(60)
        }
        .width('100%')
        .padding(20)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(140)
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoryChip(category: string) {
    Text(category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(category === 'Design' ? '#FFFFFF' : AppTheme.gray)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : AppTheme.surface)
      .borderRadius(12)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row({ space: 12 }) {
        Blank()
          .width(12)
        ForEach(this.categories, (category: string) => {
          this.CategoryChip(category)
        })
        Blank()
          .width(12)
      }
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack() {
        Text(course.iconName)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(course.bgColor)
      .borderRadius(20)

      Column({ space: 4 }) {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.primary)
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Row({ space: 4 }) {
          Text('*')
            .fontSize(12)
            .fontColor(AppTheme.amber)
          Text(course.rating)
            .fontSize(12)
            .fontColor(AppTheme.gray)
        }
      }
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('♥')
        .fontSize(16)
        .fontColor('#EEEEEE')
        .backgroundColor('#00000000')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(AppTheme.surface)
    .borderRadius(20)
  }

  @Builder
  RecommendedSection() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Blank()
          .layoutWeight(1)
        Text('See all')
          .fontSize(14)
          .fontColor(AppTheme.gray)
      }
      .width('100%')

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Blank().layoutWeight(1)
      Text('Home')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
      Blank().layoutWeight(1)
      Text('Search')
        .fontSize(12)
        .fontColor(AppTheme.gray)
      Blank().layoutWeight(1)
      Text('Fav')
        .fontSize(12)
        .fontColor(AppTheme.gray)
      Blank().layoutWeight(1)
      Text('Me')
        .fontSize(12)
        .fontColor(AppTheme.gray)
      Blank().layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor(AppTheme.navDark)
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()

          Column() {
            this.SearchBarSection()
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
          Blank()
            .height(100)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      Column() {
        Blank()
          .layoutWeight(1)
        Column() {
          this.BottomNavigationBar()
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
  }
}
