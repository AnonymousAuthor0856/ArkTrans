class TaskData {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
  icon: string;

  constructor(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, isChecked: boolean, icon: string) {
    this.title = title;
    this.time = time;
    this.tag = tag;
    this.tagColor = tagColor;
    this.tagTextColor = tagTextColor;
    this.isChecked = isChecked;
    this.icon = icon;
  }
}

@Entry
@Component
struct TaskDashboardScreen {
  @State private checked: boolean[] = [true, false, false, false];
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];
  private tasks: TaskData[] = [
    new TaskData('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true, '□'),
    new TaskData('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false, '□'),
    new TaskData('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false, '☺'),
    new TaskData('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false, '□')
  ];

  @Builder
  private TopHeader() {
    Row() {
      Button('☰')
        .width(48)
        .height(48)
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
      Blank()
      Button('⌕')
        .width(48)
        .height(48)
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
    }
    .width('100%')
  }

  @Builder
  private WelcomeSection() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'All' ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
            .borderRadius(24)
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  private TaskItem(task: TaskData, index: number) {
    Row({ space: 16 }) {
      Stack() {
        Rect()
          .width(48)
          .height(48)
          .fill(Color.White)
          .radius(14)
        Text(task.icon)
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)

      Column({ space: 4 }) {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked[index] ? '#808080' : Color.Black)
          .decoration({ type: this.checked[index] ? TextDecorationType.LineThrough : TextDecorationType.None, color: '#808080' })
        Row({ space: 8 }) {
          Text(task.time)
            .fontSize(12)
            .fontColor('#808080')
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

      Text(this.checked[index] ? '☑' : '☐')
        .fontSize(24)
        .fontColor(this.checked[index] ? Color.Black : '#808080')
        .onClick(() => {
          let next: boolean[] = this.checked.slice();
          next[index] = !next[index];
          this.checked = next;
        })
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }

  @Builder
  private RecentTasksList() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Start)
      ForEach(this.tasks, (task: TaskData, index: number) => {
        this.TaskItem(task, index)
      })
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopHeader()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)
            this.WelcomeSection()
            Blank().height(32)
            this.CategorySelector()
            Blank().height(24)
            this.RecentTasksList()
            Blank().height(80)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .width(56)
            .height(56)
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.White)
            .backgroundColor('#212121')
            .borderRadius(28)
            .shadow({ radius: 4, color: '#00000033', offsetX: 0, offsetY: 4 })
            .margin({ right: 24, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
