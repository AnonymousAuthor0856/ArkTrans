// 022GanttCharten - Productivity - Glassmorphic
// ArkTS UI Conversion

class Task {
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.name = name;
    this.progress = progress;
  }
}

@Entry
@Component
struct RootScreen {
  private tasks: Task[] = [
    new Task("Design Phase", 0.8),
    new Task("Development", 0.5),
    new Task("Testing", 0.3),
    new Task("Documentation", 0.6),
    new Task("Deployment", 0.2)
  ];

  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Project Timeline")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor("#1E1E1E")
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor("#F1F5F9")

      // Content Area
      Scroll() {
        Column() {
          // Notifications Row
          Row() {
            Text("Notifications")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor("#1E1E1E")

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor("#38BDF8")
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 16 })

          // Task List
          ForEach(this.tasks, (task: Task) => {
            Column() {
              Text(task.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor("#38BDF8")
                .margin({ bottom: 8 })

              // Progress Bar Container
              Row() {
                // Track
                Column()
                  .width('100%')
                  .height(8)
                  .backgroundColor("#E2E8F0")
                  .borderRadius(4)

                // Progress
                Column()
                  .width((task.progress * 100).toString() + '%')
                  .height(8)
                  .backgroundColor("#6366F1")
                  .borderRadius(4)
                  .position({ x: 0, y: 0 })
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .padding(12)
            .margin({ bottom: 12 })
            .backgroundColor('rgba(255, 255, 255, 0.7)')
            .borderRadius(16)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 })
          })

          // Add Task Button
          Button("Add Task")
            .width('100%')
            .height(52)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor("#FFFFFF")
            .backgroundColor("#38BDF8")
            .borderRadius(16)
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    // Glassmorphic Background Gradient
    .linearGradient({
      angle: 180,
      colors: [['rgba(255, 255, 255, 0.8)', 0.0], ['#F1F5F9', 0.5], ['rgba(255, 255, 255, 0.8)', 1.0]]
    })
  }
}