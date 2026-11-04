class CategoryItem {
  name: string

  constructor(name: string) {
    this.name = name
  }
}

class TaskItemData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  checked: boolean

  constructor(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, checked: boolean) {
    this.title = title
    this.time = time
    this.tag = tag
    this.tagColor = tagColor
    this.tagTextColor = tagTextColor
    this.checked = checked
  }
}

@Entry
@Component
struct Index {
  private categories: CategoryItem[] = [
    new CategoryItem('All'),
    new CategoryItem('Work'),
    new CategoryItem('Personal'),
    new CategoryItem('Design')
  ]

  private tasks: TaskItemData[] = [
    new TaskItemData('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true),
    new TaskItemData('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false),
    new TaskItemData('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false),
    new TaskItemData('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false)
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()
        Scroll() {
          Column() {
            this.WelcomeSection()
            this.CategorySelector()
            this.RecentTasksList()
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 96 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(30)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Medium)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#212121')
        .padding(0)
        .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopHeader() {
    Row() {
      Button('☰')
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
        .width(48)
        .height(48)
        .padding(0)
      Button('⌕')
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
        .width(48)
        .height(48)
        .padding(0)
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
    Scroll() {
      Row() {
        ForEach(this.categories, (category: CategoryItem) => {
          Text(category.name)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(category.name === 'All' ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(50)
            .backgroundColor(category.name === 'All' ? '#212121' : '#F5F5F5')
            .margin({ right: 12 })
        })
      }
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ top: 32 })
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })
      ForEach(this.tasks, (task: TaskItemData) => {
        this.TaskItem(task)
      })
    }
    .width('100%')
    .margin({ top: 24 })
  }

  @Builder
  TaskItem(task: TaskItemData) {
    Row() {
      Stack() {
        Rect()
          .width(48)
          .height(48)
          .radius(14)
          .fill(Color.White)
        Text(task.tag === 'Personal' ? '☺' : '□')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.checked ? Color.Gray : Color.Black)
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
            .backgroundColor(task.tagColor)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Checkbox({ name: task.title, group: 'tasks' })
        .select(task.checked)
        .selectedColor(Color.Black)
        .onChange(() => {})
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }
}
