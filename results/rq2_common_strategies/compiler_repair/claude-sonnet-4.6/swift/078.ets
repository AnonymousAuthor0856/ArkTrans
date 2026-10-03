// Models
interface Course {
  id: number;
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
  iconName: Resource;
}

const courses: Course[] = [
  {
    id: 1,
    title: "Mobile Dev",
    subtitle: "Android Compose",
    rating: "4.9",
    bgColor: '#E3F2FD',
    accentColor: '#1565C0',
    iconName: $r('sys.symbol.checkmark_circle_fill')
  },
  {
    id: 2,
    title: "Photography",
    subtitle: "Master Lighting",
    rating: "4.7",
    bgColor: '#FCE4EC',
    accentColor: '#C2185B',
    iconName: $r('sys.symbol.star_fill')
  },
  {
    id: 3,
    title: "Finance",
    subtitle: "Crypto Trading",
    rating: "4.5",
    bgColor: '#E8F5E9',
    accentColor: '#2E7D32',
    iconName: $r('sys.symbol.star_fill')
  }
];

const categories: string[] = ["Coding", "Design", "Business", "Photo", "Music"];

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
          Column().height(100)
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
        Text("Hello, Sophie")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row({ space: 8 }) {
        Button({ type: ButtonType.Normal }) {
          SymbolGlyph($r('sys.symbol.bell_fill'))
            .fontSize(24)
            .fontColor(['#1C1B1F'])
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)

        Stack() {
          Circle()
            .fill('#334E31AA')
            .width(48)
            .height(48)
          SymbolGlyph($r('sys.symbol.face_smiling_fill'))
            .fontSize(24)
            .fontColor(['#4E31AA'])
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
      SymbolGlyph($r('sys.symbol.magnifyingglass'))
        .fontSize(20)
        .fontColor(['#888888'])

      Column().width(16)

      Text("Search for course...")
        .fontColor('#BBBBBB')
        .fontSize(15)
        .layoutWeight(1)

      SymbolGlyph($r('sys.symbol.list_bullet'))
        .fontSize(20)
        .fontColor(['#4E31AA'])
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column({ space: 16 }) {
      Text("Ongoing Course")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .width('100%')

      Stack() {
        Column()
          .width('100%')
          .height(140)
          .borderRadius(24)
          .backgroundColor('#4E31AA')

        Row({ space: 16 }) {
          Column() {
            Text("3D Modeling")
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.7)')

            Column().height(8)

            Text("Blender Basic")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)

            Column().height(16)

            Row({ space: 8 }) {
              Text("75%")
                .fontSize(12)
                .fontColor(Color.White)

              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .color('#FFA726')
                .backgroundColor('rgba(255,255,255,0.2)')
                .style({ strokeWidth: 6 })
                .layoutWeight(1)
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
            SymbolGlyph($r('sys.symbol.play_fill'))
              .fontSize(28)
              .fontColor(['#4E31AA'])
              .margin({ left: 4 })
          }
          .width(60)
          .height(60)
        }
        .width('100%')
        .padding(20)
        .alignItems(VerticalAlign.Center)
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
        Column().width(12)
        ForEach(categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === "Design" ? Color.White : '#888888')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === "Design" ? '#FF7043' : Color.White)
            .borderRadius(12)
        })
        Column().width(12)
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
        Text("Recommended")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .layoutWeight(1)
        Text("See all")
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      ForEach(courses, (course: Course) => {
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
  course: Course = courses[0];

  build() {
    Row() {
      Stack() {
        Rect()
          .width(100)
          .height(100)
          .fill(this.course.bgColor)
          .radius([{ topLeft: 20 }, { topRight: 0 }, { bottomRight: 0 }, { bottomLeft: 20 }])
        SymbolGlyph(this.course.iconName)
          .fontSize(32)
          .fontColor([this.course.accentColor])
      }
      .width(100)
      .height(100)
      .clip(true)

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
          SymbolGlyph($r('sys.symbol.star_fill'))
            .fontSize(12)
            .fontColor(['#FFB300'])
          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#888888')
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      Button({ type: ButtonType.Normal }) {
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(20)
          .fontColor(['#DDDDDD'])
      }
      .backgroundColor(Color.Transparent)
      .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .clip(true)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Stack() {
        SymbolGlyph($r('sys.symbol.house_fill'))
          .fontSize(24)
          .fontColor([Color.White])
      }
      .layoutWeight(1)
      .alignContent(Alignment.Center)

      Stack() {
        SymbolGlyph($r('sys.symbol.magnifyingglass'))
          .fontSize(24)
          .fontColor(['#888888'])
      }
      .layoutWeight(1)
      .alignContent(Alignment.Center)

      Stack() {
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(24)
          .fontColor(['#888888'])
      }
      .layoutWeight(1)
      .alignContent(Alignment.Center)

      Stack() {
        SymbolGlyph($r('sys.symbol.person_fill'))
          .fontSize(24)
          .fontColor(['#888888'])
      }
      .layoutWeight(1)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ color: 'rgba(0,0,0,0.2)', radius: 8, offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}