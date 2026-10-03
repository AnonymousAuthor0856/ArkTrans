// AppTokens - Design tokens
class AppColors {
  static readonly primary: Color = Color('#2563EB')
  static readonly secondary: Color = Color('#60A5FA')
  static readonly tertiary: Color = Color('#3B82F6')
  static readonly background: Color = Color('#F3F4F6')
  static readonly surface: Color = Color('#FFFFFF')
  static readonly surfaceVariant: Color = Color('#E5E7EB')
  static readonly outline: Color = Color('#D1D5DB')
  static readonly success: Color = Color('#16A34A')
  static readonly warning: Color = Color('#F59E0B')
  static readonly error: Color = Color('#DC2626')
  static readonly onPrimary: Color = Color('#FFFFFF')
  static readonly onSecondary: Color = Color('#1E1E1E')
  static readonly onTertiary: Color = Color('#FFFFFF')
  static readonly onBackground: Color = Color('#1E1E1E')
  static readonly onSurface: Color = Color('#1E1E1E')
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

class ElevationMapping {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  static readonly level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
}

// Data Models
interface KanbanColumn {
  title: string
  tasks: string[]
}

// Assist Chip Component
@Component
struct AssistChipView {
  task: string = ''

  build() {
    Text(this.task)
      .fontSize(14)
      .fontWeight(FontWeight.Regular)
      .fontColor(AppColors.onSurface)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
  }
}

// Card View Component (Kanban Column Card)
@Component
struct CardView {
  column: KanbanColumn = { title: '', tasks: [] }

  build() {
    Column() {
      Text(this.column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
    }
    .width(220)
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .alignItems(HorizontalAlign.Start)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: 'rgba(0, 0, 0, ' + ElevationMapping.level2.opacity + ')',
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ]

  build() {
    Stack() {
      // Full-screen background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column() {
        // Custom top bar (CenterAlignedTopAppBar equivalent)
        Row() {
          Text('Kanban Board')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: AppSpacing.md
        })

        // Main content area
        Column() {
          // Notifications row
          Row() {
            Text('Notifications')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .onChange((value: boolean) => {
                this.notificationsEnabled = value
              })
              .selectedColor(AppColors.primary)
          }
          .width('100%')

          // Horizontal scrollable Kanban columns
          Scroll() {
            Row() {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
              }, (col: KanbanColumn) => col.title)
            }
            .gap(AppSpacing.md)
            .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .layoutWeight(1)

          // Task Completion
          Text('Task Completion')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          // Linear progress indicator
          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(4)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
        .gap(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
