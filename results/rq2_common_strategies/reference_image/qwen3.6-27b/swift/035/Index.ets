import { MathUtils } from '@kit.ArkMath'

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范
class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 4.0,
    medium: 8.0,
    large: 16.0
  };

  static Spacing = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  static ElevationMapping = {
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
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
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
          CustomCanvas({ progress: this.progress })
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(260)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: Color.Black.opacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Market Trend')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.primary)

        // Slider 控件
        Slider({ value: this.progress, min: 0, max: 1 })
          .trackColor({ normal: AppTokens.Colors.surfaceVariant, active: AppTokens.Colors.primary })
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
      .linearGradient({
        direction: GradientDirection.Bottom,
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

interface CustomCanvasParams {
  progress: number;
}

@Component
struct CustomCanvas {
  private params: CustomCanvasParams = { progress: 0 };

  aboutToAppear(params: CustomCanvasParams) {
    this.params = params;
  }

  build() {
    Canvas(this)
      .width('100%')
      .height('100%')
  }

  draw(ctx: CanvasContext, api: CanvasApi) {
    const width = api.width;
    const height = api.height;
    const step = width / 50.0;
    let prevY = height / 2.0;

    ctx.beginPath();
    ctx.moveTo(0, prevY);

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.params.progress * Math.PI) * (height / 3.0);
      ctx.lineTo(x, y);
      prevY = y;
    }

    ctx.lineWidth = 4;
    ctx.strokeStyle = AppTokens.Colors.primary;
    ctx.stroke();
  }
}