class TaskInfo {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagBg: string = ''
  tagText: string = ''
  isChecked: boolean = false
  icon: string = ''
  constructor(title: string, time: string, tag: string, tagBg: string, tagText: string, isChecked: boolean, icon: string) {
    this.title = title
    this.time = time
    this.tag = tag
    this.tagBg = tagBg
    this.tagText = tagText
    this.isChecked = isChecked
    this.icon = icon
  }
}

@Entry
@Component
struct TaskDashboardScreen {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']
  private tasks: TaskInfo[] = [
    new TaskInfo('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true, '📅'),
    new TaskInfo('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false, '📅'),
    new TaskInfo('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false, '😊'),
    new TaskInfo('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false, '📅'),
  ]

  @Builder
  CategoryChipBuilder(category: string) {
    Text(category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(category === 'All' ? '#FFFFFF' : '#000000')
      .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
      .borderRadius(50)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskItemBuilder(task: TaskInfo) {
    Row() {
      Column() {
        Text(task.icon)
          .fontSize(22)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFFFF')
      .borderRadius(14)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.isChecked ? '#888888' : '#000000)

        Row() {
          Text(task.time)
            .fontSize(12)
            .fontColor('#888888')
          Text(task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.tagText)
            .backgroundColor(task.tagBg)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Column() {
        if (task.isChecked) {
          Text('✓')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
      }
      .width(24)
      .height(24)
      .backgroundColor(task.isChecked ? '#000000' : '#00000000')
      .borderWidth(task.isChecked ? 0 : 2)
      .borderColor('#888888')
      .borderRadius(4)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('☰')
              .fontSize(22)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text('🔍')
              .fontSize(22)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text('Hello, Alex')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Text('You have 5 incomplete tasks today.')
            .fontSize(16)
            .fontColor('#888888')
            .margin({ top: 8 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 16 })

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
        .margin({ top: 32 })

        Text('Recent Tasks')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 24, left: 24, right: 24 })

        List({ space: 16 }) {
          ForEach(this.tasks, (task: TaskInfo) => {
            ListItem() {
              this.TaskItemBuilder(task)
            }
          }, (task: TaskInfo) => task.title)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 24, right: 24, top: 16, bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Column() {
        Text('+')
          .fontSize(28)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '85%', y: '88%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}