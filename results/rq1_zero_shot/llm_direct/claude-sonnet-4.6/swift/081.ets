import { router } from '@kit.ArkUI';

interface TaskData {
  title: string;
  time: string;
  tag: string;
  tagBgColor: string;
  tagTextColor: string;
  isChecked: boolean;
  icon: Resource;
}

@Entry
@Component
struct TaskDashboardScreen {
  @State tasks: TaskData[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagBgColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true,
      icon: $r('sys.symbol.calendar')
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagBgColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false,
      icon: $r('sys.symbol.calendar')
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagBgColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false,
      icon: $r('sys.symbol.smiley')
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagBgColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false,
      icon: $r('sys.symbol.calendar')
    }
  ];

  @State selectedCategory: string = 'All';
  categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Header
        Row() {
          Button() {
            SymbolGlyph($r('sys.symbol.text_justify'))
              .fontSize(20)
              .fontColor(['#000000'])
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .type(ButtonType.Normal)

          Blank()

          Button() {
            SymbolGlyph($r('sys.symbol.magnifyingglass'))
              .fontSize(20)
              .fontColor(['#000000'])
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

              ForEach(this.tasks, (task: TaskData, index: number) => {
                TaskItemComponent({
                  task: task,
                  onToggle: () => {
                    const updated = [...this.tasks];
                    updated[index] = { ...updated[index], isChecked: !updated[index].isChecked };
                    this.tasks = updated;
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

      // FAB
      Button() {
        SymbolGlyph($r('sys.symbol.plus'))
          .fontSize(24)
          .fontColor(['#FFFFFF'])
          .fontWeight(FontWeight.Medium)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .type(ButtonType.Normal)
      .shadow({ radius: 8, color: '#44000000', offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TaskItemComponent {
  task: TaskData = {
    title: '',
    time: '',
    tag: '',
    tagBgColor: '#FFFFFF',
    tagTextColor: '#000000',
    isChecked: false,
    icon: $r('sys.symbol.calendar')
  };
  onToggle: () => void = () => {};

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Column()
          .width(48)
          .height(48)
          .borderRadius(14)
          .backgroundColor('#FFFFFF')

        SymbolGlyph(this.task.icon)
          .fontSize(24)
          .fontColor(['#000000'])
      }

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
        SymbolGlyph(this.task.isChecked
          ? $r('sys.symbol.checkmark_square_fill')
          : $r('sys.symbol.square'))
          .fontSize(24)
          .fontColor([this.task.isChecked ? '#000000' : '#888888'])
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
      .onClick(() => {
        this.onToggle();
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}