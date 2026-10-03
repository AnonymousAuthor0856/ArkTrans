const AppColors = {
  primary: '#38BDF8',
  secondary: '#6366F1',
  tertiary: '#A5B4FC',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#D1D5DB',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
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

interface Task {
  name: string
  progress: number
}

@Component
struct TaskView {
  private task: Task = { name: '', progress: 0 }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
      Progress({
        value: this.task.progress,
        total: 1,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true
  private tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ]

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
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

        List({ space: AppSpacing.md }) {
          ForEach(this.tasks, (task: Task, index: number) => {
            ListItem() {
              TaskView({ task: task })
            }
          }, (task: Task, index: number) => index.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Button('Add Task')
          .type(ButtonType.Normal)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
          .width('100%')
          .height(52)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#CCFFFFFF', 0], ['#F1F5F9', 0.5], ['#CCFFFFFF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}