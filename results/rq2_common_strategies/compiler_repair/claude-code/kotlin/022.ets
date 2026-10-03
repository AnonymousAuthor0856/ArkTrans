class Colors {
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

class TypographyTokens {
  static readonly displaySize: number = 26
  static readonly displayWeight: number = FontWeight.Bold
  static readonly titleSize: number = 18
  static readonly titleWeight: number = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: number = FontWeight.Normal
  static readonly labelSize: number = 12
  static readonly labelWeight: number = FontWeight.Medium
}

class RadiusTokens {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class SpacingTokens {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
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
      Row() {
        Text('Project Timeline')
          .fontSize(TypographyTokens.displaySize)
          .fontWeight(TypographyTokens.displayWeight)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Column({ space: SpacingTokens.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.onSurface)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(Colors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        List({ space: SpacingTokens.md }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              this.TaskCard(task)
            }
          }, (task: Task) => task.name)
        }
        .width('100%')
        .layoutWeight(1)

        Button('Add Task')
          .width('100%')
          .height(52)
          .borderRadius(RadiusTokens.large)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(TypographyTokens.titleWeight)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SpacingTokens.lg)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  TaskCard(task: Task) {
    Column({ space: SpacingTokens.sm }) {
      Text(task.name)
        .fontSize(TypographyTokens.titleSize)
        .fontWeight(TypographyTokens.titleWeight)
        .fontColor(Colors.primary)

      Progress({ value: task.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(Colors.secondary)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(RadiusTokens.small)
    }
    .width('100%')
    .padding(SpacingTokens.md)
    .borderRadius(RadiusTokens.large)
    .backgroundColor(Colors.surfaceGlass)
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.12)',
      offsetY: 2
    })
  }
}
