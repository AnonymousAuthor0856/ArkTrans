class AppTokens {
  static readonly Colors = class {
    static readonly primary: string = '#FF38BDF8'
    static readonly secondary: string = '#FF6366F1'
    static readonly tertiary: string = '#FFA5B4FC'
    static readonly background: string = '#FFF1F5F9'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFE2E8F0'
    static readonly outline: string = '#FFD1D5DB'
    static readonly success: string = '#FF22C55E'
    static readonly warning: string = '#FFF59E0B'
    static readonly error: string = '#FFEF4444'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FF1E1E1E'
    static readonly onTertiary: string = '#FF1E1E1E'
    static readonly onBackground: string = '#FF1E1E1E'
    static readonly onSurface: string = '#FF1E1E1E'
    static readonly surfaceGlass: string = '#B3FFFFFF'
  }
  static readonly Typography = class {
    static readonly display: Font = { size: 26, weight: FontWeight.Bold }
    static readonly title: Font = { size: 18, weight: FontWeight.Medium }
    static readonly body: Font = { size: 14, weight: FontWeight.Normal }
    static readonly label: Font = { size: 12, weight: FontWeight.Medium }
  }
  static readonly Radius = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 16
  }
  static readonly Spacing = class {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
  }
}

interface Task {
  name: string
  progress: number
}

@Entry
@Component
struct ProjectTimelineScreen {
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
      // Top Bar
      Row() {
        Text('Project Timeline')
          .font(AppTokens.Typography.display)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Notification Toggle Row
        Row() {
          Text('Notifications')
            .font(AppTokens.Typography.title)
            .fontColor(AppTokens.Colors.onSurface)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Task List
        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              this.TaskCard(task)
            }
          }, (task: Task) => task.name)
        }
        .width('100%')
        .layoutWeight(1)

        // Add Task Button
        Button('Add Task')
          .width('100%')
          .height(52)
          .borderRadius(AppTokens.Radius.large)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .font(AppTokens.Typography.title)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TaskCard(task: Task) {
    Column() {
      Text(task.name)
        .font(AppTokens.Typography.title)
        .fontColor(AppTokens.Colors.primary)

      Progress({ value: task.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.small)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .borderRadius(AppTokens.Radius.large)
    .backgroundColor(AppTokens.Colors.surfaceGlass)
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.12)',
      offsetY: 2
    })
  }
}
