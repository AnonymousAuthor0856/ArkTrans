// Translated from Kotlin (Jetpack Compose) to ArkTS (ArkUI) — Task Dashboard screen

class TaskData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean

  constructor(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, isChecked: boolean) {
    this.title = title
    this.time = time
    this.tag = tag
    this.tagColor = tagColor
    this.tagTextColor = tagTextColor
    this.isChecked = isChecked
  }
}

@Component
struct TaskItem {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagColor: string = ''
  tagTextColor: string = ''
  isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.tag === 'Personal' ? '😊' : '📅')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(48)
        .height(48)
        .borderRadius(14)
        .backgroundColor('#FFFFFF')

        Row().width(16)

        Column() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? '#888888' : '#000000')

          Row().height(4)

          Row() {
            Text(this.time)
              .fontSize(12)
              .fontColor('#888888')

            Row().width(8)

            Text(this.tag)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.tagTextColor)
              .backgroundColor(this.tagColor)
              .borderRadius(4)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Checkbox({ name: this.title })
          .select(this.isChecked)
          .selectedColor('#000000')
          .unselectedColor('#888888')
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .borderRadius(20)
    .backgroundColor('#FAFAFA')
  }
}

@Entry
@Component
struct MainPage {
  @State categories: string[] = ['All', 'Work', 'Personal', 'Design']
  @State tasks: TaskData[] = [
    new TaskData('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true),
    new TaskData('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false),
    new TaskData('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false),
    new TaskData('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false)
  ]

  @Builder
  TopHeader() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(22)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')

      Button() {
        Text('🔍')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
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
        .fontColor('#000000')

      Row().height(8)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          if (category === 'All') {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#212121')
              .borderRadius(50)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          } else {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#F5F5F5')
              .borderRadius(50)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
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
        .fontColor('#000000')
        .margin({ bottom: 16 })

      List({ space: 16 }) {
        ForEach(this.tasks, (task: TaskData) => {
          ListItem() {
            TaskItem({
              title: task.title,
              time: task.time,
              tag: task.tag,
              tagColor: task.tagColor,
              tagTextColor: task.tagTextColor,
              isChecked: task.isChecked
            })
          }
        }, (task: TaskData) => task.title)

        ListItem() {
          Row().height(80)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()

        Column() {
          Row().height(16)

          this.WelcomeSection()

          Row().height(32)

          this.CategorySelector()

          Row().height(24)

          this.RecentTasksList()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}
