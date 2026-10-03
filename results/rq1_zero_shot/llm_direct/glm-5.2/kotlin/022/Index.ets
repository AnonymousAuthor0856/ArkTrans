// 022GanttCharten.ets
// Productivity - Glassmorphic Gantt Chart UI

// ============= TOKENS =============
class AppTokens {
  static readonly Colors = {
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
    onSurface: '#1E1E1E',
    surfaceAlpha70: '#B3FFFFFF',
    surfaceAlpha80: '#CCFFFFFF',
    backgroundGradientStart: '#CCFFFFFF',
    backgroundGradientEnd: '#CCFFFFFF'
  }

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Elevation = {
    level1: 2,
    level2: 4
  }
}

// ============= DATA =============
interface Task {
  name: string;
  progress: number;
}

// ============= COMPONENTS =============
@Component
struct TaskCard {
  @Prop task: Task;

  build() {
    Column() {
      Text(this.task.name)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.sm })

      Stack({ alignContent: Alignment.Start }) {
        // Track
        Column()
          .width('100%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)

        // Progress
        Column()
          .width(`${this.task.progress * 100}%`)
          .height(8)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(4)
      }
      .width('100%')
      .height(8)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceAlpha70)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level1 * 2,
      color: 'rgba(0,0,0,0.12)',
      offsetX: 0,
      offsetY: AppTokens.Elevation.level1
    })
  }
}

@Component
struct RootScreen {
  @State tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ]
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Project Timeline')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Scroll() {
        Column() {
          // Notifications Row
          Row() {
            Text('Notifications')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(AppTokens.Colors.primary)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Task List
          ForEach(this.tasks, (task: Task) => {
            TaskCard({ task: task })
              .margin({ bottom: AppTokens.Spacing.md })
          })

          // Add Task Button
          Button('Add Task')
            .width('100%')
            .height(52)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.backgroundGradientStart, 0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.backgroundGradientEnd, 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
struct GanttChartApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}