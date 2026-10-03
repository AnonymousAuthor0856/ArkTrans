import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { UIAbility, Want } from '@kit.AbilityKit';
import { drawing } from '@kit.ArkGraphics';

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范

interface ColorTokens {
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

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationToken {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
}

class AppTokens {
  static Colors: ColorTokens = {
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

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeTokens = {
    small: 4.0,
    medium: 8.0,
    large: 16.0
  };

  static Spacing: SpacingTokens = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  // 阴影规范
  static ElevationMapping: ElevationMapping = {
    level1: { radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { radius: 8.0, dy: 4.0, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private context: Context | null = null;

  aboutToAppear() {
    this.context = getContext(this) as Context;
    
    // 隐藏状态栏，实现全屏显示效果
    let windowClass: window.Window | null = null;
    if (this.context) {
      window.getMainWindowSync(this.context).then((win: window.Window) => {
        windowClass = win;
        if (windowClass) {
          windowClass.setWindowSystemBarEnable([]);
        }
      }).catch((err: BusinessError) => {
        console.error(`Failed to get the window. Cause:${err.message}`);
      });
    }
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
          Canvas()
            .drawTask(new drawing.DrawTask((context: drawing.CanvasRenderingContext2D, canvas: drawing.CanvasRenderingContext2D) => {
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