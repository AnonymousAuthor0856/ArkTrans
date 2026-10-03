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
  @State private notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  @Builder
  AssistChip(task: string) {
    Button(task)
      .fontSize(14)
      .fontColor('#1E1E1E')
      .backgroundColor('#E5E7EB')
      .height(36)
      .padding({ left: 16, right: 16 })
      .borderRadius(10)
      .margin({ top: 8 })
  }

  @Builder
  CardView(column: KanbanColumn) {
    Column() {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2563EB')
      ForEach(column.tasks, (task: string) => {
        this.AssistChip(task)
      }, (task: string) => task)
      Blank()
    }
    .width(220)
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
    .margin({ right: 12 })
  }

  build() {
    Column() {
      Row() {
        Blank()
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
        Blank()
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor('#F3F4F6')

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor('#2563EB')
            .onChange((value: boolean) => {
              this.notificationsEnabled = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row() {
            ForEach(this.columns, (col: KanbanColumn) => {
              this.CardView(col)
            }, (col: KanbanColumn) => col.title)
          }
          .height('100%')
          .padding({ top: 4, bottom: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 16 })

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .width('100%')
          .margin({ top: 16 })

        Progress({ value: 0.65, total: 1, type: ProgressType.Linear })
          .color('#2563EB')
          .backgroundColor('#E5E7EB')
          .width('100%')
          .height(8)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}
