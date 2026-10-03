// Color utility: hex color support
class HexColor {
  static fromHex(hex: number, alpha: number = 1.0): string {
    const r = ((hex >> 16) & 0xFF) / 255
    const g = ((hex >> 8) & 0xFF) / 255
    const b = (hex & 0xFF) / 255
    return `rgba(${Math.round(r * 255)}, ${Math.round(g * 255)}, ${Math.round(b * 255)}, ${alpha})`
  }
}

// App design tokens - Colors
class AppColors {
  static readonly primary: string = HexColor.fromHex(0xFF38BDF8)
  static readonly secondary: string = HexColor.fromHex(0xFF6366F1)
  static readonly tertiary: string = HexColor.fromHex(0xFFA5B4FC)
  static readonly background: string = HexColor.fromHex(0xFFF1F5F9)
  static readonly surface: string = HexColor.fromHex(0xFFFFFFFF)
  static readonly surfaceVariant: string = HexColor.fromHex(0xFFE2E8F0)
  static readonly outline: string = HexColor.fromHex(0xFFD1D5DB)
  static readonly success: string = HexColor.fromHex(0xFF22C55E)
  static readonly warning: string = HexColor.fromHex(0xFFF59E0B)
  static readonly error: string = HexColor.fromHex(0xFFEF4444)
  static readonly onPrimary: string = HexColor.fromHex(0xFFFFFFFF)
  static readonly onSecondary: string = HexColor.fromHex(0xFF1E1E1E)
  static readonly onTertiary: string = HexColor.fromHex(0xFF1E1E1E)
  static readonly onBackground: string = HexColor.fromHex(0xFF1E1E1E)
  static readonly onSurface: string = HexColor.fromHex(0xFF1E1E1E)
}

// Typography token type
class TypographyToken {
  size: number = 0
  weight: number = FontWeight.Normal

  constructor(size: number, weight: number) {
    this.size = size
    this.weight = weight
  }
}

// App design tokens - Typography
class AppTypography {
  static readonly display: TypographyToken = new TypographyToken(26, FontWeight.Bold)
  static readonly title: TypographyToken = new TypographyToken(18, FontWeight.Medium)
  static readonly body: TypographyToken = new TypographyToken(14, FontWeight.Normal)
  static readonly label: TypographyToken = new TypographyToken(12, FontWeight.Medium)
}

// App design tokens - Shapes
class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

// App design tokens - Spacing
class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

// Elevation token type
class ElevationToken {
  radius: number = 0
  dy: number = 0
  opacity: number = 0

  constructor(radius: number, dy: number, opacity: number) {
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

// App design tokens - Elevation
class AppElevation {
  static readonly level1: ElevationToken = new ElevationToken(4, 2, 0.12)
  static readonly level2: ElevationToken = new ElevationToken(8, 4, 0.16)
}

// Task data model
class Task {
  id: string = ''
  name: string = ''
  progress: number = 0

  constructor(id: string, name: string, progress: number) {
    this.id = id
    this.name = name
    this.progress = progress
  }
}

function createTask(name: string, progress: number): Task {
  const id = Math.random().toString(36).substring(2, 11)
  return new Task(id, name, progress)
}

// Custom switch toggle component
@Component
struct CustomSwitch {
  @Link isOn: boolean
  checkedThumbColor: string = AppColors.primary

  build() {
    Row() {
      Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
        // Track (capsule shape)
        Row()
          .width(51)
          .height(31)
          .backgroundColor(this.isOn ? this.checkedThumbColor : AppColors.surfaceVariant)
          .borderRadius(15.5)
        // Thumb
        Circle({ width: 27, height: 27 })
          .fill(this.isOn ? Color.White : AppColors.surface)
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
  trackColor: string = AppColors.surfaceVariant
  progressColor: string = AppColors.secondary
  barHeight: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)
      // Progress bar
      Row()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .backgroundColor(this.progressColor)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// Task item component
@Component
struct TaskItem {
  task: Task = new Task('', '', 0)

  build() {
    Column() {
      Text(this.task.name)
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
        .fontColor(AppColors.primary)
        .width('100%')

      CustomLinearProgress({
        progress: this.task.progress,
        trackColor: AppColors.surfaceVariant,
        progressColor: AppColors.secondary,
        barHeight: 8
      })
        .width('100%')
        .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(Color.White)
    .opacity(0.7)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppElevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
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
        .fontSize(AppTypography.display.size)
        .fontWeight(AppTypography.display.weight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppSpacing.sm + AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      // Main content with gradient background
      Column({ space: AppSpacing.lg }) {
        // Notification toggle row
        Row() {
          Text('Notifications')
            .fontSize(AppTypography.title.size)
            .fontWeight(AppTypography.title.weight)
            .fontColor(AppColors.onSurface)

          Blank()

          CustomSwitch({
            isOn: $notificationsEnabled,
            checkedThumbColor: AppColors.primary
          })
        }
        .width('100%')

        // Task list
        Scroll() {
          Column({ space: AppSpacing.md }) {
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
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => {
            console.info('Add Task button tapped!')
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .background(this.gradientBackground())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
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
