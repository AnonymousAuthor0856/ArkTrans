class ColorsToken {
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
}

class SpacingToken {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShapeToken {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class ElevationToken {
  static readonly level1Radius: number = 4
  static readonly level1Dy: number = 2
  static readonly level1Opacity: number = 0.12
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
  static readonly level2Opacity: number = 0.16
}

class TaskItem {
  id: string
  name: string
  progress: number

  constructor(name: string, progress: number) {
    this.id = name
    this.name = name
    this.progress = progress
  }
}

@Component
struct CustomSwitch {
  @Prop isOn: boolean = false
  onChanged: (value: boolean) => void = () => {
  }

  build() {
    Row() {
      if (this.isOn) {
        Blank()
      }

      Row()
        .width(27)
        .height(27)
        .borderRadius(14)
        .backgroundColor(this.isOn ? ColorsToken.primary : ColorsToken.surface)
        .shadow({
          radius: 1,
          color: 'rgba(0, 0, 0, 0.24)',
          offsetX: 0,
          offsetY: 1
        })

      if (!this.isOn) {
        Blank()
      }
    }
    .width(51)
    .height(31)
    .padding(2)
    .borderRadius(16)
    .backgroundColor(this.isOn ? ColorsToken.primary : ColorsToken.surfaceVariant)
    .onClick(() => {
      this.onChanged(!this.isOn)
    })
  }
}

@Component
struct LinearProgressBar {
  @Prop progress: number = 0

  progressWidth(): string {
    const value: number = Math.max(0, Math.min(this.progress, 1))
    return `${value * 100}%`
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(ColorsToken.surfaceVariant)

      Row()
        .width(this.progressWidth())
        .height(8)
        .borderRadius(4)
        .backgroundColor(ColorsToken.secondary)
    }
    .width('100%')
    .height(8)
  }
}

@Component
struct TaskCard {
  @Prop name: string = ''
  @Prop progress: number = 0

  build() {
    Column({ space: SpacingToken.sm }) {
      Text(this.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorsToken.primary)
        .width('100%')

      LinearProgressBar({ progress: this.progress })
        .width('100%')
    }
    .width('100%')
    .padding(SpacingToken.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('rgba(255, 255, 255, 0.70)')
    .borderRadius(ShapeToken.large)
    .shadow({
      radius: ElevationToken.level1Radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: ElevationToken.level1Dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  tasks: TaskItem[] = [
    new TaskItem('Design Phase', 0.8),
    new TaskItem('Development', 0.5),
    new TaskItem('Testing', 0.3),
    new TaskItem('Documentation', 0.6),
    new TaskItem('Deployment', 0.2)
  ]

  build() {
    Column() {
      Row() {
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(ColorsToken.onSurface)
      }
      .width('100%')
      .height(72)
      .padding({ top: SpacingToken.sm })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(ColorsToken.background)

      Column({ space: SpacingToken.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorsToken.onSurface)

          Blank()

          CustomSwitch({
            isOn: this.notificationsEnabled,
            onChanged: (value: boolean) => {
              this.notificationsEnabled = value
            }
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: SpacingToken.md }) {
            ForEach(this.tasks, (task: TaskItem) => {
              TaskCard({
                name: task.name,
                progress: task.progress
              })
            }, (task: TaskItem) => task.id)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Button() {
          Text('Add Task')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorsToken.onPrimary)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(52)
        .borderRadius(ShapeToken.large)
        .backgroundColor(ColorsToken.primary)
        .onClick(() => {
          console.info('Add Task button tapped!')
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SpacingToken.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(255, 255, 255, 0.80)', 0.0],
          [ColorsToken.background, 0.5],
          ['rgba(255, 255, 255, 0.80)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorsToken.background)
  }
}