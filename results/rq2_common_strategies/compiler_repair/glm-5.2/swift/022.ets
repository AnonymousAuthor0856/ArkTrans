// index.ets

// MARK: - 应用设计令牌
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
    onSurface: '#FF1E1E1E',
  }

  static TypographyTokens: Record<string, Record<string, number | FontWeight>> = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static Shapes: Record<string, Record<string, number>> = {
    small: { radius: 6 },
    medium: { radius: 10 },
    large: { radius: 16 },
  }

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  }

  static ElevationMapping: Record<string, Record<string, number>> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  }
}

// MARK: - 数据模型
class Task {
  id: string;
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.id = Math.random().toString(36).substr(2, 10); // 生成唯一ID
    this.name = name;
    this.progress = progress;
  }
}

// MARK: - 根视图
@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    new Task('Design Phase', 0.8),
    new Task('Development', 0.5),
    new Task('Testing', 0.3),
    new Task('Documentation', 0.6),
    new Task('Deployment', 0.2),
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // 顶部导航栏
      Text('Project Timeline')
        .fontSize(AppTokens.TypographyTokens.display.size as number)
        .fontWeight(AppTokens.TypographyTokens.display.weight as FontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域
      Column() {
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size as number)
            .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank() // 推到右侧

          // 模拟自定义 Toggle
          Row() {
            Toggle({ type: ToggleType.Switch, isOn: $$this.notificationsEnabled })
              .selectedColor(AppTokens.Colors.primary)
              .switchPointColor(AppTokens.Colors.surface)
          }
          .width(51)
          .height(31)
          .borderRadius(15.5)
          .backgroundColor(this.notificationsEnabled ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled;
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // 任务列表
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              Column() {
                Text(task.name)
                  .fontSize(AppTokens.TypographyTokens.title.size as number)
                  .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
                  .fontColor(AppTokens.Colors.primary)
                  .margin({ bottom: AppTokens.Spacing.sm })

                // 模拟自定义 ProgressView
                Stack({ alignContent: Alignment.Start }) {
                  // 轨道
                  Column()
                    .width('100%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)

                  // 进度条
                  Column()
                    .width(`${task.progress * 100}%`)
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.secondary)
                }
                .width('100%')
                .height(8)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .opacity(0.7)
              .borderRadius(AppTokens.Shapes.large.radius)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
            })
          }
        }
        .layoutWeight(1) // 列表占据剩余空间
        .margin({ bottom: AppTokens.Spacing.lg })

        // 添加任务按钮
        Button('Add Task')
          .fontSize(AppTokens.TypographyTokens.title.size as number)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large.radius)
          .onClick(() => {
            console.log('Add Task button tapped!');
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.surface, 0.8],
          [AppTokens.Colors.background, 1.0],
          [AppTokens.Colors.surface, 0.8]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}