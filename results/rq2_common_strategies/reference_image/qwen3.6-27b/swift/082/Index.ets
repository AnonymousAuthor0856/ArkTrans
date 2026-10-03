import { router } from '@kit.ArkRouter';

@Entry
@Component
struct TaskApp {
  @State currentTab: string = 'All'
  @State tasks: TaskItem[] = [
    new TaskItem('Team Meeting', '10:00 AM - 11:30 AM', 'Work', true),
    new TaskItem('Design Review', '02:00 PM - 03:00 PM', 'Design', false),
    new TaskItem('Grocery Shopping', '05:30 PM', 'Personal', false)
  ]

  build() {
    Column() {
      // Header
      Row() {
        Button() {
          Image($r('app.media.ic_menu'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor('#F5F5F7')
        .borderRadius(24)
        .width(48)
        .height(48)

        Spacer()

        Button() {
          Image($r('app.media.ic_search'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor('#F5F5F7')
        .borderRadius(24)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10 })

      // Greeting
      Column() {
        Text('Hello, Alex')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text('You have 5 incomplete tasks today.')
          .fontSize(16)
          .fontColor('#9CA3AF')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      // Tabs
      Scroll() {
        Row() {
          ForEach(['All', 'Work', 'Personal', 'Design'], (tab: string) => {
            TabButton({ label: tab, isSelected: this.currentTab === tab })
              .onClick(() => {
                this.currentTab = tab
              })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      // Recent Tasks Header
      Text('Recent Tasks')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, top: 24 })

      // Task List
      List({ space: 12 }) {
        ForEach(this.tasks, (task: TaskItem) => {
          ListItem() {
            TaskCard(task)
          }
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16 })
      .listDirection(Axis.Vertical)
      .divider({ strokeWidth: 0 })

      // FAB
      Button() {
        Image($r('app.media.ic_add'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .backgroundColor('#1C1C1E')
      .borderRadius(28)
      .width(56)
      .height(56)
      .position({ x: 'calc(100% - 40px)', y: 'calc(100% - 100px)' })
      .shadow({ radius: 10, color: '#00000033', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TabButton {
  @Prop label: string
  @Prop isSelected: boolean

  build() {
    Button(this.label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .backgroundColor(this.isSelected ? '#1C1C1E' : '#F5F5F7')
      .borderRadius(24)
      .height(48)
      .margin({ right: 12 })
      .minWidth(100)
  }
}

@Component
struct TaskCard {
  @State task: TaskItem

  build() {
    Row() {
      // Icon
      Column() {
        if (this.task.category === 'Personal') {
          Image($r('app.media.ic_smile'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        } else {
          Image($r('app.media.ic_calendar'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
      }
      .width(56)
      .height(56)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(this.task.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.task.isCompleted ? '#9CA3AF' : Color.Black)
          .decoration(this.task.isCompleted ? TextDecoration.LineThrough : TextDecoration.None)
        
        Row() {
          Text(this.task.time)
            .fontSize(14)
            .fontColor('#9CA3AF')
          
          Spacer()
          
          Text(this.task.category)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCategoryColor())
            .backgroundColor(this.getCategoryBg())
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(8)
        }
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      // Checkbox
      Image(this.task.isCompleted ? $r('app.media.ic_checked') : $r('app.media.ic_unchecked'))
        .width(24)
        .height(24)
        .fillColor(this.task.isCompleted ? Color.White : '#9CA3AF')
        .backgroundColor(this.task.isCompleted ? '#1C1C1E' : Color.Transparent)
        .borderRadius(6)
        .border({ width: 2, color: '#9CA3AF' })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }

  getCategoryColor(): ResourceColor {
    switch (this.task.category) {
      case 'Work': return '#1D4ED8'
      case 'Design': return '#7E22CE'
      case 'Personal': return '#15803D'
      default: return '#6B7280'
    }
  }

  getCategoryBg(): ResourceColor {
    switch (this.task.category) {
      case 'Work': return '#DBEAFE'
      case 'Design': return '#F3E8FF'
      case 'Personal': return '#DCFCE7'
      default: return '#F3F4F6'
    }
  }
}

class TaskItem {
  title: string
  time: string
  category: string
  isCompleted: boolean

  constructor(title: string, time: string, category: string, isCompleted: boolean) {
    this.title = title
    this.time = time
    this.category = category
    this.isCompleted = isCompleted
  }
}