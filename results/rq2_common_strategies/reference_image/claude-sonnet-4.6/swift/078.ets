// CourseDashboard.ets
// HarmonyOS ArkTS (ArkUI) port of the SwiftUI CourseDashboardScreen.
// Register this page in resources/base/profile/main_pages.json:
//   { "src": ["pages/CourseDashboard"] }

const COLOR_PRIMARY: string = '#FF4E31AA';        // 0xFF4E31AA
const COLOR_SECONDARY: string = '#FF3A1C71';      // 0xFF3A1C71
const COLOR_BACKGROUND: string = '#FFF5F5F7';     // 0xFFF5F5F7
const COLOR_SURFACE: string = '#FFFFFFFF';
const COLOR_ON_BACKGROUND: string = '#FF1C1B1F';  // 0xFF1C1B1F
const COLOR_PROGRESS: string = '#FFFFA726';       // 0xFFFFA726
const COLOR_SELECTED: string = '#FFFF7043';       // 0xFFFF7043
const COLOR_NAV: string = '#FF1E1E1E';            // 0xFF1E1E1E
const COLOR_MUTED: string = '#FF9E9E9E';
const COLOR_HINT: string = '#FFC7C7CC';
const COLOR_AMBER: string = '#FFFFB300';
const COLOR_HEART: string = '#FFE8E8E8';

class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  icon: string;

  constructor(title: string, subtitle: string, rating: string,
              bgColor: string, accentColor: string, icon: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.icon = icon;
  }
}

const CATEGORIES: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

const COURSES: Course[] = [
  new Course('Mobile Dev', 'Android Compose', '4.9', '#FFE3F2FD', '#FF1466BF', '\u2714'),
  new Course('Photography', 'Master Lighting', '4.7', '#FFFCE3ED', '#FFC2175C', '\u2605'),
  new Course('Finance', 'Crypto Trading', '4.5', '#FFE8F5EB', '#FF2E7D32', '\u2605')
];

@Entry
@Component
struct CourseDashboard {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
            SearchBarSection()
            OngoingCourseSection()
            CategoriesSection()
            RecommendedSection()
            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      BottomNavigationBar()
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}

// MARK: - Header
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(COLOR_MUTED)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Text('\uD83D\uDD14')          // bell
          .fontSize(22)
        Stack() {
          Column()
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#334E31AA')
          Text('\uD83D\uDE0A')        // smiling face
            .fontSize(24)
        }
        .width(48)
        .height(48)
        .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Search bar
@Component
struct SearchBarSection {
  build() {
    Column() {
      Row() {
        Text('\uD83D\uDD0D')          // magnifier
          .fontSize(18)
        Text('Search for course...')
          .fontSize(16)
          .fontColor(COLOR_HINT)
          .layoutWeight(1)
          .margin({ left: 16 })
        Text('\u2699')                // sliders / settings
          .fontSize(20)
          .fontColor(COLOR_PRIMARY)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(16)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - Ongoing course
@Component
struct OngoingCourseSection {
  build() {
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
            .fontColor(Color.White)
            .margin({ top: 8 })

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor(Color.White)
            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(6)
                .borderRadius(3)
                .backgroundColor('#33FFFFFF')
              Row()
                .width('75%')
                .height(6)
                .borderRadius(3)
                .backgroundColor(COLOR_PROGRESS)
            }
            .layoutWeight(1)
            .height(6)
            .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 16 })
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Stack() {
          Column()
            .width(60)
            .height(60)
            .borderRadius(30)
            .backgroundColor(Color.White)
          Text('\u25B6')               // play
            .fontSize(26)
            .fontColor(COLOR_PRIMARY)
            .margin({ left: 4 })
        }
        .width(60)
        .height(60)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .padding(20)
      .backgroundColor(COLOR_PRIMARY)
      .borderRadius(24)
      .margin({ top: 16 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

// MARK: - Categories
@Component
struct CategoriesSection {
  build() {
    Scroll() {
      Row() {
        Blank().width(24)
        ForEach(CATEGORIES, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : COLOR_MUTED)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? COLOR_SELECTED : COLOR_SURFACE)
            .borderRadius(12)
            .margin({ right: 12 })
        }, (category: string) => category)
        Blank().width(24)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .align(Alignment.Start)
    .width('100%')
  }
}

// MARK: - Recommended
@Component
struct RecommendedSection {
  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
          .layoutWeight(1)
        Text('See all')
          .fontSize(16)
          .fontColor(COLOR_MUTED)
      }
      .width('100%')
      .margin({ bottom: 16 })
      .alignItems(VerticalAlign.Center)

      ForEach(COURSES, (course: Course) => {
        CourseCard({ course: course })
      }, (course: Course) => course.title)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

// MARK: - Course card
@Component
struct CourseCard {
  course: Course = new Course('', '', '', COLOR_SURFACE, '#FF000000', '');

  build() {
    Row() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.course.bgColor)
        Text(this.course.icon)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.course.accentColor)
      }
      .width(100)
      .height('100%')
      .borderRadius({ topLeft: 20, bottomLeft: 20, topRight: 0, bottomRight: 0 })

      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
          .margin({ top: 4 })
        Row() {
          Text('\u2605')
            .fontSize(12)
            .fontColor(COLOR_AMBER)
          Text(this.course.rating)
            .fontSize(12)
            .fontColor(COLOR_MUTED)
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding(16)

      Text('\u2665')                 // heart
        .fontSize(20)
        .fontColor(COLOR_HEART)
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(20)
    .clip(true)
    .margin({ bottom: 16 })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Bottom navigation
@Component
struct BottomNavigationBar {
  build() {
    Column() {
      Row() {
        Text('\uD83C\uDFE0').fontSize(22)                    // home
        Text('\uD83D\uDD0D').fontSize(22)                    // search
        Text('\u2665').fontSize(22).fontColor('#FF8E8E8E')   // heart (inactive)
        Text('\uD83D\uDC64').fontSize(22)                    // person
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_NAV)
      .borderRadius(32)
      .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}