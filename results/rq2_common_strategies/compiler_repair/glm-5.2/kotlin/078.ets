// Index.ets
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
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  private courses: Course[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32' }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            this.HeaderSection()
            this.SearchBarSection()
            this.OngoingCourseSection()
            this.CategoriesSection()
            this.RecommendedSection()
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .padding({ bottom: 80 })
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
        Image($r('sys.media.ohos_ic_public_notice'))
          .width(24)
          .height(24)
          .fillColor('#1C1B1F')
          .margin({ right: 8 })

        Stack() {
          Image($r('sys.media.ohos_ic_public_contacts'))
            .width(24)
            .height(24)
            .fillColor('#4E31AA')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#334E31AA')
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Image($r('sys.media.ohos_ic_public_search'))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)

      Text('Search for course...')
        .fontColor('#BDBDBD')
        .margin({ left: 16 })
        .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(20)
        .height(20)
        .fillColor('#4E31AA')
    }
    .width('90%')
    .height(56)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')

      Row() {
        Column() {
          Text('3D Modeling')
            .fontColor('#B3FFFFFF')
            .fontSize(14)
          Text('Blender Basic')
            .fontColor(Color.White)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 8 })

          Row() {
            Text('75%')
              .fontColor(Color.White)
              .fontSize(12)
            Stack() {
              Column()
                .width('100%')
                .height(6)
                .backgroundColor('#33FFFFFF')
                .borderRadius(3)
              Column()
                .width('75%')
                .height(6)
                .backgroundColor('#FFA726')
                .borderRadius(3)
            }
            .width('100%')
            .height(6)
            .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 16 })
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(32)
            .height(32)
            .fillColor('#4E31AA')
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(Color.White)
        .alignContent(Alignment.Center)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .borderRadius(24)
      .backgroundColor('#4E31AA')
      .padding(20)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontColor(category === 'Design' ? Color.White : Color.Gray)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
            .borderRadius(12)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .margin({ right: 12 })
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
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
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Stack() {
        Image(course.title.includes('Mobile') ? $r('sys.media.ohos_ic_public_done') : $r('sys.media.ohos_ic_public_star'))
          .width(32)
          .height(32)
          .fillColor(course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(course.bgColor)
      .alignContent(Alignment.Center)

      Column() {
        Text(course.subtitle)
          .fontColor('#4E31AA')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 4 })

        Row() {
          Image($r('sys.media.ohos_ic_public_star'))
            .width(16)
            .height(16)
            .fillColor('#FFB300')
          Text(course.rating)
            .fontColor(Color.Gray)
            .fontSize(12)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Image($r('sys.media.ohos_ic_public_heart'))
        .width(24)
        .height(24)
        .fillColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Image($r('sys.media.ohos_ic_public_home'))
        .width(24)
        .height(24)
        .fillColor(Color.White)
      Image($r('sys.media.ohos_ic_public_search'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Image($r('sys.media.ohos_ic_public_heart'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Image($r('sys.media.ohos_ic_public_contacts'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
    }
    .width('85%')
    .padding({ top: 16, bottom: 16 })
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 24 })
    .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
  }
}