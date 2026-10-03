@Entry
@Component
struct KanbanBoardPage {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 16, bottom: 16 })

      Column() {
        // Notifications row
        Row() {
          Text('Notifications')
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
        .margin({ bottom: 16 })

        // Kanban columns horizontal scroll
        List() {
          ForEach(this.columns, (col: KanbanColumn) => {
            ListItem() {
              Column() {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                  .margin({ bottom: 8 })

                ForEach(col.tasks, (task: string) => {
                  Text(task)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#1E1E1E')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(10)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ bottom: 8 })
                })
              }
              .width(220)
              .height('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(14)
              .shadow({
                radius: 8,
                color: 'rgba(0,0,0,0.16)',
                offsetY: 4
              })
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .width('100%')
        .layoutWeight(1)
        .margin({ bottom: 16 })

        // Task completion
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .margin({ bottom: 8 })

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E5E7EB')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}

interface KanbanColumn {
  title: string;
  tasks: string[];
}
