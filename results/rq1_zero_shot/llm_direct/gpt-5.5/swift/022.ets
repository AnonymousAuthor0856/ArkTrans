class AppTokens {
  static Colors = class {
    static readonly primary: string = '#38BDF8'
    static readonly secondary: string = '#6366F1'
    static readonly tertiary: string = '#A5B4FC'
    static readonly background: string = '#F1F5F9'
    static readonly surface: string = '#FFFFFF'
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

    static readonly surface70: string = 'rgba(255, 255, 255, 0.7)'
    static readonly surface80: string = 'rgba(255, 255, 255, 0.8)'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 26
    static readonly titleSize: number = 18
    static readonly bodySize: number = 14
    static readonly labelSize: number = 12
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
    static readonly level1: ShadowOptions = {
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    }

    static readonly level2: ShadowOptions = {
      radius: 8,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: 4
    }
  }
}

class TaskModel {
  id: number
  name: string
  progress: number

  constructor(id: number, name: string, progress: number) {
    this.id = id
    this.name = name
    this.progress = progress
  }
}

@Component
struct CustomSwitch {
  @Link isOn: boolean
  checkedThumbColor: ResourceColor = AppTokens.Colors.primary

  build() {
    Row() {
      Circle()
        .width(27)
        .height(27)
        .fill(this.isOn ? this.checkedThumbColor : AppTokens.Colors.surface)
        .shadow({
          radius: 1,
          color: 'rgba(0, 0, 0, 0.25)',
          offsetX: 0,
          offsetY: 1
        })
    }
    .width(51)
    .height(31)
    .padding(2)
    .borderRadius(15.5)
    .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .justifyContent(this.isOn ? FlexAlign.End : FlexAlign.Start)
    .onClick(() => {
      this.isOn = !this.isOn
    })
  }
}

@Component
struct CustomLinearProgress {
  progress: number = 0
  trackColor: ResourceColor = AppTokens.Colors.surfaceVariant
  progressColor: ResourceColor = AppTokens.Colors.secondary
  heightValue: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.heightValue)
        .borderRadius(this.heightValue / 2)
        .backgroundColor(this.trackColor)

      Row()
        .width(`${Math.max(0, Math.min(this.progress, 1)) * 100}%`)
        .height(this.heightValue)
        .borderRadius(this.heightValue / 2)
        .backgroundColor(this.progressColor)
    }
    .width('100%')
    .height(this.heightValue)
  }
}

@Entry
@Component
struct RootScreen {
  @State private tasks: TaskModel[] = [
    new TaskModel(1, 'Design Phase', 0.8),
    new TaskModel(2, 'Development', 0.5),
    new TaskModel(3, 'Testing', 0.3),
    new TaskModel(4, 'Documentation', 0.6),
    new TaskModel(5, 'Deployment', 0.2)
  ]

  @State private notificationsEnabled: boolean = true

  build() {
    Column({ space: 0 }) {
      Text('Project Timeline')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppTokens.Spacing.lg + AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.lg
        })
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          CustomSwitch({
            isOn: $notificationsEnabled,
            checkedThumbColor: AppTokens.Colors.primary
          })
        }
        .width('100%')

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: TaskModel) => {
              Column({ space: AppTokens.Spacing.sm }) {
                Text(task.name)
                  .fontSize(AppTokens.TypographyTokens.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)
                  .width('100%')

                CustomLinearProgress({
                  progress: task.progress,
                  trackColor: AppTokens.Colors.surfaceVariant,
                  progressColor: AppTokens.Colors.secondary,
                  heightValue: 8
                })
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface70)
              .borderRadius(AppTokens.Shapes.large)
              .shadow(AppTokens.ElevationMapping.level1)
            }, (task: TaskModel) => task.id.toString())
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')

        Button() {
          Text('Add Task')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }
        .type(ButtonType.Normal)
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
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surface80, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface80, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}