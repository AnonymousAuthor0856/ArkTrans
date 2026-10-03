// MARK: - AppTokens

class AppColorsClass {
  primary: string = '#2563EB';
  secondary: string = '#60A5FA';
  tertiary: string = '#3B82F6';
  background: string = '#F3F4F6';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E5E7EB';
  outline: string = '#D1D5DB';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#DC2626';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class AppSpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class AppShapesClass {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

class ElevationSpec {
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;
}

class AppElevationClass {
  level1: ElevationSpec = { radius: 4, dy: 2, opacity: 0.12 } as ElevationSpec;
  level2: ElevationSpec = { radius: 8, dy: 4, opacity: 0.16 } as ElevationSpec;
}

const AppColors: AppColorsClass = new AppColorsClass();
const AppSpacing: AppSpacingClass = new AppSpacingClass();
const AppShapes: AppShapesClass = new AppShapesClass();
const AppElevation: AppElevationClass = new AppElevationClass();

// MARK: - Data Models
class KanbanColumn {
  id: number = 0;
  title: string = '';
  tasks: string[] = [];
}

// MARK: - AssistChipView Component
@Component
struct AssistChipView {
  task: string = '';

  build() {
    Text(this.task)
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor(AppColors.onSurface)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
  }
}

// MARK: - CardView Component
@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn();

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .alignSelf(ItemAlign.Start)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width(220)
    .height('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2.radius,
      color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level2.dy,
    })
  }
}

// MARK: - Custom Progress Bar Component
@Component
struct LinearProgressBar {
  progress: number = 0.65;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)

      // Progress
      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  private columns: KanbanColumn[] = (() => {
    const col1 = new KanbanColumn();
    col1.id = 1;
    col1.title = 'To Do';
    col1.tasks = ['Write report', 'Design mockup'];

    const col2 = new KanbanColumn();
    col2.id = 2;
    col2.title = 'In Progress';
    col2.tasks = ['Implement feature X', 'Fix layout bug'];

    const col3 = new KanbanColumn();
    col3.id = 3;
    col3.title = 'Done';
    col3.tasks = ['Team sync', 'Client feedback'];

    return [col1, col2, col3];
  })();

  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Blank()
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
        Blank()
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.md,
      })
      .backgroundColor(AppColors.background)

      // Main Content
      Column({ space: AppSpacing.lg }) {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Kanban Columns Horizontal Scroll
        Scroll() {
          Row({ space: AppSpacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              CardView({ column: col })
            }, (col: KanbanColumn) => col.id.toString())
          }
          .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
          .alignItems(VerticalAlign.Top)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(220)

        // Task Completion Label
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Progress Bar
        LinearProgressBar({ progress: 0.65 })
          .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}