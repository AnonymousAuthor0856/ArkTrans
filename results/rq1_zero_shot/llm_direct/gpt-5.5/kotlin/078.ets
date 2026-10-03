interface Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
}

const PRIMARY_COLOR: string = '#4E31AA'
const SECONDARY_COLOR: string = '#3A1C71'
const BACKGROUND_COLOR: string = '#F5F5F7'
const TEXT_COLOR: string = '#1C1B1F'

@Entry
@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      BottomNavigationBar()
        .align(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_COLOR)

        Text('Let\'s start learning!')
          .fontSize(16)
          .fontColor('#808080')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('🔔')
            .fontSize(22)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .fontColor(TEXT_COLOR)

        Blank()
          .width(8)

        Stack({ alignContent: Alignment.Center }) {
          Text('☺')
            .fontSize(26)
            .fontColor(PRIMARY_COLOR)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('rgba(78,49,170,0.2)')
      }
      .alignItems(VerticalAlign.Center)
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
        .fontSize(20)
        .fontColor('#808080')

      Blank()
        .width(16)

      Text('Search for course...')
        .fontSize(16)
        .fontColor('#D3D3D3')

      Blank()
        .layoutWeight(1)

      Text('⚙')
        .fontSize(22)
        .fontColor(PRIMARY_COLOR)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24 })
    .borderRadius(16)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text('Ongoing Course')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_COLOR)
        .width('100%')

      Blank()
        .height(16)

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('rgba(255,255,255,0.7)')

          Blank()
            .height(8)

          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Blank()
            .height(16)

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor(Color.White)

            Blank()
              .width(8)

            Progress({
              value: 75,
              total: 100,
              type: ProgressType.Linear
            })
              .color('#FFA726')
              .backgroundColor('rgba(255,255,255,0.2)')
              .height(6)
              .borderRadius(4)
              .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Blank()
          .width(16)

        Stack({ alignContent: Alignment.Center }) {
          Text('▶')
            .fontSize(32)
            .fontColor(PRIMARY_COLOR)
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(Color.White)
      }
      .width('100%')
      .height(140)
      .padding(20)
      .borderRadius(24)
      .backgroundColor(PRIMARY_COLOR)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Column() {
      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.categories, (category: string) => {
            CategoryChip({ title: category, selected: category === 'Design' })
          }, (category: string) => category)
        }
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
  }
}

@Component
struct CategoryChip {
  title: string = ''
  selected: boolean = false

  build() {
    Text(this.title)
      .fontSize(15)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? Color.White : '#808080')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .borderRadius(12)
      .backgroundColor(this.selected ? '#FF7043' : Color.White)
  }
}

@Component
struct RecommendedSection {
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
  ]

  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_COLOR)

        Text('See all')
          .fontSize(15)
          .fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(16)

      ForEach(this.courses, (course: Course) => {
        CourseCard({ course: course })
        Blank()
          .height(16)
      }, (course: Course) => course.title)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CourseCard {
  course: Course = {
    title: '',
    subtitle: '',
    rating: '',
    bgColor: '#FFFFFF',
    accentColor: '#000000'
  }

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.course.title.indexOf('Mobile') >= 0 ? '✓' : '★')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(this.course.bgColor)

      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_COLOR)

        Text(this.course.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_COLOR)
          .margin({ top: 2 })

        Blank()
          .height(4)

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor('#FFB300')

          Blank()
            .width(4)

          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#808080')
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Text('♥')
          .fontSize(22)
          .fontColor('#EEEEEE')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .margin({ right: 8 })
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .clip(true)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Text('⌂')
        .fontSize(26)
        .fontColor(Color.White)

      Text('🔍')
        .fontSize(22)
        .fontColor('#808080')

      Text('♥')
        .fontSize(24)
        .fontColor('#808080')

      Text('☺')
        .fontSize(24)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.25)',
      offsetX: 0,
      offsetY: 4
    })
    .margin(24)
  }
}