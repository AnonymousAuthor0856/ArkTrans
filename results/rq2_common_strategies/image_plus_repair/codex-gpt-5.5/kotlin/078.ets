@Entry
@Component
struct CourseDashboard {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.header()
          this.searchBar()
          this.ongoingCourse()
          this.categoryList()
          this.recommendations()
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.bottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }

  @Builder
  private header() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(29)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(17)
          .fontColor('#888888')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('♟')
        .fontSize(25)
        .fontColor('#1C1B1F')
        .width(40)
        .textAlign(TextAlign.Center)
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#DDD7F0')
        Text('●')
          .fontSize(25)
          .fontColor('#4E31AA')
      }
      .width(48)
      .height(48)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 28, bottom: 28 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private searchBar() {
    Row() {
      Text('⌕')
        .fontSize(34)
        .fontColor('#888888')
        .width(28)
      Text('Search for course...')
        .fontSize(17)
        .fontColor('#D0D0D0')
        .margin({ left: 12 })
      Blank()
      Text('⚙')
        .fontSize(25)
        .fontColor('#4E31AA')
    }
    .width('calc(100% - 48vp)')
    .height(56)
    .padding({ left: 18, right: 18 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24 })
  }

  @Builder
  private ongoingCourse() {
    Column() {
      Text('Ongoing Course')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .width('100%')
        .margin({ bottom: 16 })

      Row() {
        Column() {
          Text('3D Modeling')
            .fontSize(14)
            .fontColor('#C6B9E8')
          Text('Blender Basic')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ top: 12 })
          Row() {
            Text('75%')
              .fontSize(13)
              .fontColor(Color.White)
            Stack() {
              Row()
                .width('100%')
                .height(6)
                .backgroundColor('#765EBE')
                .borderRadius(5)
              Row()
                .width('75%')
                .height(6)
                .backgroundColor('#FFA726')
                .borderRadius(5)
            }
            .layoutWeight(1)
            .height(8)
            .margin({ left: 10 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 21 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Circle()
            .width(60)
            .height(60)
            .fill(Color.White)
          Text('▶')
            .fontSize(23)
            .fontColor('#4E31AA')
            .margin({ left: 3 })
        }
        .width(60)
        .height(60)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .padding(20)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private categoryList() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? Color.White : '#888888')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? '#FF7043' : Color.White)
            .borderRadius(12)
        })
      }
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  private recommendations() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Blank()
        Text('See all')
          .fontSize(16)
          .fontColor('#888888')
      }
      .width('100%')
      .margin({ bottom: 16 })

      this.courseCard('Android Compose', 'Mobile Dev', '4.9', '#E3F2FD', '#1565C0', true)
      this.courseCard('Master Lighting', 'Photography', '4.7', '#FCE4EC', '#C2185B', false)
      this.courseCard('Crypto Trading', 'Finance', '4.5', '#E8F5E9', '#2E7D32', false)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 2 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private courseCard(subtitle: string, title: string, rating: string, bg: string, accent: string, checked: boolean) {
    Row() {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill(bg)
        Text(checked ? '✓' : '★')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(accent)
      }
      .width(100)
      .height(100)

      Column() {
        Text(subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 3 })
        Row() {
          Text('★')
            .fontSize(15)
            .fontColor('#FFB300')
          Text(rating)
            .fontSize(12)
            .fontColor('#888888')
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16 })

      Text('♥')
        .fontSize(23)
        .fontColor('#EEEEEE')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .clip(true)
    .margin({ bottom: 16 })
  }

  @Builder
  private bottomNavigation() {
    Row() {
      Text('⌂')
        .fontSize(31)
        .fontColor(Color.White)
      Text('⌕')
        .fontSize(32)
        .fontColor('#888888')
      Text('♥')
        .fontSize(25)
        .fontColor('#888888')
      Text('●')
        .fontSize(25)
        .fontColor('#888888')
    }
    .width('calc(100% - 48vp)')
    .height(56)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .align(Alignment.Bottom)
    .margin({ left: 24, right: 24, bottom: 24 })
  }
}
