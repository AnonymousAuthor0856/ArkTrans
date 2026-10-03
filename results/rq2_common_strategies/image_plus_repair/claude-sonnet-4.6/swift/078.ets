import { LengthMetrics } from '@kit.ArkUI';

interface CourseItem {
  id: number;
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconType: string;
}

const courses: CourseItem[] = [
  {
    id: 1,
    title: 'Mobile Dev',
    subtitle: 'Android Compose',
    rating: '4.9',
    bgColor: '#E3F2FD',
    accentColor: '#1565C0',
    iconType: 'check'
  },
  {
    id: 2,
    title: 'Photography',
    subtitle: 'Master Lighting',
    rating: '4.7',
    bgColor: '#FCE4EC',
    accentColor: '#C2185B',
    iconType: 'star'
  },
  {
    id: 3,
    title: 'Finance',
    subtitle: 'Crypto Trading',
    rating: '4.5',
    bgColor: '#E8F5E9',
    accentColor: '#2E7D32',
    iconType: 'star'
  }
];

const categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

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
      .backgroundColor('#F5F5F7')

      BottomNavigationBar()
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
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
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Text('🔔')
          .fontSize(24)
          .fontColor('#1C1B1F')

        Stack() {
          Circle()
            .fill('#4E31AA33')
            .width(48)
            .height(48)
          Text('😊')
            .fontSize(24)
            .fontColor('#4E31AA')
        }
        .width(48)
        .height(48)
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
      Text('🔍')
        .fontSize(18)
        .fontColor('#888888')

      Blank().width(16)

      Text('Search for course...')
        .fontSize(16)
        .fontColor('#BBBBBB')
        .layoutWeight(1)

      Text('⚙')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .padding({ left: 16, right: 16 })
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
        .fontColor('#1C1B1F')
        .width('100%')

      Stack() {
        Column() {}
        .width('100%')
        .height(140)
        .backgroundColor('#4E31AA')
        .borderRadius(24)

        Row() {
          Column({ space: 0 }) {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#FFFFFFB3')

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

              Stack({ alignContent: Alignment.Start }) {
                Row() {}
                .width('100%')
                .height(6)
                .backgroundColor('#FFFFFF33')
                .borderRadius(4)

                Row() {}
                .width('75%')
                .height(6)
                .backgroundColor('#FFA726')
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
              .fill('#FFFFFF')
              .width(60)
              .height(60)
            Text('▶')
              .fontSize(24)
              .fontColor('#4E31AA')
              .margin({ left: 4 })
          }
          .width(60)
          .height(60)
        }
        .width('100%')
        .padding(20)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .height(140)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
  }
}

@Component
struct CategoriesSection {
  build() {
    Scroll() {
      Row({ space: 12 }) {
        Blank().width(12)
        ForEach(categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? '#FFFFFF' : '#888888')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? '#FF7043' : '#FFFFFF')
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
  build() {
    Column({ space: 16 }) {
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
      .justifyContent(FlexAlign.SpaceBetween)

      ForEach(courses, (course: CourseItem) => {
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
  course: CourseItem = courses[0];

  build() {
    Row() {
      Stack() {
        Column() {}
        .width(100)
        .height(100)
        .backgroundColor(this.course.bgColor)

        if (this.course.iconType === 'check') {
          Stack() {
            Circle()
              .fill(this.course.accentColor)
              .width(44)
              .height(44)
            Text('✓')
              .fontSize(22)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
        } else {
          Text('★')
            .fontSize(36)
            .fontColor(this.course.accentColor)
        }
      }
      .width(100)
      .height(100)
      .clip(true)
      .borderRadius({ topLeft: 20, bottomLeft: 20, topRight: 0, bottomRight: 0 })

      Column({ space: 4 }) {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')

        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')

        Row({ space: 4 }) {
          Text('★')
            .fontSize(12)
            .fontColor('#FFB300')
          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#888888')
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      Text('♡')
        .fontSize(20)
        .fontColor('#DDDDDD')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .clip(true)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()
      Text('⌂')
        .fontSize(22)
        .fontColor('#FFFFFF')
      Blank()
      Text('🔍')
        .fontSize(20)
        .fontColor('#888888')
      Blank()
      Text('♡')
        .fontSize(22)
        .fontColor('#888888')
      Blank()
      Text('👤')
        .fontSize(20)
        .fontColor('#888888')
      Blank()
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: '#33000000',
      offsetX: 0,
      offsetY: 4
    })
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}