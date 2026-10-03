const Colors = {
  primary: '#4E31AA',
  secondary: '#3A1C71',
  background: '#F5F5F7',
  surface: '#FFFFFF',
  onPrimary: '#FFFFFF',
  onBackground: '#1C1B1F',
  onSurface: '#1C1B1F'
};

interface Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
}

const categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];

const courses: Course[] = [
  { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0' },
  { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B' },
  { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32' }
];

@Entry
@Component
struct Index {
  @Builder
  headerSection() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#808080')
      }
      Row({ space: 8 }) {
        Text('🔔')
          .fontSize(24)
          .fontColor(Colors.onBackground)
          .padding(12)
        Stack() {
          Text('🙂')
            .fontSize(24)
            .fontColor(Colors.primary)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#334E31AA')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  searchBarSection() {
    Row() {
      Text('🔍')
        .fontSize(20)
        .fontColor('#808080')
      Blank().width(16)
      Text('Search for course...')
        .fontColor('#D3D3D3')
      Blank().layoutWeight(1)
      Text('⚙')
        .fontSize(20)
        .fontColor(Colors.primary)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .borderRadius(16)
    .backgroundColor('#FFFFFF')
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  ongoingCourseSection() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)
      Blank().height(16)
      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#B3FFFFFF')
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
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .color('#FFA726')
              .backgroundColor('#33FFFFFF')
              .layoutWeight(1)
              .height(6)
          }
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)

        Blank().width(16)

        Stack() {
          Text('▶')
            .fontSize(32)
            .fontColor(Colors.primary)
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height(140)
      .padding(20)
      .borderRadius(24)
      .backgroundColor(Colors.primary)
      .alignItems(VerticalAlign.Center)
    }
    .padding(24)
  }

  @Builder
  categoriesSection() {
    Column() {
      Scroll() {
        Row({ space: 12 }) {
          ForEach(categories, (category: string) => {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(category === 'Design' ? '#FFFFFF' : '#808080')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .borderRadius(12)
              .backgroundColor(category === 'Design' ? '#FF7043' : '#FFFFFF')
          }, (category: string) => category)
        }
        .padding({ left: 24, right: 24 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
  }

  @Builder
  courseCard(course: Course) {
    Row() {
      Stack() {
        Text(course.title.includes('Mobile') ? '✓' : '★')
          .fontSize(32)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .backgroundColor(course.bgColor)

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor('#FFB300')
          Blank().width(4)
          Text(course.rating)
            .fontSize(12)
            .fontColor('#808080')
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .padding(16)

      Text('♥')
        .fontSize(24)
        .fontColor('#EEEEEE')
        .padding(12)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(100)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  recommendedSection() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
        Text('See all')
          .fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      ForEach(courses, (course: Course) => {
        this.courseCard(course)
        Blank().height(16)
      }, (course: Course) => course.title)
    }
    .padding(24)
  }

  @Builder
  bottomNavigationBar() {
    Row() {
      Text('⌂')
        .fontSize(24)
        .fontColor('#FFFFFF')
      Text('🔍')
        .fontSize(24)
        .fontColor('#808080')
      Text('♥')
        .fontSize(24)
        .fontColor('#808080')
      Text('🙂')
        .fontSize(24)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .borderRadius(32)
    .backgroundColor('#1E1E1E')
    .margin({ left: 24, right: 24, bottom: 24 })
    .shadow({ radius: 8, color: '#22000000', offsetY: 4 })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.headerSection()
          this.searchBarSection()
          this.ongoingCourseSection()
          this.categoriesSection()
          this.recommendedSection()
        }
      }
      .layoutWeight(1)

      this.bottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
