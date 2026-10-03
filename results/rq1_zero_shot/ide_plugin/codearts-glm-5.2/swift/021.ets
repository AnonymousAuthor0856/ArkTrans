class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF3B82F6',
    background: '#FFF3F4F6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

class KanbanColumn {
  title: string
  tasks: string[]

  constructor(title: string, tasks: string[]) {
    this.title = title
    this.tasks = tasks
  }
}

@Component
struct AssistChip {
  @Prop task: string

  build() {
    Text(this.task)
      .fontSize(14)
      .fontColor(AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .borderRadius(10)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
  }
}

@Component
struct KanbanCard {
  @Prop title: string
  @Prop tasks: string[]

  build() {
    Column() {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)

      ForEach(this.tasks, (task: string) => {
        AssistChip({ task: task })
          .margin({ top: 8 })
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .borderRadius(14)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
  }
}

@Entry
@Component
struct KanbanBoard {
  @State notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ]

  build() {
    Column() {
      Stack() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .padding({ top: 16, bottom: 12 })
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: boolean) => {
              this.notificationsEnabled = value
            })
        }
        .width('100%')

        Scroll() {
          Row() {
            ForEach(this.columns, (col: KanbanColumn) => {
              KanbanCard({ title: col.title, tasks: col.tasks })
                .width(220)
                .margin({ right: 12 })
            })
          }
          .padding({ top: 4, bottom: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .margin({ top: 16 })

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 16 })

        Progress({ value: 0.65, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}