class TaskItemModel {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  checked: boolean;

  constructor(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, checked: boolean) {
    this.title = title;
    this.time = time;
    this.tag = tag;
    this.tagColor = tagColor;
    this.tagTextColor = tagTextColor;
    this.checked = checked;
  }
}

@Entry
@Component
struct MainActivity {
  @State tasks: TaskItemModel[] = [
    new TaskItemModel('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true),
    new TaskItemModel('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false),
    new TaskItemModel('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false),
    new TaskItemModel('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false)
  ];
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  private toggleTask(index: number, value: boolean): void {
    this.tasks[index].checked = value;
    this.tasks = [...this.tasks];
  }

  @Builder
  TopHeader() {
    Row() {
      Text('≡')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
      Text('⌕')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
    }
    .width('100%')
    .padding({ top: 48, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Row({ space: 12 }) {
      ForEach(this.categories, (category: string) => {
        Text(category)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(category === 'All' ? '#FFFFFF' : '#000000')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
          .borderRadius(25)
      })
    }
    .width('100%')
  }

  @Builder
  TaskCard(task: TaskItemModel, index: number) {
    Row() {
      Text(task.tag === 'Personal' ? '☺' : '▣')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#FFFFFF')
        .borderRadius(14)

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.checked ? '#808080' : '#000000')
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
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Checkbox({ name: task.title, group: 'tasks' })
        .select(task.checked)
        .selectedColor('#000000')
        .onChange((value: boolean) => {
          this.toggleTask(index, value);
        })
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width('100%')
        .margin({ bottom: 16 })
      Column({ space: 16 }) {
        ForEach(this.tasks, (task: TaskItemModel, index: number) => {
          this.TaskCard(task, index)
        })
        Blank().height(80)
      }
      .width('100%')
    }
    .width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          this.TopHeader()
          this.WelcomeSection()
          Blank().height(32)
          this.CategorySelector()
          Blank().height(24)
          this.RecentTasksList()
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .scrollBar(BarState.Off)

      Text('+')
        .fontSize(28)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor('#212121')
        .borderRadius(28)
        .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
