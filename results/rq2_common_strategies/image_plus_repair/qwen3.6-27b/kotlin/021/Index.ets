// entry/src/main/ets/pages/Index.ets

interface KanbanColumn {
  title: string;
  tasks: Array<string>;
}

@Entry
@Component
struct KanbanBoard {
  @State notificationsEnabled: boolean = true;

  // Data model for columns
  private kanbanColumns: Array<KanbanColumn> = [
    { title: "To Do", tasks: ["Write report", "Design mockup"] },
    { title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"] },
    { title: "Done", tasks: ["Team sync", "Client feedback"] }
  ];

  build() {
    Column() {
      // Top Bar / Title
      Text("Kanban Board")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 20 })

      // Notifications Row
      Row() {
        Text("Notifications")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')

        Blank()

        Toggle({
          type: ToggleType.Switch,
          isOn: this.notificationsEnabled
        })
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn;
          })
          .selectedColor('#2563EB')
          .width(50)
          .height(28)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 16 })

      // Kanban Columns (Horizontal Scroll)
      Scroll() {
        Row() {
          ForEach(this.kanbanColumns, (column: KanbanColumn) => {
            Column() {
              // Column Title
              Text(column.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB')
                .textAlign(TextAlign.Start)
                .width('100%')
                .margin({ bottom: 8 })

              // Tasks List
              Column() {
                ForEach(column.tasks, (task: string) => {
                  Text(task)
                    .fontSize(14)
                    .fontColor('#1E1E1E')
                    .textAlign(TextAlign.Center)
                    .backgroundColor('#E5E7EB')
                    .borderRadius(10)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .margin({ bottom: 8 })
                    .width('auto')
                })
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
            }
            .width(220)
            .height(400) // Fixed height to match card appearance
            .backgroundColor(Color.White)
            .borderRadius(14)
            .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
            .padding(12)
            .margin({ right: 12 })
          })
        }
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .margin({ left: 16, right: 16 })
      .layoutWeight(1)

      // Task Completion Section
      Column() {
        Text("Task Completion")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .margin({ bottom: 8 })

        // Progress Bar
        Row() {
          Row()
            .width('65%')
            .height(8)
            .backgroundColor('#2563EB')
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
        .backgroundColor('#E5E7EB')
        .borderRadius(4)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 20 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}