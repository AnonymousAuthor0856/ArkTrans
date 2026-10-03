import { router } from '@kit.ArkUI';

// MARK: - Models
interface Course {
  id: string;
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
  iconName: Resource;
}

// MARK: - Theme
class AppTheme {
  static readonly primary: string = '#4E31AA';
  static readonly secondary: string = '#3A1C71';
  static readonly background: string = '#F5F5F7';
  static readonly surface: string = '#FFFFFF';
  static readonly onBackground: string = '#1C1B1F';
  static readonly progressColor: string = '#FFA726';
  static readonly selectedCategoryColor: string = '#FF7043';
}

@Entry
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
          Blank().height(100)
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(AppTheme.background)

      BottomNavigationBar()
        .margin({ bottom: 24 })
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
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Image($r('sys.symbol.bell'))
          .width(24)
          .height(24)
          .fillColor(AppTheme.onBackground)

        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill(`${AppTheme.primary}33`)

          Image($r('sys.symbol.face_smiling'))
            .width(24)
            .height(24)
            .fillColor(AppTheme.primary)
        }
      }
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('sys.symbol.magnifyingglass'))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)

      Blank().width(16)

      Text('Search for course...')
        .fontColor('#AAAAAA')
        .fontSize(14)

      Blank()

      Image($r('sys.symbol.slider_horizontal_3'))
        .width(20)
        .height(20)
        .fillColor(AppTheme.primary)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
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
        .width('100%')

      Stack() {
        RoundedRect()

        Row({ space: 16 }) {
          Column({ space: 0 }) {
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
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            Circle()
              .width(60)
              .height(60)
              .fill(Color.White)

            Image($r('sys.symbol.play_fill'))
              .width(28)
              .height(28)
              .fillColor(AppTheme.primary)
              .margin({ left: 4 })
          }
        }
        .padding(20)
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(140)
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
  }
}

@Component
struct RoundedRect {
  build() {
    Row()
      .width('100%')
      .height(140)
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
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
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : Color.Gray)
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
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    {
      id: '1',
      title: 'Mobile Dev',
      subtitle: 'Android Compose',
      rating: '4.9',
      bgColor: '#E3F2FD',
      accentColor: '#1565C0',
      iconName: $r('sys.symbol.checkmark_circle_fill')
    },
    {
      id: '2',
      title: 'Photography',
      subtitle: 'Master Lighting',
      rating: '4.7',
      bgColor: '#FCE4EC',
      accentColor: '#C2185B',
      iconName: $r('sys.symbol.star_fill')
    },
    {
      id: '3',
      title: 'Finance',
      subtitle: 'Crypto Trading',
      rating: '4.5',
      bgColor: '#E8F5E9',
      accentColor: '#2E7D32',
      iconName: $r('sys.symbol.star_fill')
    }
  ];

  build() {
    Column({ space: 16 }) {
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
      .justifyContent(FlexAlign.SpaceBetween)

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
  }
}

@Component
struct CourseCard {
  course: Course = {
    id: '',
    title: '',
    subtitle: '',
    rating: '',
    bgColor: Color.White,
    accentColor: Color.Black,
    iconName: $r('sys.symbol.star_fill')
  };

  build() {
    Row() {
      Stack() {
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(this.course.bgColor)

        Image(this.course.iconName)
          .width(32)
          .height(32)
          .fillColor(this.course.accentColor)
      }
      .width(100)
      .height(100)
      .borderRadius({ topLeft: 20, bottomLeft: 20, topRight: 0, bottomRight: 0 })
      .clip(true)

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
          Image($r('sys.symbol.star_fill'))
            .width(12)
            .height(12)
            .fillColor('#FFB300')

          Text(this.course.rating)
            .fontSize(12)
            .fontColor(Color.Gray)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      Blank()

      Image($r('sys.symbol.heart_fill'))
        .width(20)
        .height(20)
        .fillColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()

      Image($r('sys.symbol.house_fill'))
        .width(24)
        .height(24)
        .fillColor(Color.White)

      Blank()

      Image($r('sys.symbol.magnifyingglass'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)

      Blank()

      Image($r('sys.symbol.heart_fill'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)

      Blank()

      Image($r('sys.symbol.person_fill'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)

      Blank()
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.2)',
      offsetX: 0,
      offsetY: 4
    })
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }
}