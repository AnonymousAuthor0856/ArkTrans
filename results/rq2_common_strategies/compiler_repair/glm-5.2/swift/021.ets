// AppTokens.ets
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

export class AppTokens {
  static readonly Colors: ColorTokens = {
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
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Elevation: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
  }
}

export class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

// LinearProgressIndicator.ets
@Component
export struct LinearProgressIndicator {
  @Prop value: number = 0;
  @Prop trackColor: string = AppTokens.Colors.surfaceVariant;
  @Prop progressColor: string = AppTokens.Colors.primary;
  @Prop progressHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height(this.progressHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.progressHeight / 2);

      // Progress
      Column()
        .width(`${this.value * 100}%`)
        .height(this.progressHeight)
        .backgroundColor(this.progressColor)
        .borderRadius(this.progressHeight / 2);
    }
    .width('100%')
    .height(this.progressHeight);
  }
}

// AssistChipView.ets
@Component
export struct AssistChipView {
  @Prop task: string;

  build() {
    Text(this.task)
      .fontSize(AppTokens.Typography.body.size)
      .fontWeight(AppTokens.Typography.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.xs });
  }
}

// CardView.ets
@Component
export struct CardView {
  @Prop column: KanbanColumn;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.primary);

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task });
      }, (task: string) => task)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
      offsetY: AppTokens.Elevation.level2.dy
    });
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    new KanbanColumn("To Do", ["Write report", "Design mockup"]),
    new KanbanColumn("In Progress", ["Implement feature X", "Fix layout bug"]),
    new KanbanColumn("Done", ["Team sync", "Client feedback"])
  ];

  build() {
    Column() {
      // Custom Top App Bar
      Row() {
        Text("Kanban Board")
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.md,
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })
      .backgroundColor(AppTokens.Colors.background);

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {
        // Notifications Row
        Row() {
          Text("Notifications")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface);

          Blank();

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            });
        }
        .width('100%');

        // Kanban Columns LazyRow
        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              CardView({ column: col })
                .width(220)
                .height('100%');
            }, (col: KanbanColumn) => col.title)
          }
          .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs });
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .layoutWeight(1);

        // Task Completion
        Text("Task Completion")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface);

        // Linear Progress Indicator
        LinearProgressIndicator({
          value: 0.65,
          trackColor: AppTokens.Colors.surfaceVariant,
          progressColor: AppTokens.Colors.primary,
          progressHeight: 8
        });
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}