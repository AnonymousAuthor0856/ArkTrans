const NAME: string = '022GanttCharten'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Glassmorphic'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#38BDF8'
  static readonly secondary: string = '#6366F1'
  static readonly tertiary: string = '#A5B4FC'
  static readonly background: string = '#F1F5F9'
  static readonly surface: string = '#FFFFFF'
  static readonly surface80: string = '#CCFFFFFF'
  static readonly surface70: string = '#B3FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
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
struct RootScreen {
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
      Row() {
        Text('Project Timeline')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

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
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              Column({ space: AppSpacing.sm }) {
                Text(task.name)
                  .fontSize(AppTypography.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.primary)

                Stack({ alignContent: Alignment.Start }) {
                  Row()
                    .width('100%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppColors.surfaceVariant)

                  Row()
                    .width(`${task.progress * 100}%`)
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppColors.secondary)
                }
                .width('100%')
                .height(8)
              }
              .width('100%')
              .padding(AppSpacing.md)
              .borderRadius(AppShapes.large)
              .backgroundColor(AppColors.surface70)
              .shadow({
                radius: AppElevation.level1.radius,
                color: 'rgba(0, 0, 0, 0.12)',
                offsetX: 0,
                offsetY: AppElevation.level1.dy
              })
            }
            .width('100%')
          }, (task: Task) => task.name)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Button('Add Task')
          .width('100%')
          .height(52)
          .borderRadius(AppShapes.large)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surface80, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surface80, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}