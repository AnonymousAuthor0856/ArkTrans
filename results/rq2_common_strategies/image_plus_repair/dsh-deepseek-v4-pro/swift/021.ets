// MARK: - AppTokens
// 严格遵守要求4：按钮尺寸、间距与留白需与安卓版本原子级对应，保持控件样式、比例及排版一致。
// 所有 Dp 值直接转换为 vp。
// 所有 Color 值从十六进制直接转换为 RGB。
// 所有 Font 尺寸和权重直接翻译。
class AppTokensColors {
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

class FontSpec {
  size: number;
  weight: FontWeight;
  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTokensTypography {
  static readonly display: FontSpec = new FontSpec(28, FontWeight.Bold);
  static readonly title: FontSpec = new FontSpec(18, FontWeight.Medium);
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Regular);
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium);
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
  blackShadowColor(): string {
    const alpha: number = Math.round(this.opacity * 255);
    let hex: string = alpha.toString(16).toUpperCase();
    if (hex.length < 2) {
      hex = '0' + hex;
    }
    return '#' + hex + '000000';
  }
}

class AppTokensElevation {
  // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f) -> radius: 4, y: 2, opacity: 0.12
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  // Kotlin: ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f) -> radius: 8, y: 4, opacity: 0.16
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

// MARK: - Data Models
class KanbanColumn {
  id: string;
  title: string;
  tasks: string[];
  static counter: number = 0;
  constructor(title: string, tasks: string[]) {
    KanbanColumn.counter++;
    this.id = 'column_' + KanbanColumn.counter.toString();
    this.title = title;
    this.tasks = tasks;
  }
}

// MARK: - RootScreen
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
        Column() {
          Row() {
            Blank()
            Text('Kanban Board')
              .fontSize(AppTokensTypography.display.size)
              .fontWeight(AppTokensTypography.display.weight)
              .fontColor(AppTokensColors.onSurface)
            Blank()
          }
          .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })
          .padding({ top: AppTokensSpacing.lg })
          .padding({ bottom: AppTokensSpacing.md })
        }
        .width('100%')
        .backgroundColor(AppTokensColors.background)

        // 主要内容区域
        Column({ space: AppTokensSpacing.lg }) {
          // 通知行
          Row() {
            Text('Notifications')
              .fontSize(AppTokensTypography.title.size)
              .fontWeight(AppTokensTypography.title.weight)
              .fontColor(AppTokensColors.onSurface)
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(AppTokensColors.primary)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')

          // Kanban 列的 LazyRow 等效
          Scroll() {
            Row({ space: AppTokensSpacing.md }) {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
                  .width(220)
                  .height('100%')
              }, (col: KanbanColumn) => col.id)
            }
            .height('100%')
            .padding({ top: AppTokensSpacing.xs, bottom: AppTokensSpacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 任务完成
          Text('Task Completion')
            .fontSize(AppTokensTypography.title.size)
            .fontWeight(AppTokensTypography.title.weight)
            .fontColor(AppTokensColors.onSurface)

          // LinearProgressIndicator 等效
          LinearProgressIndicator({
            value: 0.65,
            tint: AppTokensColors.primary,
            trackColor: AppTokensColors.surfaceVariant
          })
          .width('100%')
          .height(8)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokensSpacing.lg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END])
  }
}

// MARK: - Custom ProgressViewStyle to match LinearProgressIndicator
@Component
struct LinearProgressIndicator {
  value: number = 0;
  tint: string = '#2563EB';
  trackColor: string = '#E5E7EB';

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 高度 8.dp 的一半
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(this.trackColor)
        .borderRadius(4)

      Row()
        .width((this.value * 100).toString() + '%')
        .height(8)
        .backgroundColor(this.tint)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

// MARK: - CardView (Kanban Column Card)
@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn('', []);

  build() {
    Column({ space: AppTokensSpacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTokensTypography.title.size)
        .fontWeight(AppTokensTypography.title.weight)
        .fontColor(AppTokensColors.primary)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      // 将内容推到卡片顶部，模拟 fillMaxHeight 行为
      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokensSpacing.md)
    .backgroundColor(AppTokensColors.surface)
    .borderRadius(AppTokensShapes.large)
    .shadow({
      radius: AppTokensElevation.level2.radius,
      color: AppTokensElevation.level2.blackShadowColor(),
      offsetX: 0,
      offsetY: AppTokensElevation.level2.dy
    })
  }
}

// MARK: - AssistChipView
@Component
struct AssistChipView {
  task: string = '';

  build() {
    Button() {
      Text(this.task)
        .fontSize(AppTokensTypography.body.size)
        .fontWeight(AppTokensTypography.body.weight)
        .fontColor(AppTokensColors.onSurface)
    }
    .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })
    .padding({ top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
    .backgroundColor(AppTokensColors.surfaceVariant)
    .borderRadius(AppTokensShapes.medium)
    .onClick(() => {
      // Kotlin 版本中 onClick 为空，此处也留空
    })
  }
}

// MARK: - App Entry Point (要求5)
// 原 SwiftUI 使用 @main struct KanbanBoardApp: App + WindowGroup 作为入口。
// ArkUI 使用 @Entry 装饰器标记应用入口页面。
@Entry
@Component
struct KanbanBoardApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - UIHostingController for Status Bar Hiding (要求2)
// Swift 通过 UIHostingController 子类重写 prefersStatusBarHidden 隐藏顶部状态栏，
// 并要求 Info.plist 设置 "View controller-based status bar appearance" 为 YES。
// ArkUI 无 UIKit 等价物，状态栏隐藏由页面配置与 expandSafeArea 处理（见 RootScreen）。
// 原代码（仅供参考，无 ArkUI 对应）：
//   class HostingController<Content>: UIHostingController<Content> where Content : View {
//       override var prefersStatusBarHidden: Bool { return true }
//       override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
//   }
//   struct HostingControllerWrapper: UIViewControllerRepresentable {
//       func makeUIViewController(context: Context) -> HostingController<RootScreen> {
//           return HostingController(rootView: RootScreen())
//       }
//       func updateUIViewController(_ uiViewController: HostingController<RootScreen>, context: Context) {}
//   }
