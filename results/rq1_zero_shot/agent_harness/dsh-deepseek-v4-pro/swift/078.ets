// Translated from SwiftUI (078.swift) to ArkTS / ArkUI

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    CourseDashboardScreen()
    // .preferredColorScheme(.light)
    // .statusBarHidden(true)
  }
}

// MARK: - Models
class Course {
  id: string;
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconName: string;

  constructor(id: string, title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, iconName: string) {
    this.id = id;
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.iconName = iconName;
  }
}

// MARK: - Theme
const AP_THEME_PRIMARY = '#4E31AA';
const AP_THEME_SECONDARY = '#3A1C71';
const AP_THEME_BACKGROUND = '#F5F5F7';
const AP_THEME_SURFACE = '#FFFFFF';
const AP_THEME_ON_BACKGROUND = '#1C1B1F';
const AP_THEME_PROGRESS = '#FFA726';
const AP_THEME_SELECTED = '#FF7043';

// MARK: - Main Screen
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          Blank().height(100) // Bottom padding for floating nav bar
        }
      }
      .scrollBar(BarState.Off)

      Column() {
        Blank()
        BottomNavigationBar()
          .padding({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AP_THEME_BACKGROUND)
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
          .fontWeight(FontWeight.Bold)
          .fontColor(AP_THEME_ON_BACKGROUND)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Button() {
          Text('🔔')
            .fontSize(24)
            .fontColor(AP_THEME_ON_BACKGROUND)
        }
        .onClick(() => {})

        Stack() {
          Blank().width(48).height(48).backgroundColor('#334E31AA').borderRadius(24) // primary.opacity(0.2)
          Text('😊')
            .fontSize(24)
            .fontColor(AP_THEME_PRIMARY)
        }
      }
    }
    .padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Text('🔍')
        .fontColor('#808080')

      Blank().width(16)

      Text('Search for course...')
        .fontColor('#D3D3D3')

      Blank()

      Text('⚙')
        .fontColor(AP_THEME_PRIMARY)
    }
    .padding({ left: 16, right: 16 })
    .height(56)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AP_THEME_ON_BACKGROUND)

      Stack() {
        Blank().width('100%').height(140).backgroundColor(AP_THEME_PRIMARY).borderRadius(24)

        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .opacity(0.7)

            Blank().height(8)

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')

            Blank().height(16)

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor('#FFFFFF')

              Blank().width(8)

              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .color(AP_THEME_PROGRESS)
                .backgroundColor('#33FFFFFF') // white.opacity(0.2)
                .height(6)
                .layoutWeight(1)
            }
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            Blank().width(60).height(60).backgroundColor('#FFFFFF').borderRadius(30)
            Text('▶')
              .fontSize(32)
              .fontColor(AP_THEME_PRIMARY)
              .translate({ x: 2 })
          }
        }
        .padding(20)
      }
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
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? '#FFFFFF' : '#808080')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AP_THEME_SELECTED : '#FFFFFF')
            .borderRadius(12)
        }, (category: string) => category)
      }
      .padding({ left: 12, right: 12 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecommendedSection {
  courses: Course[] = [
    new Course('1', 'Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0', '✅'),
    new Course('2', 'Photography', 'Master Lighting', '4.7', '#FCE3ED', '#C2175C', '★'),
    new Course('3', 'Finance', 'Crypto Trading', '4.5', '#E8F5EB', '#2E7D33', '★')
  ]

  build() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AP_THEME_ON_BACKGROUND)
        Blank()
        Text('See all')
          .fontColor('#808080')
      }

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
  course: Course = new Course('', '', '', '', '#FFFFFF', '#000000', '')

  build() {
    Stack() {
      Blank().width('100%').height(100).backgroundColor('#FFFFFF').borderRadius(20)

      Row({ space: 0 }) {
        // Left Icon Box
        Stack() {
          Blank().width(100).height(100).backgroundColor(this.course.bgColor).borderRadius({ topLeft: 20, bottomLeft: 20 })
          Text(this.course.iconName)
            .fontSize(32)
            .fontColor(this.course.accentColor)
        }

        // Content
        Column({ space: 4 }) {
          Text(this.course.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AP_THEME_PRIMARY)

          Text(this.course.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AP_THEME_ON_BACKGROUND)

          Row({ space: 4 }) {
            Text('★')
              .fontSize(12)
              .fontColor('#FFB300')

            Text(this.course.rating)
              .fontSize(12)
              .fontColor('#808080')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)

        Blank()

        // Favorite Icon
        Button() {
          Text('❤')
            .fontSize(20)
            .fontColor('#EEEEEE')
        }
        .onClick(() => {})
        .margin({ right: 16 })
      }
    }
    .height(100)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()
      Text('🏠').fontColor('#FFFFFF')
      Blank()
      Text('🔍').fontColor('#808080')
      Blank()
      Text('❤').fontColor('#808080')
      Blank()
      Text('👤').fontColor('#808080')
      Blank()
    }
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
    .padding({ left: 24, right: 24 })
  }
}
