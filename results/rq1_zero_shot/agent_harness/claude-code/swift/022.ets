// Color utility: hex color support
class HexColor {
  static fromHex(hex: number, alpha: number = 1.0): Color {
    const r = ((hex >> 16) & 0xFF) / 255
    const g = ((hex >> 8) & 0xFF) / 255
    const b = (hex & 0xFF) / 255
    return `rgba(${Math.round(r * 255)}, ${Math.round(g * 255)}, ${Math.round(b * 255)}, ${alpha})`
  }
}

// App design tokens
class AppTokens {
  static Colors = class {
    static readonly primary: ResourceColor = HexColor.fromHex(0xFF38BDF8)
    static readonly secondary: ResourceColor = HexColor.fromHex(0xFF6366F1)
    static readonly tertiary: ResourceColor = HexColor.fromHex(0xFFA5B4FC)
    static readonly background: ResourceColor = HexColor.fromHex(0xFFF1F5F9)
    static readonly surface: ResourceColor = HexColor.fromHex(0xFFFFFFFF)
    static readonly surfaceVariant: ResourceColor = HexColor.fromHex(0xFFE2E8F0)
    static readonly outline: ResourceColor = HexColor.fromHex(0xFFD1D5DB)
    static readonly success: ResourceColor = HexColor.fromHex(0xFF22C55E)
    static readonly warning: ResourceColor = HexColor.fromHex(0xFFF59E0B)
    static readonly error: ResourceColor = HexColor.fromHex(0xFFEF4444)
    static readonly onPrimary: ResourceColor = HexColor.fromHex(0xFFFFFFFF)
    static readonly onSecondary: ResourceColor = HexColor.fromHex(0xFF1E1E1E)
    static readonly onTertiary: ResourceColor = HexColor.fromHex(0xFF1E1E1E)
    static readonly onBackground: ResourceColor = HexColor.fromHex(0xFF1E1E1E)
    static readonly onSurface: ResourceColor = HexColor.fromHex(0xFF1E1E1E)
  }

  static TypographyTokens = class {
    static readonly display: { size: number; weight: number } = { size: 26, weight: FontWeight.Bold }
    static readonly title: { size: number; weight: number } = { size: 18, weight: FontWeight.Medium }
    static readonly body: { size: number; weight: number } = { size: 14, weight: FontWeight.Normal }
    static readonly label: { size: number; weight: number } = { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 16
  }

  static Spacing = class {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
  }

  static ElevationMapping = class {
    static readonly level1 = { radius: 4, dy: 2, opacity: 0.12 }
    static readonly level2 = { radius: 8, dy: 4, opacity: 0.16 }
  }
}

// Task data model
interface Task {
  id: string
  name: string
  progress: number
}

function createTask(name: string, progress: number): Task {
  return { id: Math.random().toString(36).substring(2, 11), name, progress }
}

// Custom switch toggle component
@Component
struct CustomSwitch {
  @Link isOn: boolean
  checkedThumbColor: ResourceColor = AppTokens.Colors.primary

  build() {
    Row() {
      Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
        // Track
        Capsule()
          .width(51)
          .height(31)
          .fill(this.isOn ? this.checkedThumbColor : AppTokens.Colors.surfaceVariant)
        // Thumb
        Circle({ width: 27, height: 27 })
          .fill(this.isOn ? Color.White : AppTokens.Colors.surface)
          .shadow({
            radius: 1,
            color: 'rgba(0, 0, 0, 0.2)',
            offsetX: 0,
            offsetY: 1
          })
          .margin(2)
      }
      .width(51)
      .height(31)
      .onClick(() => {
        this.isOn = !this.isOn
      })
    }
  }
}

// Custom linear progress indicator component
@Component
struct CustomLinearProgress {
  progress: number = 0
  trackColor: ResourceColor = AppTokens.Colors.surfaceVariant
  progressColor: ResourceColor = AppTokens.Colors.secondary
  height: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      RoundedRect({ width: '100%', height: this.height, radius: this.height / 2 })
        .fill(this.trackColor)
      // Progress bar
      RoundedRect({ width: `${this.progress * 100}%`, height: this.height, radius: this.height / 2 })
        .fill(this.progressColor)
    }
    .width('100%')
    .height(this.height)
  }
}

// Task item component
@Component
struct TaskItem {
  task: Task

  build() {
    Column() {
      Text(this.task.name)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')

      CustomLinearProgress({
        progress: this.task.progress,
        trackColor: AppTokens.Colors.surfaceVariant,
        progressColor: AppTokens.Colors.secondary,
        height: 8
      })
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(Color.White)
    .opacity(0.7)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// Root screen
@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    createTask('Design Phase', 0.8),
    createTask('Development', 0.5),
    createTask('Testing', 0.3),
    createTask('Documentation', 0.6),
    createTask('Deployment', 0.2)
  ]
  @State notificationsEnabled: boolean = true

  build() {
    Column() {
      // Top app bar
      Text('Project Timeline')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppTokens.Spacing.sm + AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .backgroundColor(AppTokens.Colors.background)

      // Main content with gradient background
      Column({ space: AppTokens.Spacing.lg }) {
        // Notification toggle row
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          CustomSwitch({
            isOn: $notificationsEnabled,
            checkedThumbColor: AppTokens.Colors.primary
          })
        }
        .width('100%')

        // Task list
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              TaskItem({ task: task })
            }, (task: Task) => task.id)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)

        // Add Task button
        Button('Add Task')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            console.info('Add Task button tapped!')
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .background(this.gradientBackground())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  gradientBackground() {
    Column()
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [
          ['rgba(255, 255, 255, 0.8)', 0.0],
          ['#F1F5F9', 0.5],
          ['rgba(255, 255, 255, 0.8)', 1.0]
        ],
        direction: GradientDirection.Bottom
      })
  }
}
