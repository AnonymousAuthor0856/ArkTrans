// CourseDashboard.ets

// MARK: - Theme
class AppTheme {
  static readonly primary: string = '#4E31AA';
  static readonly secondary: string = '#3A1C71';
  static readonly background: string = '#F5F5F7';
  static readonly surface: string = '#FFFFFF';
  static readonly onBackground: string = '#1C1B1F';
  static readonly progressColor: string = '#FFA726';
  static readonly selectedCategoryColor: string = '#FF7043';
  static readonly gray: string = '#888888';
  static readonly lightGray: string = '#AAAAAA';
  static readonly bottomNavBg: string = '#1E1E1E';
  static readonly favoriteGray: string = '#EEEEEE';
  static readonly amberStar: string = '#FFB300';
}

// MARK: - Models
class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconName: Resource;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, iconName: Resource) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.iconName = iconName;
  }
}

// MARK: - Main Entry
@Entry
@Component
struct CourseApp {
  build() {
    Column() {
      CourseDashboardScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
  }
}

// MARK: - Main Screen
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Scrollable Content
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          // Bottom padding for floating nav bar
          Blank().height(100) 
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .align(Alignment.Top)

      // Floating Bottom Navigation
      BottomNavigationBar()
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
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
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(AppTheme.gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // Spacer

      Row({ space: 8 }) {
        // Bell Icon Button
        Image($r('sys.media.ohos_ic_public_notice'))
          .width(24).height(24)
          .fillColor(AppTheme.onBackground)
        
        // Profile Circle
        Stack() {
          Circle({ width: 48, height: 48 })
            .fill(AppTheme.primary)
            .opacity(0.2)
          Image($r('sys.media.ohos_ic_public_contacts'))
            .width(24).height(24)
            .fillColor(AppTheme.primary)
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
      Image($r('sys.media.ohos_ic_public_search'))
        .width(20).height(20)
        .fillColor(AppTheme.gray)
      
      Text('Search for course...')
        .fontColor(AppTheme.lightGray)
        .margin({ left: 16 })
      
      Blank() // Spacer

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(20).height(20)
        .fillColor(AppTheme.primary)
    }
    .width('90%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppTheme.surface)
    .borderRadius(16)
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
              .fontColor('#FFFFFF')
              .opacity(0.7)
            
            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ top: 8 })

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor('#FFFFFF')
                .margin({ right: 8 })

              // Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Background
                Column()
                  .width('100%')
                  .height(6)
                  .backgroundColor('#FFFFFF')
                  .opacity(0.2)
                  .borderRadius(4)
                
                // Fill
                Column()
                  .width('75%') // Hardcoded 75% width relative to the progress bar container
                  .height(6)
                  .backgroundColor(AppTheme.progressColor)
                  .borderRadius(4)
              }
              .width('100%')
              .height(6)
              .layoutWeight(1) // Fill available space
            }
            .width('100%')
            .margin({ top: 16 })
          }
          .layoutWeight(1)
          .height('100%')
          .alignItems(HorizontalAlign.Start)

          // Play Button
          Stack() {
            Circle({ width: 60, height: 60 })
              .fill('#FFFFFF')
            Image($r('sys.media.ohos_ic_public_play'))
              .width(32).height(32)
              .fillColor(AppTheme.primary)
              .margin({ left: 4 }) // Visual center adjustment
          }
        }
        .width('100%')
        .height('100%')
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
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? '#FFFFFF' : AppTheme.gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : AppTheme.surface)
            .borderRadius(12)
        })
      }
      .padding({ left: 12, right: 12 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1466C0', $r('sys.media.ohos_ic_public_check')),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', $r('sys.media.ohos_ic_public_star')),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', $r('sys.media.ohos_ic_public_star'))
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
          .fontColor(AppTheme.gray)
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

@Component
struct CourseCard {
  @Prop course: Course;

  build() {
    Row() {
      // Left Icon Box
      Stack() {
        Image(this.course.iconName)
          .width(32).height(32)
          .fillColor(this.course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(this.course.bgColor)
      .borderRadius({ topLeft: 20, bottomLeft: 20 })

      // Content
      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.primary)
        
        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
          .margin({ top: 4 })

        Row({ space: 4 }) {
          Image($r('sys.media.ohos_ic_public_star'))
            .width(12).height(12)
            .fillColor(AppTheme.amberStar)
          Text(this.course.rating)
            .fontSize(12)
            .fontColor(AppTheme.gray)
        }
        .margin({ top: 4 })
      }
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Favorite Icon
      Image($r('sys.media.ohos_ic_public_heart'))
        .width(24).height(24)
        .fillColor(AppTheme.favoriteGray)
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
      Image($r('sys.media.ohos_ic_public_home'))
        .width(24).height(24)
        .fillColor('#FFFFFF')
      Blank()
      Image($r('sys.media.ohos_ic_public_search'))
        .width(24).height(24)
        .fillColor(AppTheme.gray)
      Blank()
      Image($r('sys.media.ohos_ic_public_heart'))
        .width(24).height(24)
        .fillColor(AppTheme.gray)
      Blank()
      Image($r('sys.media.ohos_ic_public_contacts'))
        .width(24).height(24)
        .fillColor(AppTheme.gray)
      Blank()
    }
    .width('90%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor(AppTheme.bottomNavBg)
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
  }
}