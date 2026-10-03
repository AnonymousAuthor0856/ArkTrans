interface TaskInfo {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean
}

@Entry
@Component
struct TaskDashboardScreen {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  private tasks: TaskInfo[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false
    }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()

        Scroll() {
          Column() {
            Blank()
              .height(16)

            this.WelcomeSection()

            Blank()
              .height(32)

            this.CategorySelector()

            Blank()
              .height(24)

            this.RecentTasksList()
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(32)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Normal)
          .textAlign(TextAlign.Center)
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopHeader() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)

      Button({ type: ButtonType.Circle }) {
        Text('⌕')
          .fontSize(28)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()
        .height(8)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'All' ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
            .borderRadius(50)
        }, (category: string) => category)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      ForEach(this.tasks, (task: TaskInfo) => {
        this.TaskItem(task)
      }, (task: TaskInfo) => task.title)

      Blank()
        .height(80)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TaskItem(task: TaskInfo) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(task.tag === 'Personal' ? '☺' : '▣')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .borderRadius(14)

        Blank()
          .width(16)

        Column() {
          Text(task.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.isChecked ? Color.Gray : Color.Black)

          Blank()
            .height(4)

          Row() {
            Text(task.time)
              .fontSize(12)
              .fontColor(Color.Gray)

            Blank()
              .width(8)

            Text(task.tag)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(task.tagTextColor)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .backgroundColor(task.tagColor)
              .borderRadius(4)
          }
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Checkbox()
          .select(task.isChecked)
          .selectedColor(Color.Black)
          .unselectedColor(Color.Gray)
          .mark({ strokeColor: Color.White })
          .onChange(() => {
          })
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .margin({ bottom: 16 })
  }
}