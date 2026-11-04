class TaskColors {
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static dark: string = '#212121'
  static soft: string = '#F5F5F5'
  static card: string = '#FAFAFA'
  static gray: string = '#808080'
  static workBg: string = '#E3F2FD'
  static workText: string = '#1565C0'
  static designBg: string = '#F3E5F5'
  static designText: string = '#7B1FA2'
  static personalBg: string = '#E8F5E9'
  static personalText: string = '#2E7D32'
  static studyBg: string = '#FFF3E0'
  static studyText: string = '#EF6C00'
}

class TaskData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  icon: string

  constructor(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, icon: string) {
    this.title = title
    this.time = time
    this.tag = tag
    this.tagColor = tagColor
    this.tagTextColor = tagTextColor
    this.icon = icon
  }
}

@Entry
@Component
struct Index {
  @State checked0: boolean = true
  @State checked1: boolean = false
  @State checked2: boolean = false
  @State checked3: boolean = false

  private categories: string[] = ['All', 'Work', 'Personal', 'Design']
  private tasks: TaskData[] = [
    new TaskData('Team Meeting', '10:00 AM - 11:30 AM', 'Work', TaskColors.workBg, TaskColors.workText, 'Cal'),
    new TaskData('Design Review', '02:00 PM - 03:00 PM', 'Design', TaskColors.designBg, TaskColors.designText, 'Cal'),
    new TaskData('Grocery Shopping', '05:30 PM', 'Personal', TaskColors.personalBg, TaskColors.personalText, 'Face'),
    new TaskData('Read Documentation', '08:00 PM', 'Study', TaskColors.studyBg, TaskColors.studyText, 'Cal')
  ]

  private checked(index: number): boolean {
    if (index === 0) {
      return this.checked0
    }
    if (index === 1) {
      return this.checked1
    }
    if (index === 2) {
      return this.checked2
    }
    return this.checked3
  }

  @Builder
  TopHeader() {
    Row() {
      Button('Menu')
        .fontSize(12)
        .fontColor(TaskColors.black)
        .width(48)
        .height(48)
        .backgroundColor(TaskColors.soft)
        .borderRadius(24)

      Blank()
        .layoutWeight(1)

      Button('Search')
        .fontSize(12)
        .fontColor(TaskColors.black)
        .width(48)
        .height(48)
        .backgroundColor(TaskColors.soft)
        .borderRadius(24)
    }
    .width('100%')
  }

  @Builder
  WelcomeSection() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(TaskColors.black)
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(TaskColors.gray)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategoryChip(category: string) {
    Text(category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(category === 'All' ? TaskColors.white : TaskColors.black)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(category === 'All' ? TaskColors.dark : TaskColors.soft)
      .borderRadius(24)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          this.CategoryChip(category)
        })
      }
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  TaskItemView(task: TaskData, index: number) {
    Row({ space: 16 }) {
      Stack() {
        Rect()
          .width(48)
          .height(48)
          .fill(TaskColors.white)
          .radius(14)
        Text(task.icon)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(TaskColors.black)
      }
      .width(48)
      .height(48)

      Column({ space: 4 }) {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked(index) ? TaskColors.gray : TaskColors.black)
          .decoration({ type: this.checked(index) ? TextDecorationType.LineThrough : TextDecorationType.None, color: TaskColors.gray })

        Row({ space: 8 }) {
          Text(task.time)
            .fontSize(12)
            .fontColor(TaskColors.gray)

          Text(task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(task.tagColor)
            .borderRadius(4)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(this.checked(index) ? 'Done' : 'Todo')
        .fontSize(11)
        .fontColor(this.checked(index) ? TaskColors.black : TaskColors.gray)
        .backgroundColor('#00000000')
        .onClick(() => {
          if (index === 0) {
            this.checked0 = !this.checked0
          } else if (index === 1) {
            this.checked1 = !this.checked1
          } else if (index === 2) {
            this.checked2 = !this.checked2
          } else {
            this.checked3 = !this.checked3
          }
        })
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(TaskColors.card)
    .borderRadius(20)
  }

  @Builder
  RecentTasksList() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(TaskColors.black)
        .width('100%')

      ForEach(this.tasks, (task: TaskData, index?: number) => {
        this.TaskItemView(task, index ? index : 0)
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          this.TopHeader()
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            Blank().height(16)
            this.WelcomeSection()
            Blank().height(32)
            this.CategorySelector()
            Blank().height(24)
            this.RecentTasksList()
            Blank().height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(TaskColors.white)
        .width(56)
        .height(56)
        .backgroundColor(TaskColors.dark)
        .borderRadius(28)
        .shadow({ radius: 4, color: '#33000000', offsetY: 4 })
        .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(TaskColors.white)
  }
}
