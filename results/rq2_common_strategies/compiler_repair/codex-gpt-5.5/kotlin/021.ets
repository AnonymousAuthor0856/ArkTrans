class KanbanColumnData {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

class KanbanColors {
  static primary: string = '#2563EB';
  static secondary: string = '#60A5FA';
  static background: string = '#F3F4F6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumnData[] = [
    new KanbanColumnData('To Do', ['Write report', 'Design mockup']),
    new KanbanColumnData('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumnData('Done', ['Team sync', 'Client feedback'])
  ];

  @Builder
  TaskChip(task: string) {
    Text(task)
      .fontSize(14)
      .fontColor(KanbanColors.onSurface)
      .lineHeight(20)
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(KanbanColors.surfaceVariant)
      .borderRadius(10)
  }

  @Builder
  KanbanColumn(column: KanbanColumnData) {
    Column() {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(KanbanColors.primary)
        .lineHeight(24)
        .width('100%')

      ForEach(column.tasks, (task: string) => {
        this.TaskChip(task)
      }, (task: string) => task)
    }
    .width(220)
    .height('100%')
    .padding(12)
    .backgroundColor(KanbanColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Kanban Board')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(KanbanColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(KanbanColors.onSurface)
            .lineHeight(24)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(KanbanColors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (column: KanbanColumnData) => {
              this.KanbanColumn(column)
            }, (column: KanbanColumnData) => column.title)
          }
          .height('100%')
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 16 })

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(KanbanColors.onSurface)
          .lineHeight(24)
          .margin({ top: 16 })

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(KanbanColors.primary)
          .backgroundColor(KanbanColors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(KanbanColors.background)
  }
}
