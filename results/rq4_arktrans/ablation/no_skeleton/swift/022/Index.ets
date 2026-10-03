@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  // Data Model
  private tasks: Task[] = [
    { name: "Design Phase", progress: 0.8 },
    { name: "Development", progress: 0.5 },
    { name: "Testing", progress: 0.3 },
    { name: "Documentation", progress: 0.6 },
    { name: "Deployment", progress: 0.2 }
  ]

  build() {
    Column() {
      // Top Navigation Bar (CenterAlignedTopAppBar simulation)
      Text("Project Timeline")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 8, bottom: 16 })
        .backgroundColor('#F1F5F9')

      // Main Content Area
      Column({ space: 16 }) {
        // Notification Row
        Row() {
          Text("Notifications")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          Blank()

          // Custom Switch Simulation
          Row() {
            if (this.notificationsEnabled) {
              Circle().fill('#FFFFFF').width(27).height(27).shadow({ radius: 1, offsetY: 1, color: '#1F000000' })
            } else {
              Circle().fill('#FFFFFF').width(27).height(27).shadow({ radius: 1, offsetY: 1, color: '#1F000000' })
            }
          }
          .width(51)
          .height(31)
          .borderRadius(15.5)
          .justifyContent(this.notificationsEnabled ? FlexAlign.End : FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(this.notificationsEnabled ? '#38BDF8' : '#E2E8F0')
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled
          })
        }

        // Task List
        List({ space: 12 }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              Column({ space: 8 }) {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#38BDF8')
                  .alignSelf(ItemAlign.Start)

                // Custom Linear Progress Indicator
                Row() {
                  // Track
                  Row()
                    .width('100%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor('#E2E8F0')

                  // Progress Fill
                  Row()
                    .width(`${task.progress * 100}%`)
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor('#6366F1')
                }
                .width('100%')
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, offsetY: 2, color: '#1F000000' })
            }
          }, (task: Task) => task.name)
        }
        .layoutWeight(1)

        // Add Task Button
        Button("Add Task")
          .type(ButtonType.Capsule)
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#38BDF8')
      }
      .width('100%')
      .padding(16)
      .linearGradient({
        angle: 90,
        colors: [['#FFFFFF', 0.8], ['#F1F5F9', 0.5], ['#FFFFFF', 0.8]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}

interface Task {
  name: string;
  progress: number;
}