import { window } from '@kit.ArkUI';

// Data Models
interface TaskItemData {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
}

const TASKS: TaskItemData[] = [
  {
    title: "Team Meeting",
    time: "10:00 AM - 11:30 AM",
    tag: "Work",
    tagColor: "#E3F2FD",
    tagTextColor: "#1565C0",
    isChecked: true
  },
  {
    title: "Design Review",
    time: "02:00 PM - 03:00 PM",
    tag: "Design",
    tagColor: "#F3E5F5",
    tagTextColor: "#7B1FA2",
    isChecked: false
  },
  {
    title: "Grocery Shopping",
    time: "05:30 PM",
    tag: "Personal",
    tagColor: "#E8F5E9",
    tagTextColor: "#2E7D32",
    isChecked: false
  },
  {
    title: "Read Documentation",
    time: "08:00 PM",
    tag: "Study",
    tagColor: "#FFF3E0",
    tagTextColor: "#EF6C00",
    isChecked: false
  }
];

const CATEGORIES: string[] = ["All", "Work", "Personal", "Design"];

@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: number = 0;

  build() {
    Column() {
      // Main Content Area
      Column() {
        TopHeader()
        
        Column() {
          WelcomeSection()
            .margin({ top: 16, bottom: 32 })
          
          CategorySelector({ 
            categories: CATEGORIES, 
            selectedIndex: this.selectedCategory, 
            onIndexChange: (index: number) => {
              this.selectedCategory = index;
            } 
          })
            .margin({ bottom: 24 })
          
          RecentTasksList()
        }
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Floating Action Button
      Row() {
        Image($r('app.media.ic_add')) // Placeholder for Add icon
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .position({ x: 'calc(100% - 40px)', y: 'calc(100% - 80px)' })
      .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      // Menu Icon
      Row() {
        Image($r('app.media.ic_menu')) // Placeholder for Menu icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .onClick(() => {})

      Flex().layoutWeight(1) // Spacer

      // Search Icon
      Row() {
        Image($r('app.media.ic_search')) // Placeholder for Search icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text("Hello, Alex")
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      
      Text("You have 5 incomplete tasks today.")
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
  }
}

@Component
struct CategorySelector {
  @Prop categories: string[];
  @Prop selectedIndex: number;
  @State localSelectedIndex: number = 0;
  
  aboutToAppear() {
    this.localSelectedIndex = this.selectedIndex;
  }

  build() {
    List({ space: 12 }) {
      ForEach(this.categories, (category: string, index: number) => {
        ListItem() {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(index === this.localSelectedIndex ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(index === this.localSelectedIndex ? '#212121' : '#F5F5F5')
            .borderRadius(50)
            .onClick(() => {
              this.localSelectedIndex = index;
            })
        }
      })
    }
    .layoutWeight(1)
    .width('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
  }
}

@Component
struct RecentTasksList {
  build() {
    Column() {
      Text("Recent Tasks")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      List({ space: 16 }) {
        ForEach(TASKS, (task: TaskItemData) => {
          ListItem() {
            TaskItemComponent(task)
          }
        })
        
        // Bottom spacer to allow scrolling past the last item
        ListItem() {
          Column().height(80)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
  }
}

@Component
struct TaskItemComponent {
  @Prop task: TaskItemData;

  build() {
    Column() {
      Row() {
        // Icon Box
        Row() {
          if (this.task.tag === "Personal") {
            Image($r('app.media.ic_face')) // Placeholder for Face icon
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          } else {
            Image($r('app.media.ic_date_range')) // Placeholder for DateRange icon
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
        }
        .width(48)
        .height(48)
        .borderRadius(14)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text(this.task.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.task.isChecked ? Color.Gray : Color.Black)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Row() {
            Text(this.task.time)
              .fontSize(12)
              .fontColor(Color.Gray)
            
            Text(this.task.tag)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.task.tagTextColor)
              .backgroundColor(this.task.tagColor)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)
              .margin({ left: 8 })
          }
          .margin({ top: 4 })
        }
        .layoutWeight(1)
        .margin({ left: 16 })

        // Checkbox Simulation
        Row() {
          if (this.task.isChecked) {
            Image($r('app.media.ic_check')) // Placeholder for Check icon
              .width(16)
              .height(16)
              .fillColor(Color.White)
          }
        }
        .width(24)
        .height(24)
        .borderRadius(4)
        .border({ width: 2, color: this.task.isChecked ? '#212121' : '#CCCCCC' })
        .backgroundColor(this.task.isChecked ? '#212121' : Color.Transparent)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FAFAFA')
      .borderRadius(20)
    }
  }
}