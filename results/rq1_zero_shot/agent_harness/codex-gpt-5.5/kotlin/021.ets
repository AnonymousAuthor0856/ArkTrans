const NAME: string = '021KanbanBoarden';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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

class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

@Entry
@Component
struct MainActivity {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  @Builder
  Header(): void {
    Text('Kanban Board')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  TaskChip(task: string): void {
    Text(task)
      .fontSize(14)
      .fontColor(AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(10);
  }

  @Builder
  ColumnCard(column: KanbanColumn): void {
    Column({ space: AppSpacing.sm }) {
      Text(column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      ForEach(column.tasks, (task: string) => {
        this.TaskChip(task);
      }, (task: string) => task)
    }
    .width(220)
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Blank();
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .onChange((value: boolean) => {
              this.notificationsEnabled = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
        Scroll() {
          Row({ space: AppSpacing.md }) {
            ForEach(this.columns, (column: KanbanColumn) => {
              this.ColumnCard(column);
            }, (column: KanbanColumn) => column.title)
          }
          .height('100%');
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .layoutWeight(1);
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
