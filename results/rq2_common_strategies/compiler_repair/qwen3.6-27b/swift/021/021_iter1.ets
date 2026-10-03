import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 严格遵守要求4：按钮尺寸、间距与留白需与安卓版本原子级对应，保持控件样式、比例及排版一致。
// 所有 Dp 值直接转换为 number (vp)。
// 所有 Color 值从十六进制直接转换为 ArkTS Color。
// 所有 Font 尺寸和权重直接翻译。
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
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 }
  };
}

// MARK: - Data Models
interface KanbanColumn {
  id: string;
  title: string;
  tasks: string[];
}

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
    Column() {
      // 自定义顶部栏
      Column() {
        Row() {
          Text('Kanban Board')
            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
      }
      .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 通知行
        Row() {
          Text('Notifications')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
          
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Kanban 列的 LazyRow 等效
        Scroll() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Stretch }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              CardView({ column: col })
                .width(220)
                .margin({ right: AppTokens.Spacing.md })
            }, (item: KanbanColumn) => item.id)
          }
          .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .height(250) // 固定高度以匹配 SwiftUI 的 fillMaxHeight 行为在有限空间内

        // 任务完成
        Text('Task Completion')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onSurface)

        // LinearProgressIndicator 等效
        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - CardView (Kanban Column Card)
@Component
struct CardView {
  @Prop column: KanbanColumn;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.column.title)
        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
        .foregroundColor(AppTokens.Colors.primary)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (item: string) => item)

      Blank() // Spacer equivalent
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

// MARK: - AssistChipView
@Component
struct AssistChipView {
  @Prop task: string;

  build() {
    Button({ type: ButtonType.Capsule }) {
      Text(this.task)
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .onClick(() => {
      // Kotlin 版本中 onClick 为空，此处也留空
    })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .margin({ bottom: AppTokens.Spacing.sm })
  }
}