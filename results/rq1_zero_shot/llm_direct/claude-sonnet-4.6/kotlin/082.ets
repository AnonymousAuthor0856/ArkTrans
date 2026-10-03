import { LengthMetrics } from '@kit.ArkUI';

interface TaskData {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
}

@Entry
@Component
struct TaskDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopHeader()
        Column() {
          Blank().height(16)
          WelcomeSection()
          Blank().height(32)
          CategorySelector()
          Blank().height(24)
          RecentTasksList()
        }
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .margin({ bottom: 32, right: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        Image($r('sys.media.ohos_ic_public_list_ul'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')

      Button() {
        Image($r('sys.media.ohos_ic_public_search_filled'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 48, start: 24, end: 24, bottom: 16 })
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Blank().height(8)
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    List({ space: 12 }) {
      ForEach(this.categories, (category: string) => {
        ListItem() {
          CategoryChip({ category: category, isSelected: category === 'All' })
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CategoryChip {
  @Prop category: string = '';
  @Prop isSelected: boolean = false;

  build() {
    Text(this.category)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .fontWeight(FontWeight.Medium)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(this.isSelected ? '#212121' : '#F5F5F5')
      .borderRadius(50)
  }
}

@Component
struct RecentTasksList {
  private tasks: TaskData[] = [
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

  build() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      List({ space: 16 }) {
        ForEach(this.tasks, (task: TaskData) => {
          ListItem() {
            TaskItem({
              title: task.title,
              time: task.time,
              tag: task.tag,
              tagColor: task.tagColor,
              tagTextColor: task.tagTextColor,
              isChecked: task.isChecked
            })
          }
        })
        ListItem() {
          Blank().height(80)
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .layoutWeight(1)
  }
}

@Component
struct TaskItem {
  @Prop title: string = '';
  @Prop time: string = '';
  @Prop tag: string = '';
  @Prop tagColor: string = '';
  @Prop tagTextColor: string = '';
  @Prop isChecked: boolean = false;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = this.isChecked;
  }

  build() {
    Row() {
      Column() {
        Image(this.tag === 'Personal'
          ? $r('sys.media.ohos_ic_public_contacts_filled')
          : $r('sys.media.ohos_ic_public_calendar'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.Gray : Color.Black)
        Blank().height(4)
        Row() {
          Text(this.time)
            .fontSize(12)
            .fontColor(Color.Gray)
          Blank().width(8)
          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tagColor)
            .borderRadius(4)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Checkbox()
        .select(this.checked)
        .selectedColor('#212121')
        .unselectedColor(Color.Gray)
        .onChange((value: boolean) => {
          this.checked = value;
        })
        .width(24)
        .height(24)
    }
    .padding(20)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}