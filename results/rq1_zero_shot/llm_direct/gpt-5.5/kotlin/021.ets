const NAME: string = '021KanbanBoarden'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class KanbanColumn {
  title: string
  tasks: string[]

  constructor(title: string, tasks: string[]) {
    this.title = title
    this.tasks = tasks
  }
}

class AppTokens {
  static Colors = class {
    static primary: string = '#2563EB'
    static secondary: string = '#60A5FA'
    static tertiary: string = '#3B82F6'
    static background: string = '#F3F4F6'
    static surface: string = '#FFFFFF'
    static surfaceVariant: string = '#E5E7EB'
    static outline: string = '#D1D5DB'
    static success: string = '#16A34A'
    static warning: string = '#F59E0B'
    static error: string = '#DC2626'
    static onPrimary: string = '#FFFFFF'
    static onSecondary: string = '#1E1E1E'
    static onTertiary: string = '#FFFFFF'
    static onBackground: string = '#1E1E1E'
    static onSurface: string = '#1E1E1E'
  }

  static TypographyTokens = class {
    static displaySize: number = 28
    static titleSize: number = 18
    static bodySize: number = 14
    static labelSize: number = 12
  }

  static Shapes = class {
    static small: number = 6
    static medium: number = 10
    static large: number = 14
  }

  static Spacing = class {
    static xs: number = 4
    static sm: number = 8
    static md: number = 12
    static lg: number = 16
    static xl: number = 24
  }

  static ElevationMapping = class {
    static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
    static level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
  }
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ]

  build() {
    Column() {
      Row() {
        Text('Kanban Board')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Switch({ value: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: boolean) => {
              this.notificationsEnabled = value
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              Column({ space: AppTokens.Spacing.sm }) {
                Text(col.title)
                  .fontSize(AppTokens.TypographyTokens.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)
                  .width('100%')

                ForEach(col.tasks, (task: string) => {
                  Text(task)
                    .fontSize(AppTokens.TypographyTokens.bodySize)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(AppTokens.Colors.onSurface)
                    .padding({
                      left: AppTokens.Spacing.md,
                      right: AppTokens.Spacing.md,
                      top: AppTokens.Spacing.sm,
                      bottom: AppTokens.Spacing.sm
                    })
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.medium)
                }, (task: string) => task)
              }
              .width(220)
              .height('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level2.radius,
                color: '#29000000',
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level2.dy
              })
            }, (col: KanbanColumn) => col.title)
          }
          .height('100%')
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        Text('Task Completion')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Progress({
          value: 65,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}