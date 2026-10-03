// 应用设计令牌 (AppTokens)

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#A5B4FC';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 26;
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
  static readonly large: number = 16;
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

// 数据模型
class Task {
  id: string;
  name: string;
  progress: number;
  constructor(name: string, progress: number) {
    this.id = name;
    this.name = name;
    this.progress = progress;
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

// 根视图 (RootScreen)
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
    Column() {
      // 顶部导航栏 (CenterAlignedTopAppBar 模拟)
      Text('Project Timeline')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // 主要内容区域，带有渐变背景
      Column() {
        // 通知开关行
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

        // 任务列表 (LazyColumn 模拟)
        Scroll() {
          Column() {
            ForEach(this.tasks, (task: Task) => {
              Column() {
                Text(task.name)
                  .fontSize(AppTypography.titleSize)
                  .fontWeight(AppTypography.titleWeight)
                  .fontColor(AppColors.primary)

                LinearProgress({ progress: task.progress, color: AppColors.secondary, trackColor: AppColors.surfaceVariant, height: 8, radius: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .space(AppSpacing.sm)
              .padding(AppSpacing.md)
              .width('100%')
              .backgroundColor('#B3FFFFFF')
              .borderRadius(AppShapes.large)
              .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
            }, (task: Task) => task.id)
          }
          .width('100%')
          .space(AppSpacing.md)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // 添加任务按钮
        Button({ type: ButtonType.Normal }) {
          Text('Add Task')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(52)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {
          console.log('Add Task button tapped!');
        })
      }
      .width('100%')
      .layoutWeight(1)
      .space(AppSpacing.lg)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#CCFFFFFF', 0.0], [AppColors.background, 0.5], ['#CCFFFFFF', 1.0]]
      })
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
