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
      .backgroundColor('#F5F5F7')

      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
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
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
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
        .alignContent(Alignment.Center)
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
        .fontSize(18)
        .fontColor(Color.Gray)
      Blank().width(16)
      Text('Search for course...')
        .fontColor('#FFCCCCCC')
        .layoutWeight(1)
      Text('⚙️')
        .fontSize(18)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .borderRadius(16)
    .backgroundColor(Color.White)
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
      Blank().height(16)
      Column() {
        Row() {
          Column() {
            Text('3D Modeling')
              .fontColor('#B3FFFFFF')
              .fontSize(14)
            Blank().height(8)
            Text('Blender Basic')
              .fontColor(Color.White)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
            Blank().height(16)
            Row() {
              Text('75%')
                .fontColor(Color.White)
                .fontSize(12)
              Blank().width(8)
              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .layoutWeight(1)
                .height(6)
                .color('#FFA726')
                .backgroundColor('#33FFFFFF')
                .borderRadius(4)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Blank().width(16)

          Stack() {
            Text('▶')
              .fontSize(28)
              .fontColor('#4E31AA')
          }
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(Color.White)
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(20)
      }
      .width('100%')
      .height(140)
      .borderRadius(24)
      .backgroundColor('#4E31AA')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
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
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(12)
            .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
            .fontColor(category === 'Design' ? Color.White : Color.Gray)
            .fontWeight(FontWeight.Medium)
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecommendedSection {
  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('See all')
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CourseCard({
        title: 'Mobile Dev',
        subtitle: 'Android Compose',
        rating: '4.9',
        bgColor: '#E3F2FD',
        accentColor: '#1565C0',
        isMobile: true
      })
      Blank().height(16)
      CourseCard({
        title: 'Photography',
        subtitle: 'Master Lighting',
        rating: '4.7',
        bgColor: '#FCE4EC',
        accentColor: '#C2185B',
        isMobile: false
      })
      Blank().height(16)
      CourseCard({
        title: 'Finance',
        subtitle: 'Crypto Trading',
        rating: '4.5',
        bgColor: '#E8F5E9',
        accentColor: '#2E7D32',
        isMobile: false
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
  }
}

@Component
struct CourseCard {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop rating: string = ''
  @Prop bgColor: string = '#FFFFFF'
  @Prop accentColor: string = '#000000'
  @Prop isMobile: boolean = false

  build() {
    Row() {
      Stack() {
        Text(this.isMobile ? '✓' : '★')
          .fontSize(28)
          .fontColor(this.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(this.bgColor)
      .alignContent(Alignment.Center)

      Column() {
        Text(this.subtitle)
          .fontColor('#4E31AA')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(14)
            .fontColor('#FFB300')
          Blank().width(4)
          Text(this.rating)
            .fontColor(Color.Gray)
            .fontSize(12)
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
    .borderRadius(20)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .clip(true)
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
        .fontColor(Color.Gray)
      Text('♡')
        .fontSize(22)
        .fontColor(Color.Gray)
      Text('😊')
        .fontSize(22)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 16, bottom: 16, left: 24, right: 24 })
    .margin({ left: 24, right: 24, bottom: 24 })
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
  }
}