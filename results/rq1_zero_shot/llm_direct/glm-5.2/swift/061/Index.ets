// AppTokens.ets
// 集中管理应用程序的颜色、字体、形状和间距。
// 这使得全局修改 UI 样式变得非常方便。
export class AppTokens {
  static readonly Colors = {
    // 将 Kotlin 的 0xFFRRGGBB 格式颜色转换为 ArkTS 的 ResourceColor 字符串
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937'
  };

  static readonly TypographyTokens = {
    // 将 Kotlin 的 TextStyle 转换为 ArkTS 的 Font
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  };

  static readonly Shapes = {
    // 将 Kotlin 的 RoundedCornerShape 转换为 ArkTS 的 number 圆角半径
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  };

  static readonly Spacing = {
    // 将 Kotlin 的 Dp 转换为 ArkTS 的 number 间距
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  };
}

// ParcelCanvas.ets
// 对应 Kotlin 的 ParcelCanvas Composable 函数
@Component
export struct ParcelCanvas {
  @State private dragOffsetX: number = 0; // 拖动圆圈的当前位置 X
  @State private dragOffsetY: number = 0; // 拖动圆圈的当前位置 Y
  @State private parcelPoints: Array<Record<string, number>> = []; // 散布的包裹点
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  // 辅助函数：生成随机点，确保它们在给定的宽度和高度范围内
  private generateRandomPoints(width: number, height: number): Array<Record<string, number>> {
    const points: Array<Record<string, number>> = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height
      });
    }
    return points;
  }

  build() {
    // Stack 用于将 Canvas 和 Text 叠加在一起
    Stack({ alignContent: Alignment.Center }) {
      // ArkTS 的 Canvas 组件，用于自定义绘图
      Canvas(this.canvasWidth, this.canvasHeight)
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.md)
        .onReady((context: CanvasRenderingContext2D) => {
          // 获取 Canvas 实际可绘制区域的尺寸，考虑到内部 padding
          this.canvasWidth = context.canvas.width;
          this.canvasHeight = context.canvas.height;

          // 初始化包裹点，确保它们在 Canvas 的有效绘制区域内
          this.parcelPoints = this.generateRandomPoints(this.canvasWidth, this.canvasHeight);
          // 初始化拖动圆圈的初始位置，确保它也在有效绘制区域内
          this.dragOffsetX = Math.random() * (this.canvasWidth - 40) + 20;
          this.dragOffsetY = Math.random() * (this.canvasHeight - 40) + 20;

          this.drawCanvas(context);
        })
        // 添加拖动手势
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              // 更新拖动偏移量，并限制其在 Canvas 的有效绘制区域内
              // 20 是拖动圆圈的半径，用于确保圆圈完全在边界内
              this.dragOffsetX = Math.max(20, Math.min(event.fingerList[0].localX, this.canvasWidth - 20));
              this.dragOffsetY = Math.max(20, Math.min(event.fingerList[0].localY, this.canvasHeight - 20));
              this.drawCanvas(context);
            })
            .onActionUpdate((event: GestureEvent) => {
              this.dragOffsetX = Math.max(20, Math.min(event.fingerList[0].localX, this.canvasWidth - 20));
              this.dragOffsetY = Math.max(20, Math.min(event.fingerList[0].localY, this.canvasHeight - 20));
              this.drawCanvas(context);
            })
        )

      // 提示文本
      Text("Drag to locate parcel")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    // 外部容器的宽度填充和固定高度，对应 Kotlin 的 .fillMaxWidth().height(300.dp)
    .width('100%')
    .height(300)
    // 背景颜色，对应 Kotlin 的 .background(AppTokens.Colors.surface)
    .backgroundColor(AppTokens.Colors.surface)
    // 圆角，对应 Kotlin 的 AppTokens.Shapes.large
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    // 边框，对应 Kotlin 的 .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.largeCornerRadius
    })
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2Settings() as CanvasRenderingContext2D;

  private drawCanvas(context: CanvasRenderingContext2D) {
    // 清除画布
    context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // 绘制所有包裹点
    context.fillStyle = AppTokens.Colors.secondary;
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const point = this.parcelPoints[i];
      context.beginPath();
      context.arc(point.x, point.y, 4, 0, Math.PI * 2);
      context.fill();
    }

    // 绘制可拖动的中心圆圈
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 3;
    context.beginPath();
    context.arc(this.dragOffsetX, this.dragOffsetY, 20, 0, Math.PI * 2);
    context.stroke();
  }
}

// RootScreen.ets
// 对应 Kotlin 的 RootScreen Composable 函数
@Component
export struct RootScreen {
  build() {
    // Column 对应 Kotlin 的 Column，用于垂直排列子视图
    Column({ space: AppTokens.Spacing.xl }) {
      Text("Parcel Tracker")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      // ParcelCanvas 实例
      ParcelCanvas()

      Text("Visualize parcel movements and positions.")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    // 填充所有可用空间，对应 Kotlin 的 .fillMaxSize()
    .width('100%')
    .height('100%')
    // 背景渐变，对应 Kotlin 的 Brush.verticalGradient
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
    // 整个 RootScreen 的外部 padding，对应 Kotlin 的 .padding(AppTokens.Spacing.lg)
    .padding(AppTokens.Spacing.lg)
    // 忽略安全区域，使内容全屏显示，包括状态栏和导航栏下方
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// ParcelTrackerApp.ets
// ArkTS 应用程序的入口点，对应 Kotlin 的 MainActivity
@Entry
struct ParcelTrackerApp {
  build() {
    RootScreen()
      // 隐藏状态栏，对应 Kotlin 的 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.statusBars())
      .windowFullScreen(true)
  }
}