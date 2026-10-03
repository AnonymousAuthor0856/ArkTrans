// AppTokens.ets
import { Length, Resource, LayeredImage } from '@ohos.arkui.UIContext';

class AppTokens {
  static Colors = {
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
  };

  static TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12, color: '#1A000000' },
    level2: { radius: 8, dy: 4, opacity: 0.16, color: '#29000000' },
  };
}

// Task.ets
class Task {
  id: string;
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.id = name + Math.random().toString();
    this.name = name;
    this.progress = progress;
  }
}

// RootScreen.ets
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
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center);

      // 主要内容区域
      Column() {
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface);

          Blank();

          // 自定义 Toggle
          Row() {
            Stack({ alignContent: this.notificationsEnabled ? Alignment.End : Alignment.Start }) {
              // Track
              Row()
                .width(51)
                .height(31)
                .borderRadius(15.5)
                .backgroundColor(this.notificationsEnabled ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant);

              // Thumb
              Row()
                .width(27)
                .height(27)
                .borderRadius(13.5)
                .backgroundColor(this.notificationsEnabled ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .shadow({ radius: 1, offsetY: 1, color: '#33000000' })
                .margin(2);
            }
            .width(51)
            .height(31)
            .onClick(() => {
              this.notificationsEnabled = !this.notificationsEnabled;
            });
          }
        }
        .width('100%')
        .padding({ bottom: AppTokens.Spacing.lg });

        // 任务列表
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              Column() {
                Text(task.name)
                  .fontSize(AppTokens.TypographyTokens.title.size)
                  .fontWeight(AppTokens.TypographyTokens.title.weight)
                  .fontColor(AppTokens.Colors.primary)
                  .margin({ bottom: AppTokens.Spacing.sm });

                // 自定义 LinearProgressIndicator
                Row() {
                  // Track
                  Row()
                    .width('100%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.surfaceVariant);

                  // Progress
                  Row()
                    .width((task.progress * 100) + '%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.secondary)
                    .position({ x: 0, y: 0 });
                }
                .width('100%')
                .height(8);
              }
              .padding(AppTokens.Spacing.md)
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                offsetY: AppTokens.ElevationMapping.level1.dy,
                color: AppTokens.ElevationMapping.level1.color,
              });
            });
          }
          .width('100%');
        }
        .layoutWeight(1)
        .margin({ bottom: AppTokens.Spacing.lg });

        // 添加任务按钮
        Button('Add Task')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large);
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.surface, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0],
        ],
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}