@Entry
@Component
struct KanbanBoard {
  @State notificationsEnabled: boolean = true

  private readonly COLOR_PRIMARY: string = '#2563EB'
  private readonly COLOR_BACKGROUND: string = '#F3F4F6'
  private readonly COLOR_SURFACE: string = '#FFFFFF'
  private readonly COLOR_SURFACE_VARIANT: string = '#E5E7EB'
  private readonly COLOR_ON_SURFACE: string = '#1E1E1E'
  private readonly COLOR_ON_PRIMARY: string = '#FFFFFF'

  build() {
    List() {
      // Top bar
      ListItem() {
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            Blank().layoutWeight(1)
            Text('Kanban Board')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.COLOR_ON_SURFACE)
            Blank().layoutWeight(1)
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 12 })
        }
        .width('100%')
        .backgroundColor(this.COLOR_BACKGROUND)
      }

      // Notifications row
      ListItem() {
        Row({ space: 0 }) {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_ON_SURFACE)
            .layoutWeight(1)

          Button() {
            Text(this.notificationsEnabled ? 'ON' : 'OFF')
              .fontSize(14)
              .fontColor(this.notificationsEnabled ? this.COLOR_ON_PRIMARY : this.COLOR_ON_SURFACE)
          }
          .width(50).height(30)
          .backgroundColor(this.notificationsEnabled ? this.COLOR_PRIMARY : this.COLOR_SURFACE_VARIANT)
          .borderRadius(15)
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }

      // Kanban columns grid
      ListItem() {
        Grid() {
          GridItem() {
            this.ColumnCard('To Do', ['Write report', 'Design mockup'])
          }
          GridItem() {
            this.ColumnCard('In Progress', ['Implement feature X', 'Fix layout bug'])
          }
          GridItem() {
            this.ColumnCard('Done', ['Team sync', 'Client feedback'])
          }
        }
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(12)
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }

      // Task Completion label
      ListItem() {
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLOR_ON_SURFACE)
          .padding({ left: 16, right: 16, top: 8, bottom: 4 })
      }

      // Progress bar
      ListItem() {
        Progress({ value: 0.65, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(this.COLOR_PRIMARY)
          .backgroundColor(this.COLOR_SURFACE_VARIANT)
          .padding({ left: 16, right: 16 })
      }

      // Bottom spacer - wrapped in Column to satisfy Blank nesting rules
      ListItem() {
        Column() {
          Blank().height(16)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
    .padding(0)
  }

  @Builder ColumnCard(title: string, tasks: string[]) {
    Column({ space: 8 }) {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.COLOR_PRIMARY)

      if (tasks.length > 0) {
        Button() {
          Text(tasks[0])
            .fontSize(14)
            .fontColor(this.COLOR_ON_SURFACE)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(this.COLOR_SURFACE_VARIANT)
        .borderRadius(10)
        .onClick(() => {})
      }

      if (tasks.length > 1) {
        Button() {
          Text(tasks[1])
            .fontSize(14)
            .fontColor(this.COLOR_ON_SURFACE)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(this.COLOR_SURFACE_VARIANT)
        .borderRadius(10)
        .onClick(() => {})
      }

      Blank().layoutWeight(1)
    }
    .padding(12)
    .backgroundColor(this.COLOR_SURFACE)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#2A000000', offsetY: 4 })
    .width('100%')
    .height(200)
  }
}