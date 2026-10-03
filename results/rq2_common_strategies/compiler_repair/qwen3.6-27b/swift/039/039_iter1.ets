import { Rect } from '@kit.ArkUI'

// MARK: - AppTokens
// 统一的 UI 令牌，方便修改颜色、字体、间距和形状
class AppTokens {
  static Colors = {
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
    onSurface: '#1E1E1E'
  }

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 6.0,
    medium: 12.0,
    large: 20.0
  }

  static Spacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0
  }

  // Compose ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
  // ArkTS shadow({ radius: number, offsetX: number, offsetY: number, color: string })
  static ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - Custom ArkTS Components

/// 自定义线性进度指示器，以匹配 Compose 版本的颜色和高度
@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  color: string = ''
  trackColor: string = ''
  heightValue: number = 0

  build() {
    Row() {
      // 背景轨道
      Rectangle()
        .fill(this.trackColor)
        .borderRadius(this.heightValue / 2)
        .width('100%')
        .height(this.heightValue)

      // 进度条
      Rectangle()
        .fill(this.color)
        .borderRadius(this.heightValue / 2)
        .width(`${this.progress * 100}%`)
        .height(this.heightValue)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .height(this.heightValue)
  }
}

/// 自定义滑块组件
@Component
struct CustomSlider {
  @Link value: number
  activeTrackColor: string = ''
  inactiveTrackColor: string = ''
  thumbColor: string = ''

  build() {
    Slider({
      value: this.value,
      min: 0,
      max: 1,
      step: 0.01,
      style: SliderStyle.InSet
    })
      .trackColor({
        selected: this.activeTrackColor,
        unselected: this.inactiveTrackColor
      })
      .blockColor(this.thumbColor)
      .onChange((value: number) => {
        this.value = value
      })
  }
}

// MARK: - Main UI Components

/// 包含 Canvas 绘图的 Surface 区域
@Component
struct SurfaceWithCanvas {
  @Link paymentProgress: number

  build() {
    Column() {
      // Surface 背景和阴影
      Stack() {
        // Canvas 绘图区域
        CanvasRenderingContext2D()
          .drawTask((context: CanvasRenderingContext2D, rect: Rect) => {
            const w = rect.right - rect.left
            const h = rect.bottom - rect.top
            const step = w / 20 // 20 个步长

            context.beginPath()

            // 计算第一个点 (x=0) 的 Y 坐标，并移动到该点
            const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
            context.moveTo(0, initialY)

            // 绘制后续的线段，从 i=1 开始
            for (let i = 1; i <= 20; i++) {
              const x = i * step
              const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
              context.lineTo(x, y)
            }

            context.lineWidth = 5
            context.strokeStyle = AppTokens.Colors.primary
            context.stroke()
          })
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height(240) // 固定高度，与 Kotlin 版本一致
      .backgroundColor(AppTokens.Colors.surface)
      .opacity(0.9)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`
      })
    }
    .padding(AppTokens.Spacing.lg) // Canvas 内部的内边距
    .width('100%')
  }
}

// MARK: - Root Screen
/// 应用程序的根视图，包含所有 UI 元素和布局
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3 // 支付进度状态

  build() {
    Column() {
      // 顶部栏 (对应 Compose 的 CenterAlignedTopAppBar)
      Text("Installment Plan")
        .font({
          size: AppTokens.TypographyTokens.display.size,
          weight: AppTokens.TypographyTokens.display.weight
        })
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64) // Compose Material3 TopAppBar 的默认高度为 64.dp
        .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域 (对应 Compose Scaffold 的 content lambda)
      Column() {
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text("Payment Progress")
          .font({
            size: AppTokens.TypographyTokens.title.size,
            weight: AppTokens.TypographyTokens.title.weight
          })
          .fontColor(AppTokens.Colors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant,
          heightValue: 8
        })
          .width('100%')

        CustomSlider({
          value: $paymentProgress,
          activeTrackColor: AppTokens.Colors.primary,
          inactiveTrackColor: AppTokens.Colors.surfaceVariant,
          thumbColor: AppTokens.Colors.secondary
        })
          .width('100%')

        Button("Reset Progress", {
          type: ButtonType.Normal,
          stateEffect: false
        })
          .onClick(() => {
            this.paymentProgress = 0.0 // 重置进度
          })
          .font({
            size: AppTokens.TypographyTokens.title.size,
            weight: AppTokens.TypographyTokens.title.weight
          })
          .fontColor(AppTokens.Colors.onTertiary)
          .height(48) // 按钮高度
          .backgroundColor(AppTokens.Colors.tertiary) // 按钮背景色
          .borderRadius(AppTokens.Shapes.medium) // 按钮圆角
          .width('100%')
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
    .systemBar({ statusBar: BarState.Auto }) // 处理安全区域
  }
}