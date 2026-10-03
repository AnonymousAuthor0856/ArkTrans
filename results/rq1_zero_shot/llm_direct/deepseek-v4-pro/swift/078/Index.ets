@Entry
@Component
struct CourseDashboardScreen {
  @State selectedCategory: string = 'Design'
  @State favoriteStates: boolean[] = [false, false, false]

  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1466C3', '✓'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', '★'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', '★')
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      // Main content
      Column() {
        Scroll() {
          Column() {
            this.HeaderSection()
            this.SearchBarSection()
            this.OngoingCourseSection()
            this.CategoriesSection()
            this.RecommendedSection()
            Blank()
              .height(100)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom navigation
      Column() {
        Blank()
        this.BottomNavigationBar()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 8 }) {
        Button() {
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .borderRadius(24)

        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#4E31AA')
            .opacity(0.2)

          Text('🔔')
            .fontSize(24)
        }
        .width(48)
        .height(48)

        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#4E31AA')
            .opacity(0.2)

          Text('😊')
            .fontSize(24)
        }
        .width(48)
        .height(48)
      }
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('🔍')
        .fontSize(20)
        .fontColor('#9E9E9E')

      Blank()
        .width(16)

      Text('Search for course...')
        .fontSize(16)
        .fontColor('#BDBDBD')

      Blank()

      Text('⚙️')
        .fontSize(20)
        .fontColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')

      Stack() {
        Row()
          .width('100%')
          .height(140)
          .backgroundColor('#4E31AA')
          .borderRadius(24)

        Row({ space: 16 }) {
          Column() {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .opacity(0.7)

            Blank()
              .height(8)

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')

            Blank()
              .height(16)

            Row() {
              Text('75%')
                .fontSize(12)
                .fontColor('#FFFFFF')

              Blank()
                .width(8)

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(6)
                  .backgroundColor('#FFFFFF')
                  .opacity(0.2)
                  .borderRadius(4)

                Row()
                  .width('75%')
                  .height(6)
                  .backgroundColor('#FFA726')
                  .borderRadius(4)
              }
              .width(120)
              .height(6)
            }
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Stack() {
            Circle()
              .width(60)
              .height(60)
              .fill(Color.White)

            Text('▶')
              .fontSize(28)
              .fontColor('#4E31AA')
              .margin({ left: 4 })
          }
          .width(60)
          .height(60)
        }
        .width('100%')
        .padding(20)
      }
      .width('100%')
      .height(140)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row({ space: 12 }) {
        Blank()
          .width(12)

        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#9E9E9E')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === this.selectedCategory ? '#FF7043' : '#FFFFFF')
            .borderRadius(12)
            .onClick(() => {
              this.selectedCategory = category
            })
        })

        Blank()
          .width(12)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  RecommendedSection() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank()
        Text('See all')
          .fontSize(14)
          .fontColor('#9E9E9E')
      }
      .width('100%')

      ForEach(this.courses, (course: Course, index: number) => {
        this.CourseCard(course, index)
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }

  @Builder
  CourseCard(course: Course, index: number) {
    Row() {
      // Left icon box
      Stack() {
        Text(course.iconName)
          .fontSize(32)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(course.bgColor)
      .borderRadius({ topLeft: 20, bottomLeft: 20, topRight: 0, bottomRight: 0 })

      // Content
      Column({ space: 4 }) {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')

        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')

        Row({ space: 4 }) {
          Text('★')
            .fontSize(12)
            .fontColor('#FFB300')

          Text(course.rating)
            .fontSize(12)
            .fontColor('#9E9E9E')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .layoutWeight(1)

      // Favorite icon
      Button() {
        this.favoriteStates[index] = !this.favoriteStates[index]
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
      .margin({ right: 16 })

      Text(this.favoriteStates[index] ? '❤️' : '🤍')
        .fontSize(20)
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Blank()
      Text('🏠')
        .fontSize(24)
        .fontColor('#FFFFFF')
      Blank()
      Text('🔍')
        .fontSize(24)
        .fontColor('#9E9E9E')
      Blank()
      Text('❤️')
        .fontSize(24)
        .fontColor('#9E9E9E')
      Blank()
      Text('👤')
        .fontSize(24)
        .fontColor('#9E9E9E')
      Blank()
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24 })
  }
}

class Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, iconName: string) {
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
    this.iconName = iconName
  }
}