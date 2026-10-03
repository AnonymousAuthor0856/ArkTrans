@Entry
@Component
struct ProjectTimeline {
  @State tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ]
  @State notificationsEnabled: boolean = true

  // Color constants
  private readonly COLOR_PRIMARY: string = '#38BDF8'
  private readonly COLOR_SECONDARY: string = '#6366F1'
  private readonly COLOR_BACKGROUND: string = '#F1F5F9'
  private readonly COLOR_SURFACE: string = '#FFFFFF'
  private readonly COLOR_SURFACE_VARIANT: string = '#E2E8F0'
  private readonly COLOR_ON_SURFACE: string = '#1E1E1E'
  private readonly COLOR_ON_PRIMARY: string = '#FFFFFF'

  build() {
    Column({ space: 0 }) {
      // Top bar
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.COLOR_ON_SURFACE)
        .width('100%')
        .padding({ top: 8, bottom: 16 })
        .backgroundColor(this.COLOR_BACKGROUND)
        .padding({ top: 4 })

      // Main content area
      Column({ space: 16 }) {
        // Notifications row
        Row({ space: 0 }) {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_ON_SURFACE)
            .layoutWeight(1)

          Button() {
            Text(this.notificationsEnabled ? 'ON' : 'OFF')
              .fontSize(12)
              .fontColor(this.notificationsEnabled ? this.COLOR_ON_PRIMARY : this.COLOR_ON_SURFACE)
          }
          .width(51).height(31)
          .backgroundColor(this.notificationsEnabled ? this.COLOR_PRIMARY : this.COLOR_SURFACE_VARIANT)
          .borderRadius(15)
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled
          })
        }

        // Task list wrapped in List
        List() {
          ListItem() {
            this.TaskCard(this.tasks[0])
          }
          ListItem() {
            this.TaskCard(this.tasks[1])
          }
          ListItem() {
            this.TaskCard(this.tasks[2])
          }
          ListItem() {
            this.TaskCard(this.tasks[3])
          }
          ListItem() {
            this.TaskCard(this.tasks[4])
          }
        }
        .width('100%')
        .layoutWeight(1)

        // Add Task button
        Button() {
          Text('Add Task')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_ON_PRIMARY)
        }
        .width('100%')
        .height(52)
        .backgroundColor(this.COLOR_PRIMARY)
        .borderRadius(16)
        .onClick(() => {
          // Add task logic
        })
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.COLOR_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
    .padding(0)
  }

  @Builder TaskCard(task: Task) {
    Column({ space: 8 }) {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.COLOR_PRIMARY)

      Progress({ value: task.progress, total: 1, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(this.COLOR_SECONDARY)
        .backgroundColor(this.COLOR_SURFACE_VARIANT)
    }
    .padding(12)
    .width('100%')
    .backgroundColor(this.COLOR_SURFACE)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }
}

interface Task {
  name: string
  progress: number
}