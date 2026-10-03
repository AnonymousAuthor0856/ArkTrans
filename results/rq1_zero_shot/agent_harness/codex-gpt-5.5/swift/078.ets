class AppTheme {
  static primary: string = '#4E31AA';
  static secondary: string = '#3A1C71';
  static background: string = '#F5F5F7';
  static surface: string = '#FFFFFF';
  static onBackground: string = '#1C1B1F';
  static progressColor: string = '#FFA726';
  static selectedCategoryColor: string = '#FF7043';
}

class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconName: string;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, iconName: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.iconName = iconName;
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1466BF', '✓'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', '★'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', '★')
  ];

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Row({ space: 8 }) {
        Button('🔔')
          .fontSize(24)
          .fontColor(AppTheme.onBackground)
          .backgroundColor(Color.Transparent)
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#4E31AA33')
          Text('☺')
            .fontSize(24)
            .fontColor(AppTheme.primary)
        }
        .width(48)
        .height(48)
      }
    }
    .padding(24)
    .width('100%')
  }

  @Builder
  private SearchBarSection() {
    Row() {
      Text('⌕')
        .fontSize(20)
        .fontColor('#808080')
      Blank().width(16)
      Text('Search for course...')
        .fontSize(16)
        .fontColor('#BDBDBD')
      Blank()
      Text('☰')
        .fontSize(20)
        .fontColor(AppTheme.primary)
    }
    .padding({ left: 16, right: 16 })
    .height(56)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  private OngoingCourseSection() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)
      Stack() {
        Rect()
          .width('100%')
          .height(140)
          .fill(AppTheme.primary)
          .radius(24)
        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#FFFFFFB3')
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
                Rect()
                  .width('100%')
                  .height(6)
                  .fill('#FFFFFF33')
                  .radius(4)
                Rect()
                  .width('75%')
                  .height(6)
                  .fill(AppTheme.progressColor)
                  .radius(4)
              }
              .height(6)
              .layoutWeight(1)
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          Blank()
          Stack() {
            Circle()
              .width(60)
              .height(60)
              .fill(Color.White)
            Text('▶')
              .fontSize(32)
              .fontColor(AppTheme.primary)
              .margin({ left: 2 })
          }
        }
        .padding(20)
        .width('100%')
      }
      .width('100%')
      .height(140)
    }
    .padding(24)
    .width('100%')
  }

  @Builder
  private CategoriesSection() {
    Scroll() {
      Row({ space: 12 }) {
        Blank().width(12)
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : '#808080')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : Color.White)
            .borderRadius(12)
        })
        Blank().width(12)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  private CourseCard(course: Course) {
    Row({ space: 0 }) {
      Stack() {
        Rect()
          .width(100)
          .height(100)
          .fill(course.bgColor)
          .radius({ topLeft: 20, bottomLeft: 20 })
        Text(course.iconName)
          .fontSize(32)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height(100)

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
          Text('★')
            .fontSize(12)
            .fontColor('#FFB300')
          Text(course.rating)
            .fontSize(12)
            .fontColor('#808080')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      Button('♥')
        .fontColor('#EEEEEE')
        .backgroundColor(Color.Transparent)
        .margin({ right: 16 })
    }
    .height(100)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(20)
  }

  @Builder
  private RecommendedSection() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Blank()
        Text('See all')
          .fontSize(14)
          .fontColor('#808080')
      }
      .width('100%')
      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      })
    }
    .padding(24)
    .width('100%')
  }

  @Builder
  private BottomNavigationBar() {
    Row() {
      Blank()
      Text('⌂').fontSize(20).fontColor(Color.White)
      Blank()
      Text('⌕').fontSize(20).fontColor('#808080')
      Blank()
      Text('♥').fontSize(20).fontColor('#808080')
      Blank()
      Text('👤').fontSize(20).fontColor('#808080')
      Blank()
    }
    .padding({ top: 16, bottom: 16 })
    .width('100%')
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#00000033', offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24, bottom: 24 })
  }

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column({ space: 0 }) {
            this.HeaderSection()
            this.SearchBarSection()
            this.OngoingCourseSection()
            this.CategoriesSection()
            this.RecommendedSection()
            Blank().height(100)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomNavigationBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
  }
}
