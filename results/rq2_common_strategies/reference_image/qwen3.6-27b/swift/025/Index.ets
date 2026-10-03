import { Color, FontSize } from '@kit.ArkUI';

// MARK: - AppTokens
// 对应 Kotlin 的 AppTokens 对象，定义了颜色、字体、间距和阴影规范
class AppTokens {
  static Colors = {
    primary: '#00FFFF',
    secondary: '#00FF88',
    tertiary: '#BB86FC',
    background: '#0D0D0D',
    surface: '#1C1C1C',
    surfaceVariant: '#2E2E2E',
    outline: '#3F3F3F',
    success: '#00FFAA',
    warning: '#FFC107',
    error: '#FF1744',
    onPrimary: '#000000',
    onSecondary: '#000000',
    onTertiary: '#000000',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF'
  };

  static TypographyTokens = {
    display: { size: 28 as FontSize, weight: FontWeight.Bold },
    title: { size: 18 as FontSize, weight: FontWeight.Medium },
    body: { size: 14 as FontSize, weight: FontWeight.Normal },
    label: { size: 12 as FontSize, weight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping = {
    level1: { opacity: 0.12, radius: 4, dy: 2 },
    level2: { opacity: 0.18, radius: 8, dy: 4 }
  };
}

@Entry
@Component
struct RootScreen {
  // 对应 Kotlin 的 mutableStateListOf 和 mutableStateOf
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = AppTokens.Colors.primary;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景色，忽略安全区域以实现全屏
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas 用于绘制节点和连线
      CanvasRenderingContext2D()
        .width('100%')
        .height('100%')
        .onReady((context: CanvasRenderingContext2D) => {
          // 绘制连线
          for (let i = 1; i < this.nodes.length; i++) {
            const start = this.nodes[i - 1];
            const end = this.nodes[i];
            context.beginPath();
            context.moveTo(start.x, start.y);
            context.lineTo(end.x, end.y);
            context.strokeStyle = this.currentColor;
            context.lineWidth = 6;
            context.stroke();
          }

          // 绘制节点
          for (const node of this.nodes) {
            context.beginPath();
            context.arc(node.x, node.y, 20, 0, Math.PI * 2);
            context.fillStyle = this.currentColor;
            context.fill();
          }
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.nodes.push({ x: event.globalX, y: event.globalY });
            })
        )

      // 顶部栏 (Top Bar)
      Column() {
        Text('Neon Mind Map')
          .font(AppTokens.TypographyTokens.display)
          .foregroundColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)
      }
      .position({ x: 0, y: 0 })

      // 底部栏 (Bottom Bar)
      Column() {
        Row() {
          // Cyan 按钮
          Button('Cyan')
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .margin({ right: AppTokens.Spacing.md })

          // Green 按钮
          Button('Green')
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .margin({ right: AppTokens.Spacing.md })

          // Purple 按钮
          Button('Purple')
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: '100%' })
      .translate({ y: -AppTokens.Spacing.md * 2 })

      // 浮动操作按钮 (Floating Action Button)
      Button('+')
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .width(56)
        .height(56)
        .onClick(() => {
          const randomX = Math.random() * 500 + 100;
          const randomY = Math.random() * 600 + 200;
          this.nodes.push({ x: randomX, y: randomY });
        })
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .position({ x: '100%', y: '100%' })
        .translate({ x: -AppTokens.Spacing.lg - 28, y: -AppTokens.Spacing.lg - 28 })
    }
    .width('100%')
    .height('100%')
  }
}