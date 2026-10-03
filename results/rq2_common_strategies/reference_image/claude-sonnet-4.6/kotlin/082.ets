// entry/src/main/ets/pages/TaskDashboard.ets
import { window } from '@kit.ArkUI';

interface TaskModel {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  icon: string; // 'face' | 'calendar'
  checked: boolean;
}

@Entry
@Component
struct TaskDashboard {
  @State selectedCategory: string = 'All';
  @State categories: string[] = ['All', 'Work', 'Personal', 'Design'];
  @State tasks: TaskModel[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      icon: 'calendar',
      checked: true
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      icon: 'calendar',
      checked: false
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      icon: 'face',
      checked: false
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      icon: 'calendar',
      checked: false
    }
  ];

  onPageShow(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopHeader()

        Scroll() {
          Column() {
            this.WelcomeSection()
            this.CategorySelector()
            this.RecentTasks()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24, bottom: 120 })
        }
        .layoutWeight(1)
        .align(Alignment.TopStart)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')

      this.FloatingAddButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // ---------------------------------------------------------------- Header

  @Builder
  TopHeader() {
    Row() {
      Row() {
        this.MenuIcon()
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .onClick(() => {})

      Row() {
        this.SearchIcon()
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
  }

  @Builder
  MenuIcon() {
    Column({ space: 4 }) {
      Row() {}.width(18).height(2).backgroundColor(Color.Black).borderRadius(1)
      Row() {}.width(18).height(2).backgroundColor(Color.Black).borderRadius(1)
      Row() {}.width(18).height(2).backgroundColor(Color.Black).borderRadius(1)
    }
    .width(22)
    .height(22)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  SearchIcon() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 13, height: 13 })
        .fill(Color.Transparent)
        .stroke(Color.Black)
        .strokeWidth(2)
        .offset({ x: -2, y: -2 })

      Row() {}
        .width(7)
        .height(2)
        .backgroundColor(Color.Black)
        .borderRadius(1)
        .rotate({ angle: 45 })
        .offset({ x: 5, y: 5 })
    }
    .width(22)
    .height(22)
  }

  // ---------------------------------------------------------------- Welcome

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#9E9E9E')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 16 })
  }

  // ---------------------------------------------------------------- Categories

  @Builder
  CategorySelector() {
    List({ space: 12 }) {
      ForEach(this.categories, (category: string) => {
        ListItem() {
          Row() {
            Text(category)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedCategory === category ? Color.White : Color.Black)
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
          .borderRadius(50)
          .onClick(() => {
            this.selectedCategory = category;
          })
        }
      }, (category: string) => category)
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(48)
    .margin({ top: 32 })
  }

  // ---------------------------------------------------------------- Tasks

  @Builder
  RecentTasks() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      ForEach(this.tasks, (task: TaskModel, index: number) => {
        this.TaskItem(task, index)
      }, (task: TaskModel) => task.title)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 24 })
  }

  @Builder
  TaskItem(task: TaskModel, index: number) {
    Row() {
      Row() {
        if (task.icon === 'face') {
          this.FaceIcon()
        } else {
          this.CalendarIcon()
        }
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.checked ? '#9E9E9E' : '#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(task.time)
            .fontSize(12)
            .fontColor('#9E9E9E')

          Text(task.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.tagTextColor)
            .backgroundColor(task.tagColor)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Checkbox({ name: 'task_' + index, group: 'tasks' })
        .select(task.checked)
        .selectedColor(Color.Black)
        .unselectedColor('#9E9E9E')
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        .width(24)
        .height(24)
        .onChange((value: boolean) => {
          const list: TaskModel[] = this.tasks.slice();
          list[index].checked = value;
          this.tasks = list;
        })
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .margin({ bottom: 16 })
  }

  @Builder
  CalendarIcon() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width(17)
        .height(15)
        .borderRadius(3)
        .borderWidth(2)
        .borderColor(Color.Black)
        .backgroundColor(Color.White)
        .offset({ y: 2 })

      Row() {}
        .width(17)
        .height(3)
        .backgroundColor(Color.Black)
        .borderRadius(2)
        .offset({ y: -6 })

      Row({ space: 7 }) {
        Row() {}.width(2).height(4).backgroundColor(Color.Black).borderRadius(1)
        Row() {}.width(2).height(4).backgroundColor(Color.Black).borderRadius(1)
      }
      .offset({ y: -10 })
    }
    .width(24)
    .height(24)
  }

  @Builder
  FaceIcon() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 19, height: 19 })
        .fill(Color.Transparent)
        .stroke(Color.Black)
        .strokeWidth(1.6)

      Row({ space: 6 }) {
        Row() {}.width(2).height(2).backgroundColor(Color.Black).borderRadius(1)
        Row() {}.width(2).height(2).backgroundColor(Color.Black).borderRadius(1)
      }
      .offset({ y: -3 })

      Row() {}
        .width(7)
        .height(2)
        .backgroundColor(Color.Black)
        .borderRadius(1)
        .offset({ y: 4 })
    }
    .width(24)
    .height(24)
  }

  // ---------------------------------------------------------------- FAB

  @Builder
  FloatingAddButton() {
    Button() {
      Text('+')
        .fontSize(32)
        .fontWeight(FontWeight.Regular)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .height(38)
    }
    .type(ButtonType.Circle)
    .width(64)
    .height(64)
    .backgroundColor('#212121')
    .margin({ right: 24, bottom: 32 })
    .shadow({ radius: 24, color: '#33000000', offsetX: 0, offsetY: 8 })
    .onClick(() => {})
  }
}