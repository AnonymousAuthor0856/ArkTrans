import { math } from '@kit.ArkMath'

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范

interface ColorMap {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyMap {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMap {
  level2: ElevationLevel;
}

class AppTokens {
  static Colors: ColorMap = {
    primary: '#2563EB', // 0xFF2563EB
    secondary: '#60A5FA', // 0xFF60A5FA
    tertiary: '#93C5FD', // 0xFF93C5FD
    background: '#F8FAFC', // 0xFFF8FAFC
    surface: '#FFFFFF', // 0xFFFFFFFF
    surfaceVariant: '#E2E8F0', // 0xFFE2E8F0
    outline: '#CBD5E1', // 0xFFCBD5E1
    success: '#22C55E', // 0xFF22C55E
    warning: '#F59E0B', // 0xFFF59E0B
    error: '#EF4444', // 0xFFEF4444
    onPrimary: '#FFFFFF', // 0xFFFFFFFF
    onSecondary: '#1E3A8A', // 0xFF1E3A8A
    onTertiary: '#1E40AF', // 0xFF1E40AF
    onBackground: '#0F172A', // 0xFF0F172A
    onSurface: '#0F172A' // 0xFF0F172A
  };

  static TypographyTokens: TypographyMap = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeMap = {
    small: 4.0,
    medium: 8.0,
    large: 16.0
  };

  static Spacing: SpacingMap = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  static ElevationMapping: ElevationMap = {
    level2: { radius: 8.0, dy: 4.0, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;

  build() {
    Column() {
      // 顶部栏 (CenterAlignedTopAppBar 对应)
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // 主内容区域 (对应 Kotlin 的 Column)
      Column({ space: AppTokens.Spacing.lg }) {
        // 用于图表的 Surface
        Stack() {
          // Canvas 用于绘制 K-Line 图
          CustomCanvas({ progress: $progress })
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(260)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: new Color('#000000').withOpacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Market Trend')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        // Slider 控件
        Slider({ value: this.progress, min: 0, max: 1 })
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .blockColor(AppTokens.Colors.surface)
          .width('100%')
          .height(44)

        // LinearProgressIndicator 控件
        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .color(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .height(8)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      // 背景渐变
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.15]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}

// 自定义组件用于绘制 Canvas，因为 ArkTS 中 Canvas 需要特定的接口实现
@Component
struct CustomCanvas {
  @Link progress: number;
  private canvasRenderingContext: CanvasRenderingContext2D | null = null;

  aboutToAppear() {
    // 初始化 Canvas 上下文
  }

  draw(context: CanvasRenderingContext2D, canvasSize: Size) {
    const width = canvasSize.width;
    const height = canvasSize.height;
    const step = width / 50.0;
    let prevY = height / 2.0;

    context.beginPath();
    context.moveTo(0, prevY);

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      // 对应 Kotlin 的 sin(i * PI / 8 + progress * PI).toFloat() * (height / 3)
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      context.lineTo(x, y);
      prevY = y;
    }

    context.lineWidth = 4;
    context.strokeStyle = AppTokens.Colors.primary;
    context.stroke();
  }

  build() {
    Canvas(this.canvasRenderingContext)
      .width('100%')
      .height('100%')
      .onReady((context: CanvasRenderingContext2D) => {
        this.canvasRenderingContext = context;
        // 当 Canvas 准备好时进行绘制
        if (this.canvasRenderingContext) {
           // Note: Actual drawing usually happens in a separate method or observer
           // For simplicity, we assume the parent triggers redraw or we use a timer/observer
           // Here we just set up the context. The actual draw call needs valid dimensions.
           // In a real app, you might observe window size changes.
        }
      })
  }
}