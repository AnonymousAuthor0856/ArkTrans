import { hilog } from '@kit.PerformanceAnalysisKit';
import { display } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State selectedCategory: string = 'All';
  @State tasks: TaskItemData[] = [
    { title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true },
    { title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false },
    { title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false },
    { title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false }
  ];
  @State categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  aboutToAppear(): void {
    // Hide system bars for immersive experience
    window.getLastWindow(getContext(this)).then((windowClass) => {
      windowClass.setWindowLayoutFullScreen(true);
    });
  }

  build() {
    Stack() {
      Column() {
        // Top Header
        this.TopHeader();

        // Main Content
        Scroll() {
          Column({ space: 16 }) {
            // Welcome Section
            this.WelcomeSection();

            // Category Selector
            this.CategorySelector();

            // Recent Tasks
            this.RecentTasksList();
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 100 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(28)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .position({ x: '85%', y: '88%' })
      .shadow({ radius: 8, color: '#40212121', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TopHeader() {
    Row() {
      // Menu Icon Button
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .padding(0)

      Blank()

      // Search Icon Button
      Button() {
        Text('🔍')
          .fontSize(18)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .padding(0)
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  WelcomeSection() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#000000')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(50)
            .backgroundColor(category === this.selectedCategory ? '#212121' : '#F5F5F5')
            .onClick(() => {
              this.selectedCategory = category;
            })
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  RecentTasksList() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(this.tasks, (task: TaskItemData, index: number) => {
        this.TaskItem(task, index)
      })

      // Bottom spacer
      Row()
        .height(80)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TaskItem(task: TaskItemData, index: number) {
    Row() {
      // Icon Box
      Row() {
        Text(task.tag === 'Personal' ? '😊' : '📅')
          .fontSize(20)
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank()
        .width(16)

      // Task Details
      Column({ space: 4 }) {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.isChecked ? '#808080' : '#000000')

        Row({ space: 8 }) {
          Text(task.time)
            .fontSize(12)
            .fontColor('#808080')

          Text(task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
            .backgroundColor(task.tagColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Checkbox
      Checkbox()
        .select(task.isChecked)
        .selectedColor('#000000')
        .unselectedColor('#808080')
        .width(24)
        .height(24)
        .onChange((value: boolean) => {
          this.tasks[index].isChecked = value;
        })
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
  }
}

interface TaskItemData {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
}