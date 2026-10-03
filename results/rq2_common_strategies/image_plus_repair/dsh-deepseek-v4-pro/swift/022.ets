// MARK: - 颜色扩展：支持十六进制初始化
// 方便地使用与 Android 相同的十六进制颜色定义
// SwiftUI 的 Color(hex:) 初始化器在此映射为 ArkUI 的十六进制颜色字符串（AARRGGBB）
function hexColor(hex: number): string {
  return '#' + hex.toString(16).toUpperCase().padStart(8, '0');
}

// 将颜色与不透明度结合，等价于 SwiftUI 的 color.opacity(alpha)
function withAlpha(colorHex: string, alpha: number): string {
  const a: number = Math.round(alpha * 255);
  return '#' + a.toString(16).toUpperCase().padStart(2, '0') + colorHex.substring(3);
}

// MARK: - 应用设计令牌 (AppTokens)
// 统一管理颜色、字体、形状、间距和阴影，便于修改和维护
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

interface FontToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokensType {
  display: FontToken;
  title: FontToken;
  body: FontToken;
  label: FontToken;
}

interface RoundedCornerToken {
  radius: number;
}

interface ShapeTokens {
  small: RoundedCornerToken;
  medium: RoundedCornerToken;
  large: RoundedCornerToken;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class ShadowSpec {
  elevation: number; // Compose 中的 elevation，此处作为参考
  radius: number;    // 阴影的模糊半径
  dy: number;        // 阴影的 Y 轴偏移
  opacity: number;   // 阴影的不透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

interface ElevationTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: hexColor(0xFF38BDF8),
    secondary: hexColor(0xFF6366F1),
    tertiary: hexColor(0xFFA5B4FC),
    background: hexColor(0xFFF1F5F9),
    surface: hexColor(0xFFFFFFFF),
    surfaceVariant: hexColor(0xFFE2E8F0),
    outline: hexColor(0xFFD1D5DB),
    success: hexColor(0xFF22C55E),
    warning: hexColor(0xFFF59E0B),
    error: hexColor(0xFFEF4444),
    onPrimary: hexColor(0xFFFFFFFF),
    onSecondary: hexColor(0xFF1E1E1E),
    onTertiary: hexColor(0xFF1E1E1E),
    onBackground: hexColor(0xFF1E1E1E),
    onSurface: hexColor(0xFF1E1E1E)
  };

  static readonly TypographyTokens: TypographyTokensType = {
    // Kotlin 的 FontWeight.Normal 对应 SwiftUI 的 .regular
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapeTokens = {
    // RoundedCornerShape 对应 SwiftUI 的 cornerRadius
    small: { radius: 6 },
    medium: { radius: 10 },
    large: { radius: 16 }
  };

  static readonly Spacing: SpacingTokens = {
    // dp 单位直接转换为 vp，保持原子级对应
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly ElevationMapping: ElevationTokens = {
    level1: new ShadowSpec(2, 4, 2, 0.12),
    level2: new ShadowSpec(4, 8, 4, 0.16)
  };
}

// MARK: - 数据模型
// Task 数据类，需提供唯一标识以便在 ForEach 中使用
let taskIdCounter: number = 0;

class Task {
  id: string;     // 唯一标识符
  name: string;
  progress: number;
  constructor(name: string, progress: number) {
    this.id = 'task-' + taskIdCounter;
    taskIdCounter++;
    this.name = name;
    this.progress = progress;
  }
}

// MARK: - 自定义样式
// 1. 自定义 ToggleStyle 以匹配 Android 的 Switch 视觉效果
// SwiftUI 的 CustomSwitchToggleStyle 在此内联为 ArkUI 的 Toggle(Switch) 组件
// 2. 自定义 ProgressViewStyle 以匹配 Android 的 LinearProgressIndicator 视觉效果
// SwiftUI 的 CustomLinearProgressViewStyle 在此内联为 ArkUI 的 Progress(Linear) 组件

// MARK: - 根视图 (RootScreen)
@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    new Task('Design Phase', 0.8),
    new Task('Development', 0.5),
    new Task('Testing', 0.3),
    new Task('Documentation', 0.6),
    new Task('Deployment', 0.2)
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column({ space: 0 }) { // 主垂直堆栈，子视图之间无额外间距
      // 顶部导航栏 (CenterAlignedTopAppBar 模拟)
      Text('Project Timeline')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%') // 宽度填充
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg }) // 文本垂直内边距
        .backgroundColor(AppTokens.Colors.background) // 顶部栏背景色
        // 根据 UI 效果图，顶部标题与屏幕顶部有一小段距离，即使状态栏隐藏
        // 这里通过额外添加顶部内边距来模拟
        .padding({ top: AppTokens.Spacing.sm })

      // 主要内容区域，带有渐变背景
      Column({ space: AppTokens.Spacing.lg }) { // 通知行、任务列表、按钮之间的间距
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank() // 将开关推到右侧

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn; // 点击切换状态
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // 任务列表 (LazyColumn 模拟)
        Scroll() { // 使用 Scroll 模拟 LazyColumn，适用于少量固定数据
          Column({ space: AppTokens.Spacing.md }) { // 任务项之间的间距
            ForEach(this.tasks, (task: Task) => {
              Column({ space: AppTokens.Spacing.sm }) { // 任务项内部文本与进度条间距
                Text(task.name)
                  .fontSize(AppTokens.TypographyTokens.title.size)
                  .fontWeight(AppTokens.TypographyTokens.title.weight)
                  .fontColor(AppTokens.Colors.primary)

                Progress({ value: task.progress * 100, total: 100, type: ProgressType.Linear })
                  .color(AppTokens.Colors.secondary) // 进度条颜色
                  .backgroundColor(AppTokens.Colors.surfaceVariant) // 轨道颜色
                  .height(8) // 进度条高度 8.dp
                  .borderRadius(4) // 轨道/进度条圆角为高度的一半
                  .width('100%') // 进度条宽度填充
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start) // 任务项宽度填充，内容左对齐
              .padding(AppTokens.Spacing.md) // 任务项内部内容与边框的内边距
              .backgroundColor(withAlpha(AppTokens.Colors.surface, 0.7)) // 背景色及透明度
              .borderRadius(AppTokens.Shapes.large.radius) // 圆角
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius, // 阴影模糊半径
                color: withAlpha('#FF000000', AppTokens.ElevationMapping.level1.opacity), // 阴影颜色及不透明度
                offsetX: 0, // X 轴无偏移
                offsetY: AppTokens.ElevationMapping.level1.dy // Y 轴偏移
              })
            }, (task: Task) => task.id)
          }
          .width('100%')
        }
        .width('100%')
        .align(Alignment.TopStart)

        // 添加任务按钮
        Button() {
          Text('Add Task')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%') // 文本填充按钮区域
        }
        .width('100%')
        .height(52) // 按钮固定高度 52.dp
        .backgroundColor(AppTokens.Colors.primary) // 按钮背景色
        .borderRadius(AppTokens.Shapes.large.radius) // 按钮圆角
        .onClick(() => {
          // TODO: 处理添加任务逻辑
          console.log('Add Task button tapped!');
        })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg) // 整个内容区域（通知、列表、按钮）的内边距
      .linearGradient({ // 垂直渐变背景
        angle: 180,
        colors: [
          [withAlpha(AppTokens.Colors.surface, 0.8), 0.0],
          [AppTokens.Colors.background, 0.5],
          [withAlpha(AppTokens.Colors.surface, 0.8), 1.0]
        ]
      })
      // 渐变背景延伸至底部边缘，忽略底部安全区
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // 整个视图的背景色，作为未被渐变覆盖区域的填充
    // SwiftUI 的 statusBarHidden(true) 与 ignoresSafeArea 在 ArkUI 中由系统窗口属性控制，此处省略
  }
}
