@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = false

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header Section
        Column() {
          Row() {
            Blank()
            Text('Kanban Board')
              .fontColor('#1E1E1E')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
            Blank()
          }
          .padding({ left: 24, right: 24, top: 24, bottom: 16 })
          .width('100%')
          .backgroundColor('#FFFFFF')
        }

        // Main Content Section
        Column({ space: 24 }) {
          // Notifications Row
          Row() {
            Text('Notifications')
              .fontColor('#1E1E1E')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn
              })
              .width(50)
              .height(30)
              .backgroundColor(this.notificationsEnabled ? '#2563EB' : '#D1D5DB')
          }
          .width('100%')

          // Kanban Columns Scroll
          Scroll() {
            Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start }) {
              ForEach([
                { title: 'To Do', tasks: ['Task 1', 'Task 2'] },
                { title: 'In Progress', tasks: ['Task 3'] },
                { title: 'Done', tasks: ['Task 4', 'Task 5', 'Task 6'] }
              ], (item: KanbanItem) => {
                Column() {
                  Text(item.title)
                    .fontColor('#2563EB')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  
                  ForEach(item.tasks, (task: string) => {
                    AssistChipView({ task: task })
                  })
                  
                  Blank()
                }
                .width(280)
                .margin({ right: 16 })
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .height(200)

          // Task Completion Section
          Text('Task Completion')
            .fontColor('#1E1E1E')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#2563EB')
            .backgroundColor('#E5E7EB')
            .borderRadius(4)

        }
        .width('100%')
        .layoutWeight(1)
        .padding(24)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}

interface KanbanItem {
  title: string;
  tasks: string[];
}

@Component
struct AssistChipView {
  @Prop task: string = ''

  build() {
    Row() {
      Text(this.task)
        .fontColor('#1E1E1E')
        .fontSize(14)
    }
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor('#F0F4FF')
    .borderRadius(16)
    .margin({ bottom: 8 })
  }
}