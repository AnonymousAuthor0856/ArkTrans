// TaskDashboardApp.ets

interface TaskItemData {
  title: string;
  time: string;
  tag: string;
  tagColor: ResourceColor;
  tagTextColor: ResourceColor;
  isChecked: boolean;
  icon: Resource;
}

@Entry
@Component
struct TaskDashboardScreen {
  private categories: string[] = ["All", "Work", "Personal", "Design"];
  
  private tasks: TaskItemData[] = [
    {
      title: "Team Meeting",
      time: "10:00 AM - 11:30 AM",
      tag: "Work",
      tagColor: "#E3F2FD",
      tagTextColor: "#1565C0",
      isChecked: true,
      icon: $r("app.media.icon") // Placeholder for calendar icon
    },
    {
      title: "Design Review",
      time: "02:00 PM - 03:00 PM",
      tag: "Design",
      tagColor: "#F3E5F5",
      tagTextColor: "#7B1FA2",
      isChecked: false,
      icon: $r("app.media.icon") // Placeholder for calendar icon
    },
    {
      title: "Grocery Shopping",
      time: "05:30 PM",
      tag: "Personal",
      tagColor: "#E8F5E9",
      tagTextColor: "#2E7D32",
      isChecked: false,
      icon: $r("app.media.icon") // Placeholder for face icon
    },
    {
      title: "Read Documentation",
      time: "08:00 PM",
      tag: "Study",
      tagColor: "#FFF3E0",
      tagTextColor: "#EF6C00",
      isChecked: false,
      icon: $r("app.media.icon") // Placeholder for calendar icon
    }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Background
      Column() {
        // Top Header
        TopHeader()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        // Content
        Scroll() {
          Column() {
            // Spacer
            Blank().height(16)

            // Welcome Section
            WelcomeSection()

            // Spacer
            Blank().height(32)

            // Category Selector
            CategorySelector({ categories: this.categories })

            // Spacer
            Blank().height(24)

            // Recent Tasks List
            RecentTasksList({ tasks: this.tasks })

            // Bottom padding for FAB
            Blank().height(80)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // FAB
      Button() {
        Image($r("app.media.icon")) // Placeholder for plus icon
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width(56)
      .height(56)
      .backgroundColor("#212121")
      .borderRadius(28)
      .shadow({ radius: 4, offsetY: 4, color: 'rgba(0,0,0,0.25)' })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.Top])
  }
}

// MARK: - Header
@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        Image($r("app.media.icon")) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor("#F5F5F5")
      .borderRadius(24)

      Blank()

      Button() {
        Image($r("app.media.icon")) // Placeholder for search icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor("#F5F5F5")
      .borderRadius(24)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Sections
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
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  private categories: string[] = [];

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          let isSelected: boolean = category === "All";
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(isSelected ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(isSelected ? "#212121" : "#F5F5F5")
            .borderRadius(14)
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecentTasksList {
  private tasks: TaskItemData[] = [];

  build() {
    Column({ space: 16 }) {
      Text("Recent Tasks")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      ForEach(this.tasks, (task: TaskItemData) => {
        TaskItem({ task: task })
      })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Components
@Component
struct TaskItem {
  @State private isChecked: boolean = false;
  private task: TaskItemData | null = null;

  aboutToAppear() {
    if (this.task) {
      this.isChecked = this.task.isChecked;
    }
  }

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Text("") // Simulating background box
          .width(48)
          .height(48)
          .backgroundColor(Color.White)
          .borderRadius(14)
        
        Image(this.task ? this.task.icon : $r("app.media.icon"))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }

      // Text Content
      Column({ space: 4 }) {
        Text(this.task ? this.task.title : "")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.Gray : Color.Black)
          .decoration({
            type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: Color.Gray
          })

        Row({ space: 8 }) {
          Text(this.task ? this.task.time : "")
            .fontSize(12)
            .fontColor(Color.Gray)

          Text(this.task ? this.task.tag : "")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.task ? this.task.tagTextColor : Color.Black)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.task ? this.task.tagColor : Color.White)
            .borderRadius(4)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Checkbox Button
      Button() {
        // Using a simple shape to represent the checkbox state visually
        // In a real app, you might use a Checkbox component or Toggle
        if (this.isChecked) {
          Image($r("app.media.icon")) // Placeholder for checkmark.square.fill
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        } else {
          Text("")
            .width(24)
            .height(24)
            .border({ width: 2, color: Color.Gray })
            .borderRadius(4)
        }
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.isChecked = !this.isChecked;
      })
    }
    .padding(20)
    .backgroundColor("#FAFAFA")
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}