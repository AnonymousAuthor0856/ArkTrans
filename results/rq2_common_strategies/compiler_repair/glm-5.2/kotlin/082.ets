import { LengthMetrics } from '@ohos.arkui.theme';

interface TaskItemData {
  title: string;
  time: string;
  tag: string;
  tagColor: ResourceColor;
  tagTextColor: ResourceColor;
  isChecked: boolean;
}

@Entry
@Component
struct TaskDashboardScreen {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];
  private tasks: TaskItemData[] = [
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
  ];

  @Builder
  TopHeader() {
    Row() {
      Button() {
        Image($r('sys.media.ohos_ic_public_menu'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .type(ButtonType.Normal)
      .padding(0)

      Button() {
        Image($r('sys.media.ohos_ic_public_search'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .type(ButtonType.Normal)
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
        .fontColor('#000000')
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          if (category === 'All') {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#212121')
              .borderRadius(50)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          } else {
            Text(category)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#F5F5F5')
              .borderRadius(50)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  TaskItem(item: TaskItemData) {
    Row() {
      Row() {
        Image(item.tag === 'Personal' ? $r('sys.media.ohos_ic_public_contacts') : $r('sys.media.ohos_ic_public_calendar'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(item.isChecked ? '#808080' : '#000000')
        Row() {
          Text(item.time)
            .fontSize(12)
            .fontColor('#808080')
          Text(item.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(item.tagTextColor)
            .backgroundColor(item.tagColor)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Checkbox()
        .select(item.isChecked)
        .selectedColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
      ForEach(this.tasks, (task: TaskItemData) => {
        this.TaskItem(task)
        Blank().height(16)
      })
      Blank().height(80)
    }
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()
        Column() {
          this.WelcomeSection()
          Blank().height(32)
          this.CategorySelector()
          Blank().height(24)
          this.RecentTasksList()
        }
        .width('100%')
        .height('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .type(ButtonType.Normal)
      .padding(0)
      .margin({ right: 24, bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}