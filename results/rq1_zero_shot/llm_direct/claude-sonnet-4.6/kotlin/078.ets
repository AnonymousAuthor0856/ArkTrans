import { curves } from '@kit.ArkUI';

interface Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
}

@Entry
@Component
struct CourseDashboardScreen {
  @State scrollOffset: number = 0;

  private courses: Course[] = [
    {
      title: 'Mobile Dev',
      subtitle: 'Android Compose',
      rating: '4.9',
      bgColor: '#E3F2FD',
      accentColor: '#1565C0'
    },
    {
      title: 'Photography',
      subtitle: 'Master Lighting',
      rating: '4.7',
      bgColor: '#FCE4EC',
      accentColor: '#C2185B'
    },
    {
      title: 'Finance',
      subtitle: 'Crypto Trading',
      rating: '4.5',
      bgColor: '#E8F5E9',
      accentColor: '#2E7D32'
    }
  ];

  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
          Blank().height(80)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
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
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.ic_notification'))
            .width(24)
            .height(24)
            .fillColor('#1C1B1F')
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)

        Stack() {
          Text('😊')
            .fontSize(24)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#334E31AA')
        .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('🔍')
        .fontSize(20)
        .fontColor(Color.Gray)

      Text('Search for course...')
        .fontSize(14)
        .fontColor('#BDBDBD')
        .margin({ left: 16 })
        .layoutWeight(1)

      Text('⚙️')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24 })
    .borderRadius(16)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')

      Column() {
        Row() {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.7)')

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ top: 8 })

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor(Color.White)

              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .color('#FFA726')
                .backgroundColor('rgba(255,255,255,0.2)')
                .style({ strokeWidth: 6 })
                .layoutWeight(1)
                .margin({ left: 8 })
                .borderRadius(4)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 16 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Text('▶')
              .fontSize(28)
              .fontColor('#4E31AA')
          }
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(Color.White)
          .margin({ left: 16 })
        }
        .width('100%')
        .height('100%')
        .padding(20)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(140)
      .borderRadius(24)
      .backgroundColor('#4E31AA')
      .margin({ top: 16 })
      .shadow({ radius: 8, color: '#334E31AA', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          this.CategoryItem(category)
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  CategoryItem(category: string) {
    Text(category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(category === 'Design' ? Color.White : Color.Gray)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .borderRadius(12)
      .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')

        Text('See all')
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: 16 }) {
        ForEach(this.courses, (course: Course) => {
          this.CourseCard(course)
        })
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
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

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')

        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 2 })

        Row() {
          Text('⭐')
            .fontSize(14)
            .fontColor('#FFB300')

          Text(course.rating)
            .fontSize(12)
            .fontColor(Color.Gray)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Text('♡')
        .fontSize(22)
        .fontColor('#EEEEEE')
        .padding(12)
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .clip(true)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('🏠')
        .fontSize(24)
        .fontColor(Color.White)

      Text('🔍')
        .fontSize(24)
        .fontColor(Color.Gray)

      Text('♡')
        .fontSize(24)
        .fontColor(Color.Gray)

      Text('😊')
        .fontSize(24)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16, left: 24, right: 24 })
    .margin({ left: 24, right: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .shadow({ radius: 16, color: '#401E1E1E', offsetX: 0, offsetY: -4 })
  }
}