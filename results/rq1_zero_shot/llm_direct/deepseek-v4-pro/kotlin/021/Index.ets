@Entry
@Component
struct KanbanBoardApp {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    { title: "To Do", tasks: ["Write report", "Design mockup"] },
    { title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"] },
    { title: "Done", tasks: ["Team sync", "Client feedback"] }
  ];

  // AppTokens
  private primaryColor: string = '#2563EB';
  private secondaryColor: string = '#60A5FA';
  private tertiaryColor: string = '#3B82F6';
  private backgroundColor: string = '#F3F4F6';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#E5E7EB';
  private outlineColor: string = '#D1D5DB';
  private onSurfaceColor: string = '#1E1E1E';
  private onPrimaryColor: string = '#FFFFFF';

  @Builder
  TopBar() {
    Row() {
      Text('Kanban Board')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(this.backgroundColor)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NotificationRow() {
    Row() {
      Text('Notifications')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
        .selectedColor(this.primaryColor)
        .onChange((isOn: boolean) => {
          this.notificationsEnabled = isOn;
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  KanbanCard(column: KanbanColumn) {
    Column({ space: 8 }) {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.primaryColor)
      ForEach(column.tasks, (task: string) => {
        Row() {
          Text(task)
            .fontSize(14)
            .fontColor(this.onSurfaceColor)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        }
        .backgroundColor(this.surfaceVariantColor)
        .borderRadius(10)
        .width('100%')
      }, (task: string) => task)
    }
    .width('100%')
    .padding(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  KanbanBoardRow() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.columns, (column: KanbanColumn) => {
          Column() {
            this.KanbanCard(column)
          }
          .width(220)
          .height(280)
          .backgroundColor(this.surfaceColor)
          .borderRadius(14)
          .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.16)', offsetY: 4 })
          .padding(0)
        }, (column: KanbanColumn) => column.title)
      }
      .padding({ left: 4, right: 4 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(300)
  }

  @Builder
  ProgressSection() {
    Column({ space: 8 }) {
      Text('Task Completion')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)
      Progress({ value: 65, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(this.primaryColor)
        .backgroundColor(this.surfaceVariantColor)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.TopBar()
      Column({ space: 16 }) {
        this.NotificationRow()
        this.KanbanBoardRow()
        this.ProgressSection()
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor(this.backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

interface KanbanColumn {
  title: string;
  tasks: string[];
}