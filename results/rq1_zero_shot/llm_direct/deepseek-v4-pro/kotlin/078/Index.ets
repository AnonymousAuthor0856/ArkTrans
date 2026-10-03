import { curves } from '@kit.ArkUI';

@Entry
@Component
struct CourseDashboardScreen {
  @State selectedCategory: string = 'Design';
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32')
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
        .position({ x: 0, y: '100%' })
        .translate({ y: -80 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Stack() {
          Text('🔔')
            .fontSize(24)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#F0EDF7')
        .alignContent(Alignment.Center)

        Stack() {
          Text('👤')
            .fontSize(24)
            .fontColor('#4E31AA')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#E8E3F5')
        .alignContent(Alignment.Center)
        .margin({ left: 8 })
      }
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('🔍')
        .fontSize(20)
        .fontColor('#888888')
      Text('Search for course...')
        .fontSize(16)
        .fontColor('#BBBBBB')
        .margin({ left: 12 })
      Blank()
      Text('⚙️')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .borderRadius(16)
    .backgroundColor('#FFFFFF')
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .margin({ left: 24, right: 24, top: 16 })

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#CCCCCC')
          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 6 })

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor('#FFFFFF')
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .width(120)
              .height(6)
              .color('#FFA726')
              .backgroundColor('#55FFFFFF')
              .borderRadius(4)
              .margin({ left: 8 })
          }
          .margin({ top: 14 })
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Stack() {
          Text('▶')
            .fontSize(28)
            .fontColor('#4E31AA')
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#FFFFFF')
        .alignContent(Alignment.Center)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .borderRadius(24)
      .backgroundColor('#4E31AA')
      .padding(20)
      .margin({ left: 24, right: 24, top: 12 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoriesSection() {
    Column() {
      Scroll() {
        Row() {
          ForEach(this.categories, (category: string) => {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#888888')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .borderRadius(12)
              .backgroundColor(category === this.selectedCategory ? '#FF7043' : '#FFFFFF')
              .margin({ right: 12 })
          })
        }
        .padding({ left: 24, right: 24 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .margin({ top: 8 })
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank()
        Text('See all')
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16 })
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack() {
        Text(course.title.includes('Mobile') ? '✅' : '⭐')
          .fontSize(28)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)
      .alignContent(Alignment.Center)

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 4 })
        Row() {
          Text('⭐')
            .fontSize(14)
            .fontColor('#FFB300')
          Text(course.rating)
            .fontSize(12)
            .fontColor('#888888')
            .margin({ left: 4 })
        }
        .margin({ top: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding(16)

      Text('🤍')
        .fontSize(22)
        .fontColor('#DDDDDD')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .margin({ left: 24, right: 24, top: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('🏠')
        .fontSize(24)
        .fontColor('#FFFFFF')
      Text('🔍')
        .fontSize(24)
        .fontColor('#888888')
      Text('❤️')
        .fontSize(24)
        .fontColor('#888888')
      Text('👤')
        .fontSize(24)
        .fontColor('#888888')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .margin({ left: 24, right: 24 })
    .shadow({ radius: 16, color: '#331E1E1E', offsetX: 0, offsetY: 4 })
  }
}

class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
  }
}