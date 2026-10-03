const PRIMARY: string = '#2563EB'
const BACKGROUND: string = '#F3F4F6'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#E5E7EB'
const TEXT: string = '#1E1E1E'

interface KanbanColumn {
  title: string
  tasks: string[]
}

@Entry
@Component
struct MainPage {
  @State private notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ]

  build() {
    Column({ space: 0 }) {
      Column() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      Column({ space: 16 }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT)

          Blank()
            .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(PRIMARY)
            .switchPointColor(SURFACE)
            .width(52)
            .height(32)
            .onChange((value: boolean) => {
              this.notificationsEnabled = value
            })
        }
        .width('100%')
        .height(48)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (column: KanbanColumn) => {
              this.KanbanCard(column)
            }, (column: KanbanColumn) => column.title)
          }
          .height('100%')
          .padding({ top: 4, bottom: 4 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT)
          .width('100%')

        Stack() {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(SURFACE_VARIANT)
            .borderRadius(4)

          Row()
            .width('65%')
            .height(8)
            .backgroundColor(PRIMARY)
            .borderRadius(4)
            .alignSelf(ItemAlign.Start)
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }

  @Builder
  KanbanCard(column: KanbanColumn) {
    Column({ space: 8 }) {
      Text(column.title)
        .fontSize(18)
        .fontColor(PRIMARY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      ForEach(column.tasks, (task: string) => {
        Button(task, { type: ButtonType.Normal })
          .fontSize(14)
          .fontColor(TEXT)
          .fontWeight(FontWeight.Regular)
          .height(44)
          .padding({ left: 16, right: 16 })
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(10)
          .onClick(() => {
          })
      }, (task: string) => task)

      Blank()
        .layoutWeight(1)
    }
    .width(220)
    .height('100%')
    .padding(12)
    .backgroundColor(SURFACE)
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}
