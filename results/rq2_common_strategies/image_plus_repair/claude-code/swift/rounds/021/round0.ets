// AppTokens
class AppTokens {
  static Colors = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping = {
    level1: { radius: 4, y: 2, opacity: 0.12 },
    level2: { radius: 8, y: 4, opacity: 0.16 }
  };
}

interface KanbanColumn {
  id: string;
  title: string;
  tasks: string[];
}

// AssistChipView
@Component
struct AssistChipView {
  task: string = '';

  build() {
    Button(this.task)
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .onClick(() => {
        // empty onClick
      })
  }
}

// CardView
@Component
struct CardView {
  column: KanbanColumn;

  build() {
    Column() {
      Text(this.column.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
          .margin({ bottom: AppTokens.Spacing.sm })
      }, (task: string) => task)

      Blank()
    }
    .width(220)
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    { id: '1', title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { id: '2', title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { id: '3', title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Stack() {
      Column() {
        // Top bar - "Kanban Board" title
        Row() {
          Text('Kanban Board')
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

        // Main content area
        Column() {
          // Notifications row
          Row() {
            Text('Notifications')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Toggle({ isOn: this.notificationsEnabled })
              .type(ToggleType.Switch)
              .selectedColor(AppTokens.Colors.primary)
              .onChange((value: boolean) => {
                this.notificationsEnabled = value;
              })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Kanban columns horizontal scroll
          List() {
            ForEach(this.columns, (col: KanbanColumn) => {
              ListItem() {
                CardView({ column: col })
              }
            }, (col: KanbanColumn) => col.id)
          }
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
          .margin({ bottom: AppTokens.Spacing.lg })
          .layoutWeight(1)

          // Task Completion
          Text('Task Completion')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          // Linear progress indicator
          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .height(8)
            .borderRadius(4)
            .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
