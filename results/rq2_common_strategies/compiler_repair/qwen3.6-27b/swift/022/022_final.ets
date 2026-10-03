import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - 颜色扩展：支持十六进制初始化
// ArkTS 中 Color 构造函数支持 hex 字符串，但为了保持与 SwiftUI 代码结构的一致性并处理透明度，我们封装一个辅助函数
function getHexColor(hex: number, alpha: number = 1.0): string {
  const r = ((hex >> 16) & 0xff).toString(16).padStart(2, '0');
  const g = ((hex >> 8) & 0xff).toString(16).padStart(2, '0');
  const b = (hex & 0xff).toString(16).padStart(2, '0');
  // ArkUI Color 支持 #RRGGBBAA 格式
  const a = Math.round(alpha * 255).toString(16).padStart(2, '0');
  return `#${r}${g}${b}${a}`;
}

// MARK: - 应用设计令牌 (AppTokens)
interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#FF38BDF8',
    secondary: '#FF6366F1',
    tertiary: '#FFA5B4FC',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  static TypographyTokens: Record<string, TypographyToken> = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 16
  };

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping: Record<string, ElevationToken> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
  };
}

// MARK: - 数据模型
interface Task {
  id: string;
  name: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    { id: '1', name: 'Design Phase', progress: 0.8 },
    { id: '2', name: 'Development', progress: 0.5 },
    { id: '3', name: 'Testing', progress: 0.3 },
    { id: '4', name: 'Documentation', progress: 0.6 },
    { id: '5', name: 'Deployment', progress: 0.2 }
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // 顶部导航栏
      Text('Project Timeline')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm + AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg }) // 模拟状态栏偏移 + 内边距
        .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onSurface)

          Blank()

          // 自定义 Switch 组件
          this.CustomSwitch(this.notificationsEnabled)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // 任务列表
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              this.TaskItem(task)
            }, (task: Task) => task.id)
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // 添加任务按钮
        Button({ type: ButtonType.Capsule }) {
          Text('Add Task')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .width('100%')
        .onClick(() => {
          console.info('Add Task button tapped!');
        })
      }
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(255, 255, 255, 0.8)', 0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(255, 255, 255, 0.8)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .systemBarProperties(SystemBarProperties.PROPERTIES_STATUS_BAR_CONTENT_COLOR_BLACK) // 确保文字可见
  }

  @Builder
  CustomSwitch(isOn: boolean) {
    Row() {
      if (isOn) {
        Circle()
          .fill(AppTokens.Colors.primary)
          .width(27)
          .height(27)
          .shadow({ radius: 1, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
      } else {
        Circle()
          .fill(AppTokens.Colors.surface)
          .width(27)
          .height(27)
          .shadow({ radius: 1, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
      }
    }
    .width(51)
    .height(31)
    .justifyContent(isOn ? FlexAlign.End : FlexAlign.Start)
    .padding(2)
    .clip(true)
    .onClick(() => {
      this.notificationsEnabled = !this.notificationsEnabled;
    })
    .background(isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(15.5) // 高度的一半
  }

  @Builder
  TaskItem(task: Task) {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(task.name)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.primary)
        .textAlign(TextAlign.Start)

      // 自定义进度条
      Row() {
        // 轨道
        Rect()
          .fill(AppTokens.Colors.surfaceVariant)
          .borderRadius(4) // 高度的一半
          .width('100%')
          .height(8)

        // 进度
        RelativeContainer() {
          Rect()
            .fill(AppTokens.Colors.secondary)
            .borderRadius(4)
            .width(`${Math.round(task.progress * 100)}%`)
            .height(8)
            .alignRules({
              left: { anchor: '__container__', align: HorizontalAlign.Start },
              center: { anchor: '__container__', align: VerticalAlign.Center }
            })
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(getHexColor(parseInt(AppTokens.Colors.surface.slice(1), 16), 0.7))
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}