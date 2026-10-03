const AppColors = {
  primary: '#2563EB',
  secondary: '#60A5FA',
  tertiary: '#3B82F6',
  background: '#F3F4F6',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#FFFFFF',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

interface KanbanColumn {
  title: string
  tasks: string[]
}

@Component
struct KanbanColumnView {
  private column: KanbanColumn = { title: '', tasks: [] }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
      ForEach(this.column.tasks, (task: string, index: number) => {
        Text(task)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(10)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }, (task: string, index: number) => index.toString())
    }
    .width(220)
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true
  private columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ]

  build() {
    Column() {
      Text('Kanban Board')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: AppSpacing.md }) {
            ForEach(this.columns, (col: KanbanColumn, index: number) => {
              KanbanColumnView({ column: col })
            }, (col: KanbanColumn, index: number) => index.toString())
          }
        }
        .scrollDirection(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Progress({
          value: 0.65,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}