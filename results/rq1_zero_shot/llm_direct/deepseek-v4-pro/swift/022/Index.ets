@Entry
@Component
struct RootScreen {
  @State tasks: Array<Task> = [
    new Task("Design Phase", 0.8),
    new Task("Development", 0.5),
    new Task("Testing", 0.3),
    new Task("Documentation", 0.6),
    new Task("Deployment", 0.2)
  ]
  @State notificationsEnabled: boolean = true

  build() {
    Column() {
      // Top bar
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 8, bottom: 16 })
        .backgroundColor('#F1F5F9')

      // Main content with gradient background
      Column({ space: 16 }) {
        // Notification row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: $$this.notificationsEnabled })
            .selectedColor('#38BDF8')
            .switchPointColor('#FFFFFF')
        }
        .width('100%')

        // Task list
        Scroll() {
          Column({ space: 12 }) {
            ForEach(this.tasks, (task: Task) => {
              Column({ space: 8 }) {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#38BDF8')
                Progress({ value: task.progress, total: 1.0, type: ProgressType.Linear })
                  .color('#6366F1')
                  .backgroundColor('#E2E8F0')
                  .height(8)
                  .width('100%')
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(12)
              .backgroundColor('#B3FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            }, (task: Task) => task.id)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .width('100%')

        // Add Task button
        Button('Add Task')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('100%')
          .height(52)
          .backgroundColor('#38BDF8')
          .borderRadius(16)
          .onClick(() => {
            console.info('Add Task button tapped!')
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#CCFFFFFF', 0], ['#F1F5F9', 0.5], ['#CCFFFFFF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}

class Task {
  id: string = util.generateRandomUUID()
  name: string
  progress: number

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
  }
}