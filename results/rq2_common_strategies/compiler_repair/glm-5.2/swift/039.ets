// Index.ets
// 统一的 UI 令牌，方便修改颜色、字体、间距和形状
class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#FFA500',
    secondary: '#FFC107',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  }

  static TypographyTokens: Record<string, Record<string, number | FontWeight>> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static Shapes: Record<string, number> = {
    small: 6.0,
    medium: 12.0,
    large: 20.0,
  }

  static Spacing: Record<string, number> = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0,
  }

  static ElevationMapping: Record<string, Record<string, number>> = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.18 },
  }
}

// 自定义绘制组件，用于实现 SwiftUI Canvas 的波浪线绘制
@Component
export struct CustomCanvas {
  @Prop paymentProgress: number;
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.canvasWidth = this.context.width;
        this.canvasHeight = this.context.height;
        this.draw();
      })
  }

  private draw() {
    const w = this.canvasWidth;
    const h = this.canvasHeight;
    if (w === 0 || h === 0) {
      return;
    }
    const step = w / 20;

    this.context.clearRect(0, 0, w, h);
    this.context.beginPath();

    // 计算第一个点 (x=0) 的 Y 坐标，并移动到该点
    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    this.context.moveTo(0, initialY);

    // 绘制后续的线段，从 i=1 开始
    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      this.context.lineTo(x, y);
    }

    this.context.lineWidth = 5;
    this.context.strokeStyle = AppTokens.Colors.primary;
    this.context.stroke();
  }
}

// 应用程序的根视图，包含所有 UI 元素和布局
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  build() {
    Column() {
      // 顶部栏
      Text('Installment Plan')
        .fontSize(AppTokens.TypographyTokens.display.size as number)
        .fontWeight(AppTokens.TypographyTokens.display.weight as FontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64)
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center)

      // 主要内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // SurfaceWithCanvas
        Stack() {
          // Surface 背景和阴影
          Column()
            .width('100%')
            .height(240)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            });

          // Canvas 绘图区域
          CustomCanvas({ paymentProgress: this.paymentProgress })
            .padding(AppTokens.Spacing.lg)
            .height(240)
        }
        .width('100%')

        Text('Payment Progress')
          .fontSize(AppTokens.TypographyTokens.title.size as number)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .fontColor(AppTokens.Colors.primary)

        // CustomLinearProgressIndicator
        Stack({ alignContent: Alignment.Start }) {
          // 背景轨道
          Column()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4)

          // 进度条
          Column()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
        }
        .width('100%')

        // CustomSlider
        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value;
          })

        // Reset Button
        Button('Reset Progress')
          .fontSize(AppTokens.TypographyTokens.title.size as number)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.25],
          [AppTokens.Colors.background, 1.0],
          [AppTokens.Colors.primary, 0.25]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}