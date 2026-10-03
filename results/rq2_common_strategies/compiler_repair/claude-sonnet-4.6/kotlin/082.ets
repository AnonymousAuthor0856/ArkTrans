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
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()
        Scroll() {
          Column() {
            Column({ space: 8 }) {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .fontColor('#888888')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 16 })

            this.CategorySelector()

            this.RecentTasksList()

            Blank().height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(28)
          .fontColor('#FFFFFF')
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

  @Builder
  TopHeader() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('☰')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')

      Button({ type: ButtonType.Circle }) {
        Text('🔍')
          .fontSize(18)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .padding({ top: 48, start: 24, end: 24, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(['All', 'Work', 'Personal', 'Design'], (category: string) => {
          this.CategoryChip(category, category === 'All')
        })
      }
      .padding({ top: 2, bottom: 2 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .margin({ top: 32, bottom: 24 })
  }

  @Builder
  CategoryChip(category: string, isSelected: boolean) {
    Text(category)
      .fontColor(isSelected ? '#FFFFFF' : '#000000')
      .fontWeight(FontWeight.Medium)
      .fontSize(14)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(isSelected ? '#212121' : '#F5F5F5')
      .borderRadius(50)
  }

  @Builder
  RecentTasksList() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width('100%')
        .margin({ bottom: 0 })

      this.TaskItem({
        title: 'Team Meeting',
        time: '10:00 AM - 11:30 AM',
        tag: 'Work',
        tagColor: '#E3F2FD',
        tagTextColor: '#1565C0',
        isChecked: true
      })

      this.TaskItem({
        title: 'Design Review',
        time: '02:00 PM - 03:00 PM',
        tag: 'Design',
        tagColor: '#F3E5F5',
        tagTextColor: '#7B1FA2',
        isChecked: false
      })

      this.TaskItem({
        title: 'Grocery Shopping',
        time: '05:30 PM',
        tag: 'Personal',
        tagColor: '#E8F5E9',
        tagTextColor: '#2E7D32',
        isChecked: false
      })

      this.TaskItem({
        title: 'Read Documentation',
        time: '08:00 PM',
        tag: 'Study',
        tagColor: '#FFF3E0',
        tagTextColor: '#EF6C00',
        isChecked: false
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  TaskItem(task: TaskData) {
    Row() {
      Stack() {
        Text(task.tag === 'Personal' ? '😊' : '📅')
          .fontSize(22)
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFFFF')
      .borderRadius(14)

      Column({ space: 4 }) {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.isChecked ? '#888888' : '#000000')

        Row({ space: 8 }) {
          Text(task.time)
            .fontSize(12)
            .fontColor('#888888')

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
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Checkbox()
        .select(task.isChecked)
        .selectedColor('#000000')
        .width(24)
        .height(24)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}