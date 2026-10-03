class Course {
  title: string = ''
  subtitle: string = ''
  rating: string = ''
  bgColor: string = ''
  accentColor: string = ''
  icon: string = ''
  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string, icon: string) {
    this.title = title
    this.subtitle = subtitle
    this.rating = rating
    this.bgColor = bgColor
    this.accentColor = accentColor
    this.icon = icon
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0', '✓'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', '★'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', '★'),
  ]

  @Builder
  CategoryChipBuilder(category: string) {
    Text(category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(category === 'Design' ? '#FFFFFF' : '#888888')
      .backgroundColor(category === 'Design' ? '#FF7043' : '#FFFFFF')
      .borderRadius(12)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  CourseCardBuilder(course: Course) {
    Row() {
      Column() {
        Text(course.icon)
          .fontSize(28)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 2 })
        Row() {
          Text('★')
            .fontSize(14)
            .fontColor('#FFB300')
          Text(course.rating)
            .fontSize(12)
            .fontColor('#888888')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text('♥')
          .fontSize(22)
          .fontColor('#EEEEEE')
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(100)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('Hello, Sophie')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
              Text("Let's start learning!")
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Row() {
              Column() {
                Text('🔔')
                  .fontSize(22)
                  .fontColor('#1C1B1F')
              }
              .width(40)
              .height(40)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              Column() {
                Text('😊')
                  .fontSize(22)
                  .fontColor('#4E31AA')
              }
              .width(48)
              .height(48)
              .backgroundColor('#334E31AA')
              .borderRadius(24)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .margin({ left: 8 })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(24)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Row() {
            Text('🔍')
              .fontSize(20)
              .fontColor('#888888')
            Text('Search for course...')
              .fontSize(14)
              .fontColor('#AAAAAA')
              .layoutWeight(1)
              .margin({ left: 16 })
            Text('⚙')
              .fontSize(20)
              .fontColor('#4E31AA')
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          Column() {
            Text('Ongoing Course')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1C1B1F')

            Row() {
              Column() {
                Text('3D Modeling')
                  .fontSize(14)
                  .fontColor('#B3FFFFFF')
                Text('Blender Basic')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .margin({ top: 8 })

                Row() {
                  Text('75%')
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                  Progress({ value: 75, total: 100, type: ProgressType.Linear })
                    .layoutWeight(1)
                    .height(6)
                    .color('#FFA726')
                    .backgroundColor('#33FFFFFF')
                    .margin({ left: 8 })
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)
                .margin({ top: 16 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Column() {
                Text('▶')
                  .fontSize(28)
                  .fontColor('#4E31AA')
              }
              .width(60)
              .height(60)
              .backgroundColor('#FFFFFF')
              .borderRadius(30)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .margin({ left: 16 })
            }
            .width('100%')
            .height(140)
            .padding(20)
            .backgroundColor('#4E31AA')
            .borderRadius(24)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 16 })
          }
          .width('100%')
          .padding(24)

          Scroll() {
            Row() {
              ForEach(this.categories, (category: string) => {
                this.CategoryChipBuilder(category)
              }, (category: string) => category)
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Column() {
            Row() {
              Text('Recommended')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
                .layoutWeight(1)
              Text('See all')
                .fontSize(14)
                .fontColor('#888888')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            ForEach(this.courses, (course: Course) => {
              this.CourseCardBuilder(course)
            }, (course: Course) => course.title)
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      Row() {
        Text('🏠')
          .fontSize(24)
          .fontColor('#FFFFFF')
        Text('🔍')
          .fontSize(24)
          .fontColor('#888888')
        Text('♥')
          .fontSize(24)
          .fontColor('#888888')
        Text('😊')
          .fontSize(24)
          .fontColor('#888888')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .backgroundColor('#1E1E1E')
      .borderRadius(32)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .position({ x: 0, y: '100%' })
      .markAnchor({ x: 0, y: '100%' })
      .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}