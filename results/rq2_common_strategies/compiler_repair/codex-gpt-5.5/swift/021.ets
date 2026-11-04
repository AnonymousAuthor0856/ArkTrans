class KanbanColumnModel {
  title: string
  tasks: string[]

  constructor(title: string, tasks: string[]) {
    this.title = title
    this.tasks = tasks
  }
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true

  private cPrimary: string = '#2563EB'
  private cSecondary: string = '#60A5FA'
  private cTertiary: string = '#3B82F6'
  private cBackground: string = '#F3F4F6'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E5E7EB'
  private cOutline: string = '#D1D5DB'
  private cText: string = '#1E1E1E'
  private columns: KanbanColumnModel[] = [
    new KanbanColumnModel('To Do', ['Write report', 'Design mockup']),
    new KanbanColumnModel('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumnModel('Done', ['Team sync', 'Client feedback'])
  ]

  @Builder
  AssistChip(task: string) {
    Button(task)
      .height(36)
      .padding({ left: 16, right: 16 })
      .fontSize(14)
      .fontColor(this.cText)
      .backgroundColor(this.cSurfaceVariant)
      .borderRadius(10)
      .margin({ bottom: 8 })
  }

  @Builder
  CardView(column: KanbanColumnModel) {
    Column() {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cPrimary)
        .width('100%')
        .margin({ bottom: 8 })
      ForEach(column.tasks, (task: string) => {
        this.AssistChip(task)
      }, (task: string) => task)
      Blank()
    }
    .width(220)
    .height('100%')
    .padding(12)
    .backgroundColor(this.cSurface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill(this.cSurfaceVariant)
      Rect()
        .width('65%')
        .height(8)
        .radius(4)
        .fill(this.cPrimary)
    }
    .width('100%')
    .height(8)
  }

  build() {
    Column() {
      Row() {
        Blank()
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
        Blank()
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor(this.cBackground)

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((value: boolean) => {
              this.notificationsEnabled = value
            })
        }
        .width('100%')
        .margin({ bottom: 16 })

        Scroll() {
          Row() {
            ForEach(this.columns, (column: KanbanColumnModel) => {
              this.CardView(column)
            }, (column: KanbanColumnModel) => column.title)
          }
          .height(260)
          .padding({ top: 4, bottom: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(280)
        .margin({ bottom: 16 })

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .width('100%')
          .margin({ bottom: 12 })
        this.ProgressBar()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
