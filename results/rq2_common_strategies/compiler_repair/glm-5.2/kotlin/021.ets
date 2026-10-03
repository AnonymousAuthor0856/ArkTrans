// 021KanbanBoarden
// Productivity
// Modern Blue
// en
// 720x1280

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
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F3F4F6')

      // Content Area
      Column() {
        // Notifications Row
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

        // Kanban Columns (Horizontal Scroll)
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              Column() {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                  .margin({ bottom: 8 })

                ForEach(col.tasks, (task: string) => {
                  Text(task)
                    .fontSize(14)
                    .fontColor('#1E1E1E')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(10)
                    .padding({ top: 6, bottom: 6, left: 12, right: 12 })
                    .margin({ bottom: 8 })
                })
              }
              .width(220)
              .height('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(14)
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 4 })
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .layoutWeight(1)
        .margin({ bottom: 16 })

        // Task Completion
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .margin({ bottom: 8 })

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .color('#2563EB')
          .backgroundColor('#E5E7EB')
          .width('100%')
          .height(8)
          .borderRadius(4)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
  }
}