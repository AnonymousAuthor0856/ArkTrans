// AppTokens
// 严格遵守要求4：按钮尺寸、间距与留白需与安卓版本原子级对应，保持控件样式、比例及排版一致。
// 所有 Dp 值直接转换为 number。
// 所有 Color 值从十六进制直接转换为 RGB 字符串。
// 所有 Font 尺寸和权重直接翻译。

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

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#29000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

class KanbanColumn {
  id: string;
  title: string;
  tasks: string[];
  constructor(title: string, tasks: string[]) {
    this.id = title;
    this.title = title;
    this.tasks = tasks;
  }
}

// 自定义线性进度，匹配 LinearProgressIndicator
@Component
struct LinearProgress {
  progress: number = 0;
  color: string = '#000000';
  trackColor: string = '#CCCCCC';
  height: number = 8;
  radius: number = 4;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.radius)
      Row()
        .width(Math.round(this.progress * 100) + '%')
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.radius)
    }
    .width('100%')
    .height(this.height)
  }
}

@Component
struct AssistChipView {
  task: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.task)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
    }
    .onClick(() => {
      // Kotlin 版本中 onClick 为空，此处也留空
    })
  }
}

@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn('', []);

  build() {
    Column() {
      Text(this.column.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.primary)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .space(AppSpacing.sm)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: AppShadows.level2Radius, color: AppShadows.level2Color, offsetX: 0, offsetY: AppShadows.level2Dy })
  }
}

@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  build() {
    Stack() {
      Column() {
        // 自定义顶部栏，等同于 CenterAlignedTopAppBar
        Row() {
          Blank()
          Text('Kanban Board')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onSurface)
          Blank()
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg, bottom: AppSpacing.md })
        .backgroundColor(AppColors.background)

        // 主要内容区域
        Column() {
          // 通知行
          Row() {
            Text('Notifications')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
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

          // Kanban 列的横向滚动
          Scroll() {
            Row() {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
                  .width(220)
              }, (col: KanbanColumn) => col.id)
            }
            .space(AppSpacing.md)
            .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 任务完成
          Text('Task Completion')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)

          // 线性进度
          LinearProgress({ progress: 0.65, color: AppColors.primary, trackColor: AppColors.surfaceVariant, height: 8, radius: 4 })
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .space(AppSpacing.lg)
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
