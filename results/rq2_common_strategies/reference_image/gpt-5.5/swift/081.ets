@Entry
@Component
struct TaskDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopHeader()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            Blank()
              .height(16)

            WelcomeSection()

            Blank()
              .height(32)

            CategorySelector()

            Blank()
              .height(24)

            RecentTasksList()

            Blank()
              .height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Stack() {
        Text('+')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .shadow({
        radius: 4,
        color: '#33000000',
        offsetX: 0,
        offsetY: 4
      })
      .margin({ right: 24, bottom: 24 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      CircleIconButton({ icon: '☰', fontSizeValue: 24 })

      Blank()
        .layoutWeight(1)

      CircleIconButton({ icon: '⌕', fontSizeValue: 27 })
    }
    .width('100%')
    .height(48)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CircleIconButton {
  icon: string = ''
  fontSizeValue: number = 24

  build() {
    Stack() {
      Text(this.icon)
        .fontSize(this.fontSizeValue)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Normal)
        .textAlign(TextAlign.Center)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor('#F5F5F5')
    .onClick(() => {
    })
  }
}

@Component
struct WelcomeSection {
  build() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor('#888888')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'All' ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
            .borderRadius(24)
        }, (category: string) => category)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecentTasksList {
  build() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      TaskItem({
        title: 'Team Meeting',
        time: '10:00 AM - 11:30 AM',
        tag: 'Work',
        tagColor: '#E3F2FD',
        tagTextColor: '#1565C0',
        isChecked: true,
        icon: '▣'
      })

      TaskItem({
        title: 'Design Review',
        time: '02:00 PM - 03:00 PM',
        tag: 'Design',
        tagColor: '#F3E5F5',
        tagTextColor: '#7B1FA2',
        isChecked: false,
        icon: '▣'
      })

      TaskItem({
        title: 'Grocery Shopping',
        time: '05:30 PM',
        tag: 'Personal',
        tagColor: '#E8F5E9',
        tagTextColor: '#2E7D32',
        isChecked: false,
        icon: '☺'
      })

      TaskItem({
        title: 'Read Documentation',
        time: '08:00 PM',
        tag: 'Study',
        tagColor: '#FFF3E0',
        tagTextColor: '#EF6C00',
        isChecked: false,
        icon: '▣'
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TaskItem {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagColor: string = '#E3F2FD'
  tagTextColor: string = '#1565C0'
  @State isChecked: boolean = false
  icon: string = '▣'

  build() {
    Row({ space: 16 }) {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Normal)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)

      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#888888' : Color.Black)
          .decoration({
            type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: '#888888'
          })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 8 }) {
          Text(this.time)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor('#888888')

          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tagColor)
            .borderRadius(4)
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(this.isChecked ? '☑' : '☐')
        .fontSize(24)
        .fontColor(this.isChecked ? Color.Black : '#888888')
        .fontWeight(FontWeight.Normal)
        .onClick(() => {
          this.isChecked = !this.isChecked
        })
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}