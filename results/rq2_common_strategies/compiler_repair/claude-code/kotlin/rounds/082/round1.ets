@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: string = 'All'
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']
  private tasks: TaskData[] = [
    { title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true },
    { title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false },
    { title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false },
    { title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false }
  ]

  build() {
    Stack() {
      Column() {
        this.TopHeader()
        Column() {
          this.WelcomeSection()
          this.CategorySelector()
          this.RecentTasksList()
        }
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button() {
        Text('+')
          .fontSize(28)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#FF212121')
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 4 })
      .position({ x: '80%', y: '85%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopHeader() {
    Row() {
      Button() {
        Column() {
          Row().width(18).height(2).backgroundColor(Color.Black).margin({ bottom: 3 })
          Row().width(18).height(2).backgroundColor(Color.Black).margin({ bottom: 3 })
          Row().width(18).height(2).backgroundColor(Color.Black)
        }
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFF5F5F5')
      .type(ButtonType.Normal)
      .onClick(() => {})

      Button() {
        Stack() {
          Circle()
            .width(14)
            .height(14)
            .stroke(Color.Black)
            .strokeWidth(2)
            .fill(Color.Transparent)
          Line()
            .width(8)
            .height(8)
            .backgroundColor(Color.Black)
            .translate({ x: 6, y: 6 })
            .rotate({ angle: 45 })
        }
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFF5F5F5')
      .type(ButtonType.Normal)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
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
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          this.CategoryChip(category, category === this.selectedCategory)
        }, (category: string) => category)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .margin({ top: 32, bottom: 24 })
  }

  @Builder
  CategoryChip(category: string, isSelected: boolean) {
    Text(category)
      .fontSize(14)
      .fontColor(isSelected ? Color.White : Color.Black)
      .fontWeight(FontWeight.Medium)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(isSelected ? '#FF212121' : '#FFF5F5F5')
      .borderRadius(50)
      .margin({ right: 12 })
      .onClick(() => {
        this.selectedCategory = category
      })
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      List() {
        ForEach(this.tasks, (task: TaskData, index: number) => {
          ListItem() {
            this.TaskItem(task)
          }
        }, (task: TaskData, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 0, color: Color.Transparent })
      .padding({ bottom: 80 })
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  TaskItem(task: TaskData) {
    Row() {
      Stack() {
        if (task.tag === 'Personal') {
          Column() {
            Circle()
              .width(12)
              .height(12)
              .fill(Color.Black)
            Ellipse()
              .width(20)
              .height(12)
              .fill(Color.Black)
              .margin({ top: 2 })
          }
        } else {
          Column() {
            Row()
              .width(20)
              .height(1)
              .backgroundColor(Color.Black)
              .margin({ bottom: 2 })
            Row() {
              Circle()
                .width(3)
                .height(3)
                .fill(Color.Black)
              Blank()
              Circle()
                .width(3)
                .height(3)
                .fill(Color.Black)
              Blank()
              Circle()
                .width(3)
                .height(3)
                .fill(Color.Black)
            }
            .width(20)
            .margin({ bottom: 2 })
            Row()
              .width(20)
              .height(1)
              .backgroundColor(Color.Black)
              .margin({ bottom: 2 })
            Row()
              .width(20)
              .height(1)
              .backgroundColor(Color.Black)
              .margin({ bottom: 2 })
            Row()
              .width(20)
              .height(1)
              .backgroundColor(Color.Black)
          }
        }
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .borderRadius(14)
      .alignContent(Alignment.Center)

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
            .backgroundColor(task.tagColor)
            .borderRadius(4)
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Checkbox()
        .select(task.isChecked)
        .selectedColor('#FF212121')
        .onChange(() => {})
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }
}

interface TaskData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean
}
