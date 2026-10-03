@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: string = 'All';
  @State tasks: TaskData[] = [
    {
      id: 1,
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagBgColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true,
    },
    {
      id: 2,
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagBgColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false,
    },
    {
      id: 3,
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagBgColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false,
    },
    {
      id: 4,
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagBgColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false,
    }
  ];

  categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Header
        Row() {
          Button() {
            Text('\u2630')
              .fontSize(20)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .type(ButtonType.Normal)

          Blank()

          Button() {
            Text('\uD83D\uDD0D')
              .fontSize(18)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .type(ButtonType.Normal)
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            // Welcome Section
            Column({ space: 8 }) {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .width('100%')

              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .fontColor('#888888')
                .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 16 })

            // Category Selector
            Scroll() {
              Row({ space: 12 }) {
                ForEach(this.categories, (category: string) => {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedCategory === category ? '#FFFFFF' : '#000000')
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                    .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
                    .borderRadius(50)
                    .onClick(() => {
                      this.selectedCategory = category;
                    })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: 32 })

            // Recent Tasks
            Column({ space: 16 }) {
              Text('Recent Tasks')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .width('100%')

              ForEach(this.tasks, (task: TaskData) => {
                TaskItemComponent({
                  task: task,
                  onToggle: (id: number) => {
                    this.tasks = this.tasks.map((t: TaskData) => {
                      if (t.id === id) {
                        return {
                          id: t.id,
                          title: t.title,
                          time: t.time,
                          tag: t.tag,
                          tagBgColor: t.tagBgColor,
                          tagTextColor: t.tagTextColor,
                          isChecked: !t.isChecked,
                        } as TaskData;
                      }
                      return t;
                    });
                  }
                })
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 24 })

            // Bottom padding for FAB
            Column()
              .height(80)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Start)

      // FAB Button
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 2 })
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .type(ButtonType.Normal)
      .shadow({ radius: 8, color: '#44000000', offsetX: 0, offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

interface TaskData {
  id: number;
  title: string;
  time: string;
  tag: string;
  tagBgColor: string;
  tagTextColor: string;
  isChecked: boolean;
}

@Component
struct TaskItemComponent {
  @Prop task: TaskData;
  onToggle: (id: number) => void = () => {};

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Column()
          .width(48)
          .height(48)
          .borderRadius(14)
          .backgroundColor('#FFFFFF')

        Text('\uD83D\uDCC5')
          .fontSize(22)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)

      // Task Info
      Column({ space: 4 }) {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.task.isChecked ? '#888888' : '#000000')
          .decoration(this.task.isChecked
            ? { type: TextDecorationType.LineThrough, color: '#888888' }
            : { type: TextDecorationType.None })
          .width('100%')

        Row({ space: 8 }) {
          Text(this.task.time)
            .fontSize(12)
            .fontColor('#888888')

          Text(this.task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.task.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.task.tagBgColor)
            .borderRadius(4)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Checkbox
      Button() {
        Text(this.task.isChecked ? '☑' : '☐')
          .fontSize(24)
          .fontColor(this.task.isChecked ? '#000000' : '#888888')
      }
      .width(36)
      .height(36)
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
      .onClick(() => {
        this.onToggle(this.task.id);
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}