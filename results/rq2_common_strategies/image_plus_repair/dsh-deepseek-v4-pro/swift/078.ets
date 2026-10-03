// Translation of SwiftUI source (078.swift) into ArkTS / ArkUI declarative UI.
// SF Symbols (Image(systemName:)) are rendered as text glyphs since ArkUI has no
// direct SF Symbol set; the original author already replaced several icons.

@Entry
@Component
struct CourseApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) and .statusBarHidden(true) are app-level
    // settings with no direct ArkUI build() equivalent; they are configured on
    // the entry ability instead.
    CourseDashboardScreen()
  }
}

// MARK: - Models
class Course {
  id: string
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string

  constructor(id: string, title: string, subtitle: string, rating: string,
              bgColor: string, accentColor: string, iconName: string) {
    this.id = id
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
    this.iconName = iconName
  }
}

// MARK: - Theme
class AppTheme {
  static readonly primary: string = '#4E31AA' // 0xFF4E31AA
  static readonly secondary: string = '#3A1C71' // 0xFF3A1C71
  static readonly background: string = '#F5F5F7' // 0xFFF5F5F7
  static readonly surface: string = '#FFFFFF'
  static readonly onBackground: string = '#1C1B1F' // 0xFF1C1B1F
  static readonly progressColor: string = '#FFA726' // 0xFFFFA726
  static readonly selectedCategoryColor: string = '#FF7043' // 0xFFFF7043
  static readonly gray: string = '#999999'
  static readonly lightGray: string = '#D3D3D3'
  static readonly systemGray5: string = '#EEEEEE'
}

// MARK: - Main Screen
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main scrolling content
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          Blank().height(100) // Bottom padding for floating nav bar
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      // Floating bottom navigation
      Column() {
        Blank()
        BottomNavigationBar()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Sections
@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold) // HeadlineMedium
          .fontColor(AppTheme.onBackground)
        Text("Let's start learning!")
          .fontSize(16) // BodyLarge
          .fontColor(AppTheme.gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Button({ type: ButtonType.Normal }) {
          Text('🔔')
            .fontSize(24)
            .fontColor(AppTheme.onBackground)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
        })

        Stack() {
          Circle()
            .fill('rgba(78,49,170,0.2)') // AppTheme.primary.opacity(0.2)
            .width(48)
            .height(48)

          Text('😊') // Replaced Face
            .fontSize(24)
            .fontColor(AppTheme.primary)
        }
      }
    }
    .width('100%')
    .padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Text('🔍')
        .fontColor(AppTheme.gray)

      Blank().width(16)

      Text('Search for course...')
        .fontColor(AppTheme.lightGray)

      Blank()

      Text('☰') // Replaced Settings icon for filter
        .fontColor(AppTheme.primary)
    }
    .padding({ left: 16, right: 16 })
    .height(56)
    .backgroundColor(Color.White)
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
        .fontWeight(FontWeight.Bold) // TitleLarge
        .fontColor(AppTheme.onBackground)

      Stack() {
        Row()
          .width('100%')
          .height(140)
          .backgroundColor(AppTheme.primary)
          .borderRadius(24)

        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.7)')

            Blank().height(8)

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)

            Blank().height(16)

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor(Color.White)

              Blank().width(8)

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(6)
                  .backgroundColor('rgba(255,255,255,0.2)')
                  .borderRadius(4)

                Row()
                  .width('75%')
                  .height(6)
                  .backgroundColor(AppTheme.progressColor)
                  .borderRadius(4)
              }
              .layoutWeight(1)
              .height(6)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            Circle()
              .fill(Color.White)
              .width(60)
              .height(60)

            Text('▶')
              .fontSize(32) // Adjusted size
              .fontColor(AppTheme.primary)
              .offset({ x: 2 }) // Visual center adjustment
          }
        }
        .width('100%')
        .padding(20)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

@Component
struct CategoriesSection {
  categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        // Leading padding
        Blank().width(12)

        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : AppTheme.gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : Color.White)
            .borderRadius(12)
        }, (category: string) => category)

        // Trailing padding
        Blank().width(12)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecommendedSection {
  // SwiftUI UUID() ids are replaced with stable string keys for ForEach.
  courses: Course[] = [
    new Course('1', 'Mobile Dev', 'Android Compose', '4.9', '#E3F2FC', '#1466BF', '✅'),
    new Course('2', 'Photography', 'Master Lighting', '4.7', '#FCE3ED', '#C2175C', '★'),
    new Course('3', 'Finance', 'Crypto Trading', '4.5', '#E8F5EB', '#2E7D33', '★')
  ]

  build() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold) // TitleLarge
          .fontColor(AppTheme.onBackground)
        Blank()
        Text('See all')
          .fontColor(AppTheme.gray)
      }
      .width('100%')

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
      }, (course: Course) => course.id)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

@Component
struct CourseCard {
  course: Course = new Course('', '', '', '', '', '', '')

  build() {
    Stack() {
      Row()
        .width('100%')
        .height(100)
        .backgroundColor(Color.White)
        .borderRadius(20)

      Row({ space: 0 }) {
        // Left Icon Box
        Stack() {
          Row()
            .width('100%')
            .height('100%')
            .backgroundColor(this.course.bgColor)

          Text(this.course.iconName)
            .fontSize(32)
            .fontColor(this.course.accentColor)
        }
        .width(100)
        .height('100%')
        .borderRadius({ topLeft: 20, bottomLeft: 20 })

        // Content
        Column({ space: 4 }) {
          Text(this.course.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.primary)

          Text(this.course.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold) // TitleMedium
            .fontColor(AppTheme.onBackground)

          Row({ space: 4 }) {
            Text('★')
              .fontSize(12) // Adjusted size
              .fontColor('#FFB300') // Amber

            Text(this.course.rating)
              .fontSize(12)
              .fontColor(AppTheme.gray)
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .layoutWeight(1)

        // Favorite Icon
        Button({ type: ButtonType.Normal }) {
          Text('♥')
            .fontColor(AppTheme.systemGray5) // #EEEEEE equivalent usually very light gray
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
        })
        .margin({ right: 16 })
      }
      .width('100%')
      .height(100)
    }
    .width('100%')
    .height(100)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()
      Text('🏠')
        .fontColor(Color.White)
      Blank()
      Text('🔍')
        .fontColor(AppTheme.gray)
      Blank()
      Text('♥')
        .fontColor(AppTheme.gray)
      Blank()
      Text('👤')
        .fontColor(AppTheme.gray)
      Blank()
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24 })
  }
}

// MARK: - Helper Shapes
// SwiftUI's CustomCornerShape (UIBezierPath rounded rect with a subset of
// corners) is expressed in ArkUI via per-corner borderRadius values; see the
// left icon box in CourseCard, which uses { topLeft: 20, bottomLeft: 20 }.
