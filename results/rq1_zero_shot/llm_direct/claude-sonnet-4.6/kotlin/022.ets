import { LengthMetrics } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#38BDF8'
    export const secondary: ResourceColor = '#6366F1'
    export const tertiary: ResourceColor = '#A5B4FC'
    export const background: ResourceColor = '#F1F5F9'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E2E8F0'
    export const outline: ResourceColor = '#D1D5DB'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#F59E0B'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#1E1E1E'
    export const onTertiary: ResourceColor = '#1E1E1E'
    export const onBackground: ResourceColor = '#1E1E1E'
    export const onSurface: ResourceColor = '#1E1E1E'
  }

  export namespace Typography {
    export const displayFontSize: number = 26
    export const titleFontSize: number = 18
    export const bodyFontSize: number = 14
    export const labelFontSize: number = 12
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 16
  }
}

interface Task {
  name: string
  progress: number
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true
  @State tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ]

  @Builder
  TaskCard(task: Task) {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(task.name)
        .fontSize(AppTokens.Typography.titleFontSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)

      Progress({
        value: task.progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .style({ strokeWidth: new LengthMetrics(8) })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Project Timeline')
          .fontSize(AppTokens.Typography.displayFontSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.Typography.titleFontSize)
            .fontWeight(FontWeight.Medium)
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
        .scrollBar(BarState.Off)

        // Add Task Button
        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(AppTokens.Typography.titleFontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {})
      }
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CCFFFFFF', 0.0],
          ['#F1F5F9', 0.5],
          ['#CCFFFFFF', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}