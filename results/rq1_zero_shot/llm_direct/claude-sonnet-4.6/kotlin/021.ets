import { router } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#2563EB'
    export const secondary: string = '#60A5FA'
    export const tertiary: string = '#3B82F6'
    export const background: string = '#F3F4F6'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E5E7EB'
    export const outline: string = '#D1D5DB'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#DC2626'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#1E1E1E'
    export const onTertiary: string = '#FFFFFF'
    export const onBackground: string = '#1E1E1E'
    export const onSurface: string = '#1E1E1E'
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
  }
}

interface KanbanColumn {
  title: string
  tasks: string[]
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ]

  @Builder
  TaskChip(task: string) {
    Text(task)
      .fontSize(14)
      .fontColor(AppTokens.Colors.onSurface)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(10)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .width('100%')
  }

  @Builder
  KanbanCard(col: KanbanColumn) {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(col.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')

      ForEach(col.tasks, (task: string) => {
        this.TaskChip(task)
      }, (task: string) => task)
    }
    .width(220)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column({ space: AppTokens.Spacing.lg }) {
        // Notifications row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
            .selectedColor(AppTokens.Colors.primary)
            .width(50)
            .height(28)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Kanban columns horizontal scroll
        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              this.KanbanCard(col)
            }, (col: KanbanColumn) => col.title)
          }
          .alignItems(VerticalAlign.Top)
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .scrollBar(BarState.Off)

        // Task Completion label
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        // Progress bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4)

          // Fill
          Row()
            .width('65%')
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}