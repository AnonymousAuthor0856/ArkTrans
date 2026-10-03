class KanbanColumn {
  title: string;
  tasks: string[];
  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

@Entry
@Component
struct KanbanBoardPage {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    new KanbanColumn("To Do", ["Write report", "Design mockup"]),
    new KanbanColumn("In Progress", ["Implement feature X", "Fix layout bug"]),
    new KanbanColumn("Done", ["Team sync", "Client feedback"])
  ];

  build() {
    Column() {
      // Top app bar
      Row() {
        Text("Kanban Board")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F3F4F6')

      // Main content
      Column({ space: 16 }) {
        // Notifications row
        Row() {
          Text("Notifications")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor('#2563EB')
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Horizontally scrolling kanban columns
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              Column({ space: 8 }) {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                  .width('100%')

                ForEach(col.tasks, (task: string) => {
                  Row() {
                    Text(task)
                      .fontSize(14)
                      .fontColor('#1E1E1E')
                  }
                  .backgroundColor('#E5E7EB')
                  .borderRadius(10)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                }, (task: string) => task)
              }
              .width(220)
              .height('100%')
              .padding(12)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#FFFFFF')
              .borderRadius(14)
            }, (col: KanbanColumn) => col.title)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        // Task completion
        Text("Task Completion")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .width('100%')

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E5E7EB')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}
