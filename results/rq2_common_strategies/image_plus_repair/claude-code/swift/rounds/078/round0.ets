@Entry
@Component
struct CourseDashboardScreen {
  @State selectedCategory: string = 'Design'
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private courses: Course[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0', iconName: 'apps' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B', iconName: 'star' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32', iconName: 'star' }
  ]

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
            SearchBarSection()
            OngoingCourseSection()
            CategoriesSection()
            RecommendedSection()
            Blank().height(100)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .backgroundColor('#F5F5F7')

      Column() {
        Blank()
        BottomNavigationBar()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}

interface Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#9E9E9E')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Image($r('app.media.ic_bell'))
          .width(24)
          .height(24)
          .fillColor('#1C1B1F')

        Stack() {
          Circle({ width: 48, height: 48 })
            .fill('#4E31AA')
            .opacity(0.2)
          Image($r('app.media.ic_smile'))
            .width(28)
            .height(28)
            .fillColor('#4E31AA')
        }
        .width(48)
        .height(48)
      }
      .space(8)
    }
    .width('100%')
    .padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(20)
        .height(20)
        .fillColor('#9E9E9E')

      Blank().width(16)

      Text('Search for course...')
        .fontSize(16)
        .fontColor('#BDBDBD')

      Blank()

      Image($r('app.media.ic_filter'))
        .width(24)
        .height(24)
        .fillColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .padding({ left: 24, right: 24 })
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

      Stack() {
        Row() {
          RoundedRect({ width: '100%', height: 140, radius: 24 })
            .fill('#4E31AA')
        }

        Row() {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .opacity(0.7)

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
                Row()
                  .width('100%')
                  .height(6)
                  .backgroundColor('rgba(255, 255, 255, 0.2)')
                  .borderRadius(4)
                Row()
                  .width('75%')
                  .height(6)
                  .backgroundColor('#FFA726')
                  .borderRadius(4)
              }
              .layoutWeight(1)
              .height(6)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            Circle({ width: 60, height: 60 })
              .fill('#FFFFFF')
            Image($r('app.media.ic_play'))
              .width(28)
              .height(28)
              .fillColor('#4E31AA')
              .margin({ left: 4 })
          }
          .width(60)
          .height(60)
        }
        .padding(20)
        .width('100%')
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

@Component
struct CategoriesSection {
  @State selectedCategory: string = 'Design'
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Scroll() {
      Row() {
        Blank().width(12)

        ForEach(this.categories, (item: string) => {
          Text(item)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item === this.selectedCategory ? '#FFFFFF' : '#9E9E9E')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(item === this.selectedCategory ? '#FF7043' : '#FFFFFF')
            .borderRadius(12)
        }, (item: string) => item)

        Blank().width(12)
      }
      .space(12)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0', iconName: 'check' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B', iconName: 'star' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32', iconName: 'star' }
  ]

  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank()
        Text('See all')
          .fontColor('#9E9E9E')
      }
      .width('100%')

      Column() {
        ForEach(this.courses, (course: Course, index: number) => {
          CourseCard({ course: course })
            .margin({ top: index === 0 ? 0 : 12 })
        }, (course: Course, index: number) => index.toString())
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }
}

@Component
struct CourseCard {
  course: Course

  build() {
    Row() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.course.bgColor)

        if (this.course.iconName === 'check') {
          Stack() {
            Circle({ width: 44, height: 44 })
              .fill(this.course.accentColor)
            Image($r('app.media.ic_check'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
          }
        } else {
          Image($r('app.media.ic_star'))
            .width(40)
            .height(40)
            .fillColor(this.course.accentColor)
        }
      }
      .width(100)
      .height(100)
      .borderRadius({ topLeft: 20, bottomLeft: 20 })

      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')

        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 4 })

        Row() {
          Image($r('app.media.ic_star'))
            .width(12)
            .height(12)
            .fillColor('#FFB300')

          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#9E9E9E')
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      Image($r('app.media.ic_heart'))
        .width(22)
        .height(22)
        .fillColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Blank()
      Image($r('app.media.ic_home'))
        .width(24)
        .height(24)
        .fillColor('#FFFFFF')
      Blank()
      Image($r('app.media.ic_search_nav'))
        .width(22)
        .height(22)
        .fillColor('#9E9E9E')
      Blank()
      Image($r('app.media.ic_heart_nav'))
        .width(22)
        .height(22)
        .fillColor('#9E9E9E')
      Blank()
      Image($r('app.media.ic_person'))
        .width(22)
        .height(22)
        .fillColor('#9E9E9E')
      Blank()
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.2)', offsetY: 4 })
    .padding({ left: 24, right: 24 })
  }
}
