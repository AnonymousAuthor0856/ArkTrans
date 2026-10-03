import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { UIAbilityContext } from '@kit.AbilityKit';
import { CanvasRenderingContext2D, DrawTask } from '@kit.ArkGraphics';

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范
class AppTokens {
  static Colors = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#93C5FD',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E3A8A',
    onTertiary: '#1E40AF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
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

  // 阴影规范
  static ElevationMapping = {
    level1: { radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { radius: 8.0, dy: 4.0, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private context: UIAbilityContext = getContext(this) as UIAbilityContext;

  aboutToAppear() {
    // 隐藏状态栏，实现全屏显示效果
    let windowClass: window.Window | null = null;
    window.getWindow(this.context, (err: BusinessError, data: window.Window) => {
      if (err.code > 0) {
        console.error(`Failed to get the window. Cause:${err.message}`);
        return;
      }
      windowClass = data;
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column() {
      // 顶部栏 (CenterAlignedTopAppBar 对应)
      Row() {
        Text('Stock K-Line')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // 主内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 用于图表的 Surface
        Stack() {
          // Canvas 用于绘制 K-Line 图
          CanvasRenderingContext2D()
            .drawTask(new DrawTask((context: CanvasRenderingContext2D, canvas: CanvasRenderingContext2D) => {
              const width = canvas.width;
              const height = canvas.height;
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

              context.strokeStyle = AppTokens.Colors.primary;
              context.lineWidth = 4;
              context.stroke();
            }))
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
            .layoutWeight(1)
        }
        .width('100%')
        .height(260)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: Color.Transparent, // ArkTS shadow color is complex, using transparent with blur usually mimics elevation or specific color logic
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        // Note: ArkTS Shadow implementation differs slightly from SwiftUI. 
        // To strictly match the "onBackground" opacity shadow, we might need a custom shape or accept standard system shadow.
        // Here we apply a standard shadow effect.
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: '#0000001C', // Approximating 0.12 opacity black
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Market Trend')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(AppTokens.Colors.primary)

        // Slider 控件
        Slider({ value: this.progress, min: 0, max: 1 })
          .width('100%')
          .trackThickness(8)
          .selectedColor(AppTokens.Colors.primary)
          .blockColor(AppTokens.Colors.primary)
          .height(44)

        // LinearProgressIndicator 控件
        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      // 背景渐变
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(96, 165, 250, 0.15)', 0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(37, 99, 235, 0.15)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}