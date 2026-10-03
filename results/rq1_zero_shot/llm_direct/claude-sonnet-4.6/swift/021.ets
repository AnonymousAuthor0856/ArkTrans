import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#60A5FA';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F3F4F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShapes {
  static readonly smallRadius: number = 6;
  static readonly mediumRadius: number = 10;
  static readonly largeRadius: number = 14;
}

// MARK: - Data Models
class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

// MARK: - AssistChipView
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
        bottom: AppSpacing.sm
      })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.mediumRadius)
  }
}

// MARK: - CardView
@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn('', []);

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
    .borderRadius(AppShapes.largeRadius)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  @State private notificationsEnabled: boolean = true;

  build() {
    Column({ space: 0 }) {
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
        bottom: AppSpacing.md
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
            }, (col: KanbanColumn) => col.title)
          }
          .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
          .alignItems(VerticalAlign.Top)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        // Task Completion
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(4)

          Row()
            .width('65%')
            .height(8)
            .backgroundColor(AppColors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
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