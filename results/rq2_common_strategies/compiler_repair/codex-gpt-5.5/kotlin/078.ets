class CategoryItem {
  name: string

  constructor(name: string) {
    this.name = name
  }
}

class Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string) {
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
  }
}

@Entry
@Component
struct Index {
  private categories: CategoryItem[] = [
    new CategoryItem('Coding'),
    new CategoryItem('Design'),
    new CategoryItem('Business'),
    new CategoryItem('Photo'),
    new CategoryItem('Music')
  ]

  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 96 })
      }
      .width('100%')
      .height('100%')

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
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('Let\'s start learning!')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button('!')
          .fontSize(22)
          .fontColor('#1C1B1F')
          .backgroundColor(Color.Transparent)
          .width(40)
          .height(40)
          .padding(0)
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('rgba(78,49,170,0.2)')
          Text('☺')
            .fontSize(24)
            .fontColor('#4E31AA')
        }
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
      Text('⌕')
        .fontSize(22)
        .fontColor(Color.Gray)
      Text('Search for course...')
        .fontSize(15)
        .fontColor('#C7C7CC')
        .margin({ left: 16 })
      Blank()
      Text('⚙')
        .fontSize(22)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .borderRadius(16)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .width('100%')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
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
              .height(6)
              .layoutWeight(1)
              .margin({ left: 8 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Circle()
            .width(60)
            .height(60)
            .fill(Color.White)
          Text('▶')
            .fontSize(30)
            .fontColor('#4E31AA')
        }
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .padding(20)
      .borderRadius(24)
      .backgroundColor('#4E31AA')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row() {
        ForEach(this.categories, (item: CategoryItem) => {
          Text(item.name)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.name === 'Design' ? Color.White : Color.Gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(12)
            .backgroundColor(item.name === 'Design' ? '#FF7043' : Color.White)
            .margin({ right: 12 })
        })
      }
      .padding({ left: 24, right: 12 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('See all')
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      })
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack() {
        Rect()
          .width(100)
          .height('100%')
          .fill(course.bgColor)
        Text(course.title.indexOf('Mobile') >= 0 ? '✓' : '★')
          .fontSize(32)
          .fontColor(course.accentColor)
          .fontWeight(FontWeight.Bold)
      }
      .width(100)
      .height('100%')

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontColor('#4E31AA')
          .fontWeight(FontWeight.Bold)
        Text(course.title)
          .fontSize(18)
          .fontColor('#1C1B1F')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
        Row() {
          Text('★')
            .fontSize(16)
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

      Button('♥')
        .fontSize(22)
        .fontColor('#EEEEEE')
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor(Color.White)
    .clip(true)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text('⌂')
        .fontSize(24)
        .fontColor(Color.White)
      Text('⌕')
        .fontSize(24)
        .fontColor(Color.Gray)
      Text('♥')
        .fontSize(24)
        .fontColor(Color.Gray)
      Text('☺')
        .fontSize(24)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.18)', offsetY: 6 })
    .margin({ left: 24, right: 24, bottom: 24 })
  }
}
