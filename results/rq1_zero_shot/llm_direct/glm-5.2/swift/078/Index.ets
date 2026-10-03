// CourseDashboardScreen.ets

// MARK: - Models
class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
  iconName: Resource;

  constructor(title: string, subtitle: string, rating: string, bgColor: ResourceColor, accentColor: ResourceColor, iconName: Resource) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.iconName = iconName;
  }
}

// MARK: - Theme
class AppTheme {
  static readonly primary: ResourceColor = '#4E31AA';
  static readonly secondary: ResourceColor = '#3A1C71';
  static readonly background: ResourceColor = '#F5F5F7';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#1C1B1F';
  static readonly progressColor: ResourceColor = '#FFA726';
  static readonly selectedCategoryColor: ResourceColor = '#FF7043';
}

// MARK: - Main Screen
@Entry
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTheme.background)

      // Main Content
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          Blank().height(100) // Bottom padding for floating nav bar
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      // Floating Bottom Navigation
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
  }
}

// MARK: - Sections

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
          .margin({ bottom: 4 })

        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Button({ type: ButtonType.Normal }) {
          Image($r('sys.media.ohos_ic_public_notify'))
            .width(24)
            .height(24)
            .fillColor(AppTheme.onBackground)
        }
        .backgroundColor(Color.Transparent)

        Stack() {
          Circle({ width: 48, height: 48 })
            .fillColor(AppTheme.primary)
            .opacity(0.2)

          Image($r('sys.media.ohos_ic_public_contacts'))
            .width(24)
            .height(24)
            .fillColor(AppTheme.primary)
        }
      }
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
      Image($r('sys.media.ohos_ic_public_search'))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)

      Blank().width(16)

      Text('Search for course...')
        .fontColor(Color.LightGray)
        .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(20)
        .height(20)
        .fillColor(AppTheme.primary)
    }
    .height(56)
    .width('90%')
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin({ bottom: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)
        .margin({ bottom: 16 })

      Stack() {
        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor(Color.White)
              .opacity(0.7)
              .margin({ bottom: 8 })

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ bottom: 16 })

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ right: 8 })

              Stack({ alignContent: Alignment.Start }) {
                // Background Track
                Column()
                  .width('100%')
                  .height(6)
                  .borderRadius(4)
                  .backgroundColor(Color.White)
                  .opacity(0.2)

                // Progress Track
                Column()
                  .width('75%')
                  .height(6)
                  .borderRadius(4)
                  .backgroundColor(AppTheme.progressColor)
              }
              .height(6)
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .height('100%')
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // Play Button
          Stack() {
            Circle({ width: 60, height: 60 })
              .fillColor(Color.White)

            Image($r('sys.media.ohos_ic_public_play'))
              .width(32)
              .height(32)
              .fillColor(AppTheme.primary)
              .margin({ left: 4 }) // Visual center adjustment
          }
        }
        .width('100%')
        .height('100%')
        .padding(20)
      }
      .width('100%')
      .height(140)
      .borderRadius(24)
      .backgroundColor(AppTheme.primary)
      .clip(true)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

  build() {
    Scroll() {
      Row({ space: 12 }) {
        Blank().width(12)

        ForEach(this.categories, (category: string) => {
          let isSelected = category === 'Design';
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(isSelected ? Color.White : Color.Gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(isSelected ? AppTheme.selectedCategoryColor : Color.White)
            .borderRadius(12)
        })

        Blank().width(12)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FB', '#1466BF', $r('sys.media.ohos_ic_public_done')),
    new Course('Photography', 'Master Lighting', '4.7', '#FDE3EF', '#C2175C', $r('sys.media.ohos_ic_public_star_filled')),
    new Course('Finance', 'Crypto Trading', '4.5', '#E9F6EB', '#2E7D33', $r('sys.media.ohos_ic_public_star_filled'))
  ];

  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)

        Blank()

        Text('See all')
          .fontColor(Color.Gray)
      }
      .width('100%')
      .margin({ bottom: 16 })

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
          .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

// Custom style to simulate SwiftUI's CustomCornerShape (rounding only left corners)
@Extend(Column)
function customLeftCornerShape(radius: number) {
  .borderRadius({ topLeft: radius, bottomLeft: radius })
  .clip(true)
}

@Component
struct CourseCard {
  private course: Course;

  build() {
    Row() {
      // Left Icon Box
      Column() {
        Image(this.course.iconName)
          .width(32)
          .height(32)
          .fillColor(this.course.accentColor)
      }
      .width(100)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.course.bgColor)
      .customLeftCornerShape(20)

      // Content
      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.primary)
          .margin({ bottom: 4 })

        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
          .margin({ bottom: 4 })

        Row({ space: 4 }) {
          Image($r('sys.media.ohos_ic_public_star_filled'))
            .width(12)
            .height(12)
            .fillColor('#FFB300')

          Text(this.course.rating)
            .fontSize(12)
            .fontColor(Color.Gray)
        }
      }
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Favorite Icon
      Button({ type: ButtonType.Normal }) {
        Image($r('sys.media.ohos_ic_public_heart_filled'))
          .width(24)
          .height(24)
          .fillColor('#EEEEEE')
      }
      .backgroundColor(Color.Transparent)
      .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .clip(true)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()
      Image($r('sys.media.ohos_ic_public_home'))
        .width(24)
        .height(24)
        .fillColor(Color.White)
      Blank()
      Image($r('sys.media.ohos_ic_public_search'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Blank()
      Image($r('sys.media.ohos_ic_public_heart_filled'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Blank()
      Image($r('sys.media.ohos_ic_public_contacts'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Blank()
    }
    .width('90%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33111111', offsetX: 0, offsetY: 4 })
  }
}