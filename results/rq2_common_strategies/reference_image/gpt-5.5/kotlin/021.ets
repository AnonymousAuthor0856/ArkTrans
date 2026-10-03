const NAME: string = '021KanbanBoarden'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static primary: ResourceColor = '#2563EB'
  static secondary: ResourceColor = '#60A5FA'
  static tertiary: ResourceColor = '#3B82F6'
  static background: ResourceColor = '#F3F4F6'
  static surface: ResourceColor = '#FFFFFF'
  static surfaceVariant: ResourceColor = '#E5E7EB'
  static outline: ResourceColor = '#D1D5DB'
  static success: ResourceColor = '#16A34A'
  static warning: ResourceColor = '#F59E0B'
  static error: ResourceColor = '#DC2626'
  static onPrimary: ResourceColor = '#FFFFFF'
  static onSecondary: ResourceColor = '#1E1E1E'
  static onTertiary: ResourceColor = '#FFFFFF'
  static onBackground: ResourceColor = '#1E1E1E'
  static onSurface: ResourceColor = '#1E1E1E'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
}

class AppRadius {
  static small: number = 6
  static medium: number = 10
  static large: number = 14
}

class KanbanColumn {
  title: string
  tasks: string[]

  constructor(title: string, tasks: string[]) {
    this.title = title
    this.tasks = tasks
  }
}

@Entry
@Component
struct RootScreen {
  @State private notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ]

  @Builder
  private TaskChip(task: string) {
    Text(task)
      .fontSize(14)
      .fontWeight(FontWeight.Regular)
      .fontColor(AppColors.onSurface)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Clip })
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppRadius.medium)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .margin({ top: 6, bottom: 6 })
  }

  @Builder
  private KanbanCard(column: KanbanColumn) {
    Column({ space: AppSpacing.sm }) {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })
        .width('100%')

      ForEach(column.tasks, (task: string) => {
        this.TaskChip(task)
      }, (task: string) => task)
    }
    .width(220)
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .switchPointColor(AppColors.onPrimary)
            .width(52)
            .height(32)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }
        .width('100%')
        .height(48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: AppSpacing.md }) {
            ForEach(this.columns, (column: KanbanColumn) => {
              this.KanbanCard(column)
            }, (column: KanbanColumn) => column.title)
          }
          .height('100%')
          .alignItems(VerticalAlign.Top)
        }
        .width('100%')
        .height('100%')
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(4)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}