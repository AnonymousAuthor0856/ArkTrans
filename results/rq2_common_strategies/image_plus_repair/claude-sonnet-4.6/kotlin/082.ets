import { LengthMetrics } from '@kit.ArkUI'

interface TaskData {
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
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopHeader()
        Column() {
          WelcomeSection()
          Blank().height(32)
          CategorySelector()
          Blank().height(24)
          RecentTasksList()
        }
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(28)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .margin({ bottom: 32, right: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('☰')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')

      Button({ type: ButtonType.Circle }) {
        Text('🔍')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Blank().height(8)
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          CategoryChip({ category: category, isSelected: category === 'All' })
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CategoryChip {
  category: string = ''
  isSelected: boolean = false

  build() {
    Text(this.category)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .fontWeight(FontWeight.Medium)
      .fontSize(14)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(this.isSelected ? '#212121' : '#F5F5F5')
      .borderRadius(50)
  }
}

@Component
struct RecentTasksList {
  private tasks: TaskData[] = [
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
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
        .width('100%')

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
        })
        ListItem() {
          Column().height(80)
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
    Row() {
      Column() {
        Text(this.tag === 'Personal' ? '😊' : '📅')
          .fontSize(24)
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.Gray : Color.Black)
          .width('100%')
        Blank().height(4)
        Row() {
          Text(this.time)
            .fontSize(12)
            .fontColor(Color.Gray)
          Blank().width(8)
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
      .margin({ left: 16 })

      CheckboxItem({ isChecked: this.isChecked })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CheckboxItem {
  isChecked: boolean = false

  build() {
    Stack() {
      if (this.isChecked) {
        Column() {
          Text('✓')
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .borderRadius(4)
        .backgroundColor('#212121')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Column()
          .width(24)
          .height(24)
          .borderRadius(4)
          .border({ width: 2, color: Color.Gray })
          .backgroundColor(Color.Transparent)
      }
    }
  }
}