// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
    onSurface: '#1E1E1E',
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  };
}

// Data Model
export class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

// AssistChipView Component
@Component
export struct AssistChipView {
  private task: string = '';

  build() {
    Button(this.task, { type: ButtonType.Normal })
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .stateStyles({
        pressed: {
          .backgroundColor: AppTokens.Colors.outline
        }
      });
  }
}

// CardView Component
@Component
export struct CardView {
  private column: KanbanColumn = new KanbanColumn('', []);

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.primary);

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task });
      }, (task: string) => task);

      // Spacer to push content to top, simulating fillMaxHeight
      Blank();
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    });
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  private columns: KanbanColumn[] = [
    new KanbanColumn("To Do", ["Write report", "Design mockup"]),
    new KanbanColumn("In Progress", ["Implement feature X", "Fix layout bug"]),
    new KanbanColumn("Done", ["Team sync", "Client feedback"])
  ];

  @State private notificationsEnabled: boolean = true;
  private progressValue: number = 0.65;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Full screen background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Main Content VStack
      Column() {
        // Custom Top App Bar
        Row() {
          Text("Kanban Board")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.background);

        // Main Content Area
        Column({ space: AppTokens.Spacing.lg }) {
          // Notifications Row
          Row() {
            Text("Notifications")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSurface);

            Blank(); // Spacer

            Toggle({ type: ToggleType.Switch, isOn: $notificationsEnabled })
              .selectedColor(AppTokens.Colors.primary)
              .width(36)
              .height(20);
          }
          .width('100%');

          // Kanban Columns LazyRow equivalent
          Scroll() {
            Row({ space: AppTokens.Spacing.md }) {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
                  .width(220)
                  .layoutWeight(1); // Fill height
              }, (col: KanbanColumn) => col.title);
            }
            .padding({
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs
            });
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off);

          // Task Completion
          Text("Task Completion")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface);

          // LinearProgressIndicator equivalent
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Column()
              .width('100%')
              .height(8)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4);

            // Progress
            Column()
              .width(`${this.progressValue * 100}%`)
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4);
          }
          .width('100%')
          .height(8);
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .layoutWeight(1); // Fill remaining space
      }
    }
  }
}