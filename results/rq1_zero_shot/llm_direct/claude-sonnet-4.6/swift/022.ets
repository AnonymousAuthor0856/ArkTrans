import { LengthMetrics } from '@kit.ArkUI';

// MARK: - 应用设计令牌 (AppTokens)
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF38BDF8';
    export const secondary: string = '#FF6366F1';
    export const tertiary: string = '#FFA5B4FC';
    export const background: string = '#FFF1F5F9';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE2E8F0';
    export const outline: string = '#FFD1D5DB';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF1E1E1E';
    export const onTertiary: string = '#FF1E1E1E';
    export const onBackground: string = '#FF1E1E1E';
    export const onSurface: string = '#FF1E1E1E';
  }

  export namespace Typography {
    export const displaySize: number = 26;
    export const titleSize: number = 18;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Shapes {
    export const smallRadius: number = 6;
    export const mediumRadius: number = 10;
    export const largeRadius: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace Elevation {
    export const level1Radius: number = 4;
    export const level1OffsetY: number = 2;
    export const level1Opacity: number = 0.12;
    export const level2Radius: number = 8;
    export const level2OffsetY: number = 4;
    export const level2Opacity: number = 0.16;
  }
}

// MARK: - 数据模型
interface TaskItem {
  id: string;
  name: string;
  progress: number;
}

// MARK: - 根视图
@Entry
@Component
struct RootScreen {
  @State tasks: TaskItem[] = [
    { id: '1', name: 'Design Phase', progress: 0.8 },
    { id: '2', name: 'Development', progress: 0.5 },
    { id: '3', name: 'Testing', progress: 0.3 },
    { id: '4', name: 'Documentation', progress: 0.6 },
    { id: '5', name: 'Deployment', progress: 0.2 },
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // 顶部标题栏
      Text('Project Timeline')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppTokens.Spacing.lg + AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.lg,
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
        })
        .backgroundColor(AppTokens.Colors.background)

      // 主内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          // 自定义 Toggle
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .switchPointColor(AppTokens.Colors.onPrimary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .width(51)
            .height(31)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // 任务列表
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.tasks, (task: TaskItem) => {
              Column({ space: AppTokens.Spacing.sm }) {
                Text(task.name)
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)
                  .width('100%')
                  .textAlign(TextAlign.Start)

                // 自定义进度条
                Stack({ alignContent: Alignment.Start }) {
                  // 轨道
                  Row()
                    .width('100%')
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)

                  // 进度
                  Row()
                    .width(`${task.progress * 100}%`)
                    .height(8)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.secondary)
                }
                .width('100%')
                .height(8)
              }
              .padding(AppTokens.Spacing.md)
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#B3FFFFFF')
              .borderRadius(AppTokens.Shapes.largeRadius)
              .shadow({
                color: `rgba(0,0,0,${AppTokens.Elevation.level1Opacity})`,
                radius: AppTokens.Elevation.level1Radius,
                offsetX: 0,
                offsetY: AppTokens.Elevation.level1OffsetY,
              })
            }, (task: TaskItem) => task.id)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // 添加任务按钮
        Button('Add Task')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.largeRadius)
          .onClick(() => {
            console.info('Add Task button tapped!');
          })
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CCFFFFFF', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['#CCFFFFFF', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}