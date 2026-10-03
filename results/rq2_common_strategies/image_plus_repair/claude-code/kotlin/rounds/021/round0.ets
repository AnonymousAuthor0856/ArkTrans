@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;

  private columns: { title: string, tasks: string[] }[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Column() {
      Text('Kanban Board')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 16, bottom: 16 })

      Row() {
        Text('Notifications')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')

        Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn;
          })
          .selectedColor('#2563EB')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      Scroll() {
        Row() {
          ForEach(this.columns, (col: { title: string, tasks: string[] }) => {
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
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .margin({ bottom: 8 })
              })
            }
            .width(220)
            .height('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .padding(12)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetY: 4 })
            .margin({ right: 12 })
          })
        }
        .height('100%')
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .layoutWeight(1)

      Text('Task Completion')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E1E1E')
        .margin({ top: 16, bottom: 8 })

      Progress({ value: 65, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color('#2563EB')
        .backgroundColor('#E5E7EB')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
    .padding(16)
  }
}
