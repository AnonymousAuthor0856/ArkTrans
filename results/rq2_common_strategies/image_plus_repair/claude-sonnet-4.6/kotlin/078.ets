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
          Blank().height(80)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      BottomNavigationBar()
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
      Column() {
        Text('Hello, Sophie')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('🔔')
            .fontSize(20)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Blank().width(8)

        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#334E31AA')
          Text('😊')
            .fontSize(24)
        }
        .width(48)
        .height(48)
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
        .fontColor('#888888')
      Blank().width(16)
      Text('Search for course...')
        .fontColor('#CCCCCC')
        .fontSize(16)
        .layoutWeight(1)
      Text('⚙️')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .alignSelf(ItemAlign.Start)

      Blank().height(16)

      Row() {
        Column() {
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
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .color('#FFA726')
              .backgroundColor('rgba(255,255,255,0.2)')
              .style({ strokeWidth: 6 })
              .layoutWeight(1)
              .borderRadius(4)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Blank().width(16)

        Stack() {
          Circle()
            .width(60)
            .height(60)
            .fill(Color.White)
          Text('▶')
            .fontSize(28)
            .fontColor('#4E31AA')
        }
        .width(60)
        .height(60)
      }
      .width('100%')
      .height(140)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : '#888888')
            .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
            .borderRadius(12)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

interface CourseItem {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
}

@Component
struct CourseCard {
  course: CourseItem = { title: '', subtitle: '', rating: '', bgColor: '', accentColor: '' }

  build() {
    Row() {
      Stack() {
        Rect()
          .width(100)
          .height(100)
          .fill(this.course.bgColor)
        Text(this.course.title.includes('Mobile') ? '✅' : '⭐')
          .fontSize(32)
      }
      .width(100)
      .height(100)
      .clip(true)

      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank().height(4)
        Row() {
          Text('⭐')
            .fontSize(14)
            .fontColor('#FFB300')
          Blank().width(4)
          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#888888')
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Text('♡')
        .fontSize(20)
        .fontColor('#EEEEEE')
        .padding(12)
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .clip(true)
  }
}

@Component
struct RecommendedSection {
  private courses: CourseItem[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32' }
  ]

  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('See all')
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      ForEach(this.courses, (course: CourseItem) => {
        CourseCard({ course: course })
        Blank().height(16)
      })
    }
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Text('🏠')
        .fontSize(22)
        .fontColor(Color.White)
      Text('🔍')
        .fontSize(22)
        .fontColor('#888888')
      Text('♡')
        .fontSize(22)
        .fontColor('#888888')
      Text('😊')
        .fontSize(22)
        .fontColor('#888888')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 16, bottom: 16, left: 24, right: 24 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .margin({ left: 24, right: 24, bottom: 24 })
    .shadow({ radius: 16, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 4 })
  }
}