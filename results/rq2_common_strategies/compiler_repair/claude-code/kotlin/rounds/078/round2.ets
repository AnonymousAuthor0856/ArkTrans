@Entry
@Component
struct CourseDashboard {
  @State categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  @State selectedCategory: string = 'Design';
  @State courses: CourseItem[] = [
    { title: 'Android Compose', subtitle: 'Mobile Dev', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0' },
    { title: 'Master Lighting', subtitle: 'Photography', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B' },
    { title: 'Crypto Trading', subtitle: 'Finance', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32' }
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
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
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Text('\u{1F514}')
          .fontSize(24)
          .margin({ right: 12 })

        Stack({ alignContent: Alignment.Center }) {
          Text('\u{1F464}')
            .fontSize(24)
            .fontColor('#4E31AA')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('rgba(78, 49, 170, 0.2)')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(24)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Text('\u{1F50D}')
        .fontSize(20)
        .margin({ right: 16 })

      Text('Search for course...')
        .fontColor('#D3D3D3')
        .fontSize(16)
        .layoutWeight(1)

      Text('\u{2699}\u{FE0F}')
        .fontSize(20)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('rgba(255, 255, 255, 0.7)')

          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 8 })

          Row() {
            Text('75%')
              .fontSize(12)
              .fontColor('#FFFFFF')
              .margin({ right: 8 })

            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .layoutWeight(1)
              .height(6)
              .color('#FFA726')
              .backgroundColor('rgba(255, 255, 255, 0.2)')
              .borderRadius(4)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Text('\u{25B6}\u{FE0F}')
            .fontSize(24)
            .fontColor('#4E31AA')
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
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
    .alignItems(HorizontalAlign.Start)
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    List() {
      ForEach(this.categories, (category: string) => {
        ListItem() {
          Text(category)
            .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#888888')
            .fontWeight(FontWeight.Medium)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === this.selectedCategory ? '#FF7043' : '#FFFFFF')
            .borderRadius(12)
        }
      }, (category: string) => category)
    }
    .width('100%')
    .height(48)
    .listDirection(Axis.Horizontal)
    .padding({ left: 24, right: 24 })
    .divider({ strokeWidth: 12, color: 'transparent' })
  }

  @Builder
  RecommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .layoutWeight(1)

        Text('See all')
          .fontColor('#888888')
          .fontSize(14)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: CourseItem) => {
        this.CourseCard(course)
      }, (course: CourseItem) => course.title)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .margin({ top: 8 })
  }

  @Builder
  CourseCard(course: CourseItem) {
    Row() {
      Column() {
        Text(course.title.includes('Mobile') ? '\u{2714}' : '\u{2B50}')
          .fontSize(28)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(course.subtitle)
          .fontColor('#4E31AA')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)

        Text(course.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 2 })

        Row() {
          Text('\u{2B50}')
            .fontSize(14)
            .fontColor('#FFB300')
            .margin({ right: 4 })

          Text(course.rating)
            .fontColor('#888888')
            .fontSize(12)
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)

      Text('\u{2764}\u{FE0F}')
        .fontSize(22)
        .fontColor('#EEEEEE')
        .margin({ right: 12 })
    }
    .width('100%')
    .height(100)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  BottomNavigationBar() {
    Column() {
      Blank()

      Row() {
        Text('\u{1F3E0}')
          .fontSize(24)
          .fontColor('#FFFFFF')
          .layoutWeight(1)

        Text('\u{1F50D}')
          .fontSize(24)
          .fontColor('#888888')
          .layoutWeight(1)

        Text('\u{2764}\u{FE0F}')
          .fontSize(24)
          .fontColor('#888888')
          .layoutWeight(1)

        Text('\u{1F464}')
          .fontSize(24)
          .fontColor('#888888')
          .layoutWeight(1)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#1E1E1E')
      .borderRadius(32)
      .margin({ left: 24, right: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

interface CourseItem {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
}
