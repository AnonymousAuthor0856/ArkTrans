@Entry
@Component
struct TaskDashboardPage {
  @State selectedCategory: string = 'All'
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']
  private tasks: TaskItemData[] = [
    { title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagBgColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true },
    { title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagBgColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false },
    { title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagBgColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false },
    { title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagBgColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false }
  ]

  build() {
    Stack() {
      Column() {
        this.TopHeader()
        Scroll() {
          Column() {
            this.WelcomeSection()
            this.CategorySelector()
            this.RecentTasksSection()
          }
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .padding({ left: 24, right: 24, top: 48 })

      // Floating Action Button
      Stack() {
        Text('+')
          .fontSize(32)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .backgroundColor('#212121')
      .shadow({ radius: 8, color: '#40000000', offsetX: 0, offsetY: 4 })
      .position({ x: '80%', y: '85%' })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TopHeader() {
    Row() {
      // Menu button
      Stack() {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')

      Blank()

      // Search button
      Stack() {
        Text('⌕')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .padding({ bottom: 16 })
  }

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 16 })
  }

  @Builder
  CategorySelector() {
    Row() {
      List({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          ListItem() {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedCategory === category ? Color.White : Color.Black)
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .borderRadius(50)
          .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
          .onClick(() => {
            this.selectedCategory = category
          })
        }, (category: string) => category)
      }
      .listDirection(Axis.Horizontal)
      .height(48)
      .width('100%')
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  RecentTasksSection() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      List({ space: 16 }) {
        ForEach(this.tasks, (task: TaskItemData, index: number) => {
          ListItem() {
            this.TaskItemCard(task)
          }
        }, (task: TaskItemData, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ top: 24 })
  }

  @Builder
  TaskItemCard(task: TaskItemData) {
    Row() {
      // Icon box
      Stack() {
        if (task.tag === 'Personal') {
          Text('👤')
            .fontSize(24)
        } else {
          Text('📅')
            .fontSize(24)
        }
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.isChecked ? Color.Gray : Color.Black)

        Row() {
          Text(task.time)
            .fontSize(12)
            .fontColor(Color.Gray)

          Text(task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
            .backgroundColor(task.tagBgColor)
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      // Checkbox
      Stack() {
        if (task.isChecked) {
          Stack() {
            Text('✓')
              .fontSize(16)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width(24)
          .height(24)
          .backgroundColor(Color.Black)
          .borderRadius(4)
        } else {
          Stack() {
          }
          .width(24)
          .height(24)
          .border({ width: 2, color: Color.Gray })
          .borderRadius(4)
        }
      }
      .width(48)
      .height(48)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .backgroundColor('#FAFAFA')
  }
}

interface TaskItemData {
  title: string
  time: string
  tag: string
  tagBgColor: string
  tagTextColor: string
  isChecked: boolean
}
