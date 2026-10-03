interface KanbanColumn {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct MainPage {
  @State notificationsEnabled: boolean = true;

  columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Column() {
      Text('Kanban Board')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 38 })

      Row() {
        Text('Notifications')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')

        Toggle({
          type: ToggleType.Switch,
          isOn: this.notificationsEnabled
        })
          .width(104)
          .height(64)
          .selectedColor('#2563EB')
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 88 })
      .padding({ left: 32, right: 32 })

      Scroll() {
        Row({ space: 24 }) {
          ForEach(this.columns, (column: KanbanColumn) => {
            Column() {
              Text(column.title)
                .fontSize(36)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB')
                .width('100%')
                .margin({ bottom: 32 })

              ForEach(column.tasks, (task: string) => {
                Text(task)
                  .fontSize(28)
                  .fontColor('#1E1E1E')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .textAlign(TextAlign.Center)
                  .height(64)
                  .width('100%')
                  .padding({ left: 20, right: 20 })
                  .backgroundColor('#E5E7EB')
                  .border({
                    width: 2,
                    color: '#D1D5DB'
                  })
                  .borderRadius(18)
                  .margin({ bottom: 48 })
              })
            }
            .width(440)
            .height(960)
            .padding({ top: 28, left: 24, right: 24 })
            .backgroundColor('#FFFFFF')
            .borderRadius(28)
            .shadow({
              radius: 16,
              color: '#26000000',
              offsetX: 0,
              offsetY: 8
            })
          }, (column: KanbanColumn) => column.title)
        }
        .alignItems(VerticalAlign.Top)
      }
      .width('100%')
      .height(960)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .margin({ top: 48 })
      .padding({ left: 32, right: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
    .alignItems(HorizontalAlign.Center)
  }
}
