import { router } from '@kit.ArkUI';

// Mock data and types
interface TaskItemData {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
  icon: string;
}

@Entry
@Component
struct TaskDashboardApp {
  @State private tasks: TaskItemData[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true,
      icon: 'calendar'
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false,
      icon: 'calendar'
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false,
      icon: 'face_smiling' // Using a generic name, actual icon depends on resource bundle
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false,
      icon: 'calendar'
    }
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomEnd }) {
        // Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')

        Column() {
          // Top Header
          TopHeader()
            .padding({ top: 48, left: 24, right: 24, bottom: 16 })

          // Content
          Scroll() {
            Column({ space: 0 }) {
              Blank().height(16)
              WelcomeSection()
              Blank().height(32)
              CategorySelector()
              Blank().height(24)
              RecentTasksList({ tasks: this.tasks })
              Blank().height(80) // Bottom padding for FAB
            }
            .padding({ left: 24, right: 24 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .height('100%')

        // FAB
        Button() {
          Image($r('app.media.ic_plus')) // Assuming an icon exists or use system symbol if supported in specific API version
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .width(56)
        .height(56)
        .backgroundColor('#212121')
        .borderRadius(28)
        .shadow({ radius: 4, color: '#00000033', offsetY: 4 })
        .margin({ right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        Image($r('app.media.ic_menu')) // Placeholder for line.3.horizontal
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)

      Blank()

      Button() {
        Image($r('app.media.ic_search')) // Placeholder for magnifyingglass
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
    }
    .width('100%')
  }
}

@Component
struct WelcomeSection {
  build() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          let isSelected = category === 'All';
          let backgroundColor = isSelected ? '#212121' : '#F5F5F5';
          let textColor = isSelected ? Color.White : Color.Black;

          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(textColor)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(backgroundColor)
            .borderRadius(20) // Capsule shape approximation
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecentTasksList {
  @Link tasks: TaskItemData[];

  build() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      List({ space: 16 }) {
        ForEach(this.tasks, (task: TaskItemData, index: number) => {
          ListItem() {
            TaskItem({ task: task, index: index })
          }
        })
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TaskItem {
  @Prop task: TaskItemData;
  @Prop index: number; // Note: In real app, you'd update the state in parent, here we simulate local toggle for UI demo

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Rect()
          .width(48)
          .height(48)
          .borderRadius(14)
          .fill(Color.White)

        Image($r('app.media.ic_calendar')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }

      Column({ space: 4 }) {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.task.isChecked ? Color.Gray : Color.Black)
          .decoration({
            type: this.task.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: Color.Gray
          })

        Row({ space: 8 }) {
          Text(this.task.time)
            .fontSize(12)
            .fontColor(Color.Gray)

          Text(this.task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.task.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.task.tagColor)
            .borderRadius(4)
        }
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Checkbox
      Button() {
        Image(this.task.isChecked ? $r('app.media.ic_check_filled') : $r('app.media.ic_check_empty'))
          .width(24)
          .height(24)
          .fillColor(this.task.isChecked ? Color.Black : Color.Gray)
      }
      .onClick(() => {
        // In a real scenario, update the parent state
        // This is a simplified visual toggle
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}