class AppTokens {
  static readonly Colors = {
    primary: '#FF38BDF8',
    secondary: '#FF6366F1',
    tertiary: '#FFA5B4FC',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
    surface70: '#B3FFFFFF',
    surface80: '#CCFFFFFF'
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
    large: 16
  }
}

class Task {
  name: string
  progress: number

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
  }
}

@Entry
@Component
struct ProjectTimeline {
  @State notificationsEnabled: boolean = true

  private tasks: Task[] = [
    new Task('Design Phase', 0.8),
    new Task('Development', 0.5),
    new Task('Testing', 0.3),
    new Task('Documentation', 0.6),
    new Task('Deployment', 0.2)
  ]

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: 24, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

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
          Column() {
            ForEach(this.tasks, (task: Task) => {
              Column() {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)

                Progress({ value: task.progress, total: 1, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color(AppTokens.Colors.secondary)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .margin({ top: 8 })
              }
              .width('100%')
              .padding(12)
              .borderRadius(16)
              .backgroundColor(AppTokens.Colors.surface70)
              .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
              .margin({ bottom: 12 })
            })
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .margin({ top: 16 })

        Button('Add Task') {
        }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(52)
          .borderRadius(16)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ top: 16 })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}