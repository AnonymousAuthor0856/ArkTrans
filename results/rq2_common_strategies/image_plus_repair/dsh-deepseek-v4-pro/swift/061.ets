// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状和间距。
// 这使得全局修改 UI 样式变得非常方便。

// 颜色令牌，使用十六进制颜色字符串（对应 Kotlin 的 0xFFRRGGBB 格式颜色）
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

// 文本样式令牌，对应 Kotlin 的 TextStyle
interface TextStyleToken {
  fontSize: number;
  fontWeight: number;
}

interface TypographyTokens {
  display: TextStyleToken;
  headline: TextStyleToken;
  title: TextStyleToken;
  body: TextStyleToken;
}

// 形状令牌，对应 Kotlin 的 RoundedCornerShape
interface ShapeTokens {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

// 间距令牌，对应 Kotlin 的 Dp
interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  // 将 Kotlin 的 0xFFRRGGBB 格式颜色转换为 ArkUI 的十六进制颜色字符串
  static readonly Colors: ColorTokens = {
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

  // 将 Kotlin 的 TextStyle 转换为 ArkUI 的字体大小与字重
  static readonly TypographyTokens: TypographyTokens = {
    display: { fontSize: 26, fontWeight: 700 },
    headline: { fontSize: 18, fontWeight: 600 },
    title: { fontSize: 14, fontWeight: 500 },
    body: { fontSize: 12, fontWeight: 400 }
  };

  // 将 Kotlin 的 RoundedCornerShape 转换为 ArkUI 的圆角半径（vp）
  static readonly Shapes: ShapeTokens = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  };

  // 将 Kotlin 的 Dp 转换为 ArkUI 的间距（vp）
  static readonly Spacing: SpacingTokens = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  };
}

// 二维坐标点
interface CanvasPoint {
  x: number;
  y: number;
}

// MARK: - ParcelCanvas
// 对应 Kotlin 的 ParcelCanvas Composable 函数
@Component
struct ParcelCanvas {
  // @State 用于管理视图内部的可变状态
  @State dragOffset: CanvasPoint = { x: 0, y: 0 }; // 拖动圆圈的当前位置
  @State parcelPoints: CanvasPoint[] = []; // 散布的包裹点
  @State containerWidth: number = 0; // 容器实际宽度
  @State containerHeight: number = 0; // 容器实际高度
  @State initialized: boolean = false; // 是否已完成初始化

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // 辅助函数：生成随机点，确保它们在给定的宽度和高度范围内
  private generateRandomPoints(width: number, height: number): CanvasPoint[] {
    let points: CanvasPoint[] = [];
    for (let i = 0; i < 25; i++) {
      points.push({ x: Math.random() * width, y: Math.random() * height });
    }
    return points;
  }

  // 有效绘制区域宽度（扣除内部 padding）
  private effectiveCanvasWidth(): number {
    return this.containerWidth - AppTokens.Spacing.md * 2;
  }

  // 有效绘制区域高度（扣除内部 padding）
  private effectiveCanvasHeight(): number {
    return this.containerHeight - AppTokens.Spacing.md * 2;
  }

  // 在 Canvas 上绘制所有包裹点与可拖动的中心圆圈
  private drawScene(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    // 绘制所有包裹点
    for (let i = 0; i < this.parcelPoints.length; i++) {
      let point: CanvasPoint = this.parcelPoints[i];
      // 绘制一个半径为 4 的圆形
      this.context.beginPath();
      this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
      this.context.fillStyle = AppTokens.Colors.secondary;
      this.context.fill();
    }
    // 绘制可拖动的中心圆圈（半径 20）
    this.context.beginPath();
    this.context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, Math.PI * 2);
    this.context.strokeStyle = AppTokens.Colors.primary;
    this.context.lineWidth = 3;
    this.context.stroke();
  }

  build() {
    // Stack 用于将 Canvas 和 Text 叠加在一起
    Stack() {
      // ArkUI 的 Canvas 组件，用于自定义绘图
      Canvas(this.context)
        .width('100%')
        .height('100%')
        // Canvas 内部的 padding，对应 Kotlin 的 .padding(10.dp)
        .padding(AppTokens.Spacing.md)
        .onReady(() => {
          this.drawScene();
        });

      // 提示文本
      Text('Drag to locate parcel')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface);
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
    // 获取容器实际尺寸，用于精确布局和拖动范围限制
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.containerWidth = Number(newValue.width);
      this.containerHeight = Number(newValue.height);
      // 视图首次出现时执行初始化：生成随机点和拖动圆圈的初始位置
      if (!this.initialized && this.containerWidth > 0 && this.containerHeight > 0) {
        this.initialized = true;
        let w = this.effectiveCanvasWidth();
        let h = this.effectiveCanvasHeight();
        // 初始化包裹点，确保它们在 Canvas 的有效绘制区域内
        this.parcelPoints = this.generateRandomPoints(w, h);
        // 初始化拖动圆圈的初始位置，确保它也在有效绘制区域内
        this.dragOffset = {
          x: 20 + Math.random() * (w - 40),
          y: 20 + Math.random() * (h - 40)
        };
        this.drawScene();
      }
    })
    // 添加拖动手势
    .gesture(
      PanGesture({ fingers: 1 })
        .onActionUpdate((event: GestureEvent) => {
          if (event.fingerList.length > 0) {
            // 更新拖动偏移量，并限制其在 Canvas 的有效绘制区域内
            // 20 是拖动圆圈的半径，用于确保圆圈完全在边界内
            this.dragOffset = {
              x: Math.max(20, Math.min(event.fingerList[0].localX, this.effectiveCanvasWidth() - 20)),
              y: Math.max(20, Math.min(event.fingerList[0].localY, this.effectiveCanvasHeight() - 20))
            };
            this.drawScene();
          }
        })
    );
  }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable 函数
// 对应 SwiftUI 的 @main App 入口：在 ArkUI 中使用 @Entry 标注根组件
@Entry
@Component
struct RootScreen {
  build() {
    // Column 对应 Kotlin 的 Column，用于垂直排列子视图
    Column({ space: AppTokens.Spacing.xl }) { // 对应 Kotlin 的 Arrangement.spacedBy(AppTokens.Spacing.xl)
      Text('Parcel Tracker')
        .fontSize(AppTokens.TypographyTokens.display.fontSize) // 对应 Kotlin 的 MaterialTheme.typography.displayLarge
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground); // 对应 Kotlin 的 AppTokens.Colors.onBackground

      // ParcelCanvas 实例
      ParcelCanvas();

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.body.fontSize) // 对应 Kotlin 的 MaterialTheme.typography.bodyMedium
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface); // 对应 Kotlin 的 AppTokens.Colors.onSurface
    }
    // 填充所有可用空间，对应 Kotlin 的 .fillMaxSize()
    .width('100%')
    .height('100%')
    // 背景渐变，对应 Kotlin 的 Brush.verticalGradient
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
    // 整个 RootScreen 的外部 padding，对应 Kotlin 的 .padding(AppTokens.Spacing.lg)
    .padding(AppTokens.Spacing.lg)
    // 忽略安全区域，使内容全屏显示，包括状态栏和导航栏下方
    .expandSafeArea();
  }
}
