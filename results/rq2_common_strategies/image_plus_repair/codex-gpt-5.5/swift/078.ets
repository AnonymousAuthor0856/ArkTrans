interface CourseItem {
  title: string
  subtitle: string
  rating: string
  background: string
  accent: string
  icon: string
}

const PRIMARY: string = '#5134B3'
const BACKGROUND: string = '#F7F7F9'
const TEXT: string = '#1C1B1F'
const MUTED: string = '#929297'
const WHITE: string = '#FFFFFF'
const ORANGE: string = '#FFA726'

@Entry
@Component
struct CourseDashboard {
  @State private selectedCategory: string = 'Design'
  @State private favoriteCourses: boolean[] = [false, false, false]

  private readonly categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  private readonly courses: CourseItem[] = [
    {
      title: 'Mobile Dev',
      subtitle: 'Android Compose',
      rating: '4.9',
      background: '#E4F3FF',
      accent: '#1768C5',
      icon: '✓'
    },
    {
      title: 'Photography',
      subtitle: 'Master Lighting',
      rating: '4.7',
      background: '#FDE8F0',
      accent: '#C31F5B',
      icon: '★'
    },
    {
      title: 'Finance',
      subtitle: 'Crypto Trading',
      rating: '4.5',
      background: '#E8F5E9',
      accent: '#347A39',
      icon: '$'
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          this.header()
          this.searchBar()
          this.ongoingCourse()
          this.categoryStrip()
          this.recommended()
          Blank().height(108)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(BACKGROUND)

      this.bottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }

  @Builder
  private header() {
    Row() {
      Column({ space: 4 }) {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)

        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(MUTED)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Text('♟')
        .fontSize(28)
        .fontColor(TEXT)
        .margin({ right: 18 })

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill('#DED8F2')

        Text('●')
          .fontSize(31)
          .fontColor(PRIMARY)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 26, bottom: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private searchBar() {
    Row() {
      Text('⌕')
        .fontSize(38)
        .fontColor(MUTED)
        .margin({ left: 2, right: 14 })

      Text('Search for course...')
        .fontSize(20)
        .fontColor('#B0B0B3')
        .layoutWeight(1)

      Text('☷')
        .fontSize(31)
        .fontColor(PRIMARY)
        .rotate({ angle: 90 })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(WHITE)
    .borderRadius(18)
    .margin({ left: 24, right: 24, bottom: 50 })
  }

  @Builder
  private ongoingCourse() {
    Column({ space: 16 }) {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT)
        .width('100%')

      Stack({ alignContent: Alignment.Center }) {
        Row() {
          Column({ space: 0 }) {
            Text('3D Modeling')
              .fontSize(14)
              .fontColor('#CEC5F3')

            Blank().height(8)

            Text('Blender Basic')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(WHITE)

            Blank().height(17)

            Row({ space: 8 }) {
              Text('75%')
                .fontSize(12)
                .fontColor(WHITE)

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width(148)
                  .height(6)
                  .backgroundColor('#806BC8')
                  .borderRadius(4)

                Row()
                  .width(111)
                  .height(6)
                  .backgroundColor(ORANGE)
                  .borderRadius(4)
              }
              .width(148)
              .height(6)
            }
          }
          .alignItems(HorizontalAlign.Start)

          Blank().layoutWeight(1)

          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(60)
              .height(60)
              .fill(WHITE)

            Text('▶')
              .fontSize(29)
              .fontColor(PRIMARY)
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
      .backgroundColor(PRIMARY)
      .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  private categoryStrip() {
    Scroll() {
      Row({ space: 12 }) {
        Blank().width(12)
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedCategory === category ? WHITE : MUTED)
            .textAlign(TextAlign.Center)
            .width(category === 'Business' ? 146 : 128)
            .height(56)
            .backgroundColor(this.selectedCategory === category ? '#FF7043' : WHITE)
            .borderRadius(18)
            .onClick(() => {
              this.selectedCategory = category
            })
        }, (category: string) => category)
        Blank().width(12)
      }
      .height(56)
    }
    .width('100%')
    .height(56)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ top: 48, bottom: 50 })
  }

  @Builder
  private recommended() {
    Column({ space: 16 }) {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)

        Blank().layoutWeight(1)

        Text('See all')
          .fontSize(16)
          .fontColor(MUTED)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: CourseItem, index: number) => {
        this.courseCard(course, index)
      }, (course: CourseItem) => course.title)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  private courseCard(course: CourseItem, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(course.background)

        Text(course.icon)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(WHITE)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor(course.accent)
          .borderRadius(28)
      }
      .width(100)
      .height(100)

      Column({ space: 4 }) {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)

        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)

        Row({ space: 5 }) {
          Text('★')
            .fontSize(17)
            .fontColor('#FFAE00')

          Text(course.rating)
            .fontSize(12)
            .fontColor(MUTED)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16 })
      .layoutWeight(1)

      Text(this.favoriteCourses[index] ? '♥' : '♡')
        .fontSize(27)
        .fontColor(this.favoriteCourses[index] ? '#C31F5B' : '#E2E2E8')
        .width(36)
        .height(42)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })
        .onClick(() => {
          const nextFavorites: boolean[] = this.favoriteCourses.slice()
          nextFavorites[index] = !nextFavorites[index]
          this.favoriteCourses = nextFavorites
        })
    }
    .width('100%')
    .height(100)
    .backgroundColor(WHITE)
    .borderRadius(22)
    .clip(true)
  }

  @Builder
  private bottomNavigation() {
    Row() {
      this.navItem('⌂', true)
      this.navItem('⌕', false)
      this.navItem('♥', false)
      this.navItem('●', false)
    }
    .width('calc(100% - 48vp)')
    .height(64)
    .padding({ left: 22, right: 22 })
    .backgroundColor('#202020')
    .borderRadius(34)
    .shadow({ radius: 14, color: '#33000000', offsetX: 0, offsetY: 6 })
    .margin({ left: 24, right: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceAround)
  }

  @Builder
  private navItem(icon: string, active: boolean) {
    Text(icon)
      .fontSize(active ? 30 : 28)
      .fontColor(active ? WHITE : '#919195')
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
      .margin({ top: 8 })
  }
}
