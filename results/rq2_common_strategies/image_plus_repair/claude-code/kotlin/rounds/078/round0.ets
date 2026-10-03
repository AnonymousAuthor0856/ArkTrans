@Entry
@Component
struct CourseDashboardScreen {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private selectedCategory: number = 1
  private courses: CourseInfo[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0', hasCheck: true },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B', hasCheck: false },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32', hasCheck: false }
  ]

  build() {
    Stack() {
      Column() {
        this.HeaderSection()
        this.SearchBarSection()
        this.OngoingCourseSection()
        this.CategoriesSection()
        this.RecommendedSection()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

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
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text('Let\'s start learning!')
          .fontSize(28)
          .fontColor('#888888')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Image($r('app.media.ic_notifications'))
          .width(28)
          .height(28)
          .fillColor('#1C1B1F')
          .margin({ right: 16 })

        Circle({ width: 64, height: 64 })
          .fill('rgba(78, 49, 170, 0.2)')
          .overlay(
            Image($r('app.media.ic_face'))
              .width(32)
              .height(32)
              .fillColor('#4E31AA')
          )
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  SearchBarSection() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(24)
        .height(24)
        .fillColor('#888888')
        .margin({ right: 16 })

      Text('Search for course...')
        .fontSize(24)
        .fontColor('#CCCCCC')
        .layoutWeight(1)

      Image($r('app.media.ic_settings'))
        .width(28)
        .height(28)
        .fillColor('#4E31AA')
    }
    .width('100%')
    .height(72)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .margin({ bottom: 16 })

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(18)
            .fontColor('rgba(255, 255, 255, 0.7)')
            .margin({ bottom: 8 })

          Text('Blender Basic')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ bottom: 20 })

          Row() {
            Text('75%')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .margin({ right: 12 })

            Stack() {
              Rectangle()
                .width('100%')
                .height(8)
                .fill('rgba(255, 255, 255, 0.2)')
                .borderRadius(4)

              Rectangle()
                .width('75%')
                .height(8)
                .fill('#FFA726')
                .borderRadius(4)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        Circle({ width: 80, height: 80 })
          .fill('#FFFFFF')
          .margin({ left: 16 })
          .overlay(
            Image($r('app.media.ic_play_arrow'))
              .width(40)
              .height(40)
              .fillColor('#4E31AA')
          )
      }
      .width('100%')
      .height(180)
      .padding(20)
      .backgroundColor('#4E31AA')
      .borderRadius(32)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string, index: number) => {
          Text(category)
            .fontSize(22)
            .fontColor(index === this.selectedCategory ? '#FFFFFF' : '#888888')
            .fontWeight(FontWeight.Medium)
            .padding({ left: 24, right: 24, top: 14, bottom: 14 })
            .backgroundColor(index === this.selectedCategory ? '#FF7043' : '#FFFFFF')
            .borderRadius(16)
            .margin({ right: index < this.categories.length - 1 ? 12 : 0 })
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ bottom: 24 })
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .layoutWeight(1)

        Text('See all')
          .fontSize(20)
          .fontColor('#888888')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      ForEach(this.courses, (course: CourseInfo, index: number) => {
        this.CourseCard(course)
        if (index < this.courses.length - 1) {
          Blank()
            .height(16)
        }
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, bottom: 120 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CourseCard(course: CourseInfo) {
    Row() {
      Column() {
        Image(course.hasCheck ? $r('app.media.ic_check_circle') : $r('app.media.ic_star'))
          .width(40)
          .height(40)
          .fillColor(course.accentColor)
      }
      .width(120)
      .height('100%')
      .backgroundColor(course.bgColor)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(course.subtitle)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
          .margin({ bottom: 4 })

        Text(course.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ bottom: 6 })

        Row() {
          Image($r('app.media.ic_star'))
            .width(20)
            .height(20)
            .fillColor('#FFB300')
            .margin({ right: 6 })
          Text(course.rating)
            .fontSize(14)
            .fontColor('#888888')
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Image($r('app.media.ic_favorite'))
        .width(28)
        .height(28)
        .fillColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(120)
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Column() {
        Image($r('app.media.ic_home'))
          .width(32)
          .height(32)
          .fillColor('#FFFFFF')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        Image($r('app.media.ic_search'))
          .width(32)
          .height(32)
          .fillColor('#888888')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        Image($r('app.media.ic_favorite'))
          .width(32)
          .height(32)
          .fillColor('#888888')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        Image($r('app.media.ic_face'))
          .width(32)
          .height(32)
          .fillColor('#888888')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('85%')
    .height(72)
    .backgroundColor('#1E1E1E')
    .borderRadius(40)
    .shadow({
      radius: 16,
      color: 'rgba(0, 0, 0, 0.3)',
      offsetX: 0,
      offsetY: 4
    })
    .position({ x: '7.5%', y: '90%' })
    .alignItems(VerticalAlign.Center)
  }
}

interface CourseInfo {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  hasCheck: boolean
}
