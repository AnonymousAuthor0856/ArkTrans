import { drawing, PixelMap } from '@kit.ArkGraphics';
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 统一的 UI 令牌，方便修改颜色、字体、间距和形状
class AppTokens {
  static Colors = {
    primary: '#FFA500', // #FFA500
    secondary: '#FFC107', // #FFC107
    tertiary: '#FFE066', // #FFE066
    background: '#FFFBF2', // #FFFBF2
    surface: '#FFFFFF', // #FFFFFF
    surfaceVariant: '#FFEED6', // #FFEED6
    outline: '#F1C27D', // #F1C27D
    success: '#22C55E', // #22C55E
    warning: '#F59E0B', // #F59E0B
    error: '#EF4444', // #EF4444
    onPrimary: '#FFFFFF', // #FFFFFF
    onSecondary: '#1E1E1E', // #1E1E1E
    onTertiary: '#1E1E1E', // #1E1E1E
    onBackground: '#1E1E1E', // #1E1E1E
    onSurface: '#1E1E1E' // #1E1E1E
  };

  static TypographyTokens = {
    display: { size: 28, weight: 'bold' },
    title: { size: 18, weight: 'medium' },
    body: { size: 14, weight: 'regular' },
    label: { size: 12, weight: 'medium' }
  };

  static Shapes = {
    small: 6.0,
    medium: 12.0,
    large: 20.0
  };

  static Spacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0
  };

  static ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3; // 支付进度状态

  build() {
    Column() {
      // 顶部栏 (对应 Compose 的 CenterAlignedTopAppBar)
      Text('Installment Plan')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
        .foregroundColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(60) // ArkUI 默认状态栏高度约为 60vp
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域 (对应 Compose Scaffold 的 content lambda)
      Column({ space: AppTokens.Spacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: this.paymentProgress })

        Text('Payment Progress')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .foregroundColor(AppTokens.Colors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant,
          height: 8
        })
        .width('100%') // 填充宽度

        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .blockColor(AppTokens.Colors.secondary)
          .width('100%') // 填充宽度

        Button('Reset Progress', { type: ButtonType.Normal, stateEffect: false })
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .foregroundColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48) // 按钮高度
          .backgroundColor(AppTokens.Colors.tertiary) // 按钮背景色
          .borderRadius(AppTokens.Shapes.medium) // 按钮圆角
          .onClick(() => {
            this.paymentProgress = 0.0; // 重置进度
          })
      }
      .padding(AppTokens.Spacing.lg) // 内容区域的内边距
      .width('100%')
      .layoutWeight(1) // 填充剩余空间
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.secondary, 0.25],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.25]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // 整个屏幕的背景色 (Scaffold containerColor)
    .systemBarProperties({ statusBarContentColor: '#FFFFFF' }) // 设置状态栏文字颜色为白色
  }
}

// MARK: - Main UI Components

/// 包含 Canvas 绘图的 Surface 区域
@Component
struct SurfaceWithCanvas {
  @Link paymentProgress: number;

  build() {
    Stack() {
      // Surface 背景和阴影
      Rect()
        .fill(Color.White.opacity(0.9))
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: Color.Black.opacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .height(240) // 固定高度，与 Kotlin 版本一致
        .width('100%')

      // Canvas 绘图区域
      CanvasRenderingContext2D()
        .onReady((context: CanvasRenderingContext2D) => {
          const w = context.canvas.width;
          const h = context.canvas.height;
          const step = w / 20; // 20 个步长

          context.beginPath();
          
          // 计算第一个点 (x=0) 的 Y 坐标，并移动到该点
          const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
          context.moveTo(0, initialY);

          // 绘制后续的线段，从 i=1 开始
          for (let i = 1; i <= 20; i++) {
            const x = i * step;
            const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
            context.lineTo(x, y);
          }
          context.strokeStyle = AppTokens.Colors.primary;
          context.lineWidth = 5;
          context.stroke();
        })
        .padding(AppTokens.Spacing.lg) // Canvas 内部的内边距
        .height(240) // 确保 Canvas 占据其父 Surface 的全部高度
        .width('100%')
    }
    .width('100%') // 填充父 Column 的宽度
  }
}

// MARK: - Custom ArkTS Components

/// 自定义线性进度指示器，以匹配 Compose 版本的颜色和高度
@Component
struct CustomLinearProgressIndicator {
  progress: number;
  color: string;
  trackColor: string;
  height: number;

  build() {
    Row() {
      // 背景轨道
      Rect()
        .fill(this.trackColor)
        .borderRadius(this.height / 2)
        .width('100%')
        .height(this.height)

      // 进度条
      Rect()
        .fill(this.color)
        .borderRadius(this.height / 2)
        .width(`${this.progress * 100}%`)
        .height(this.height)
    }
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.Start)
    .clip(true)
  }
}