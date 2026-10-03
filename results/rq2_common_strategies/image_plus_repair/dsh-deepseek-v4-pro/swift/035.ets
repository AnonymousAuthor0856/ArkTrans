// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范

// Swift: AppTokens.Colors -> ArkTS: AppColors
class AppColors {
  static readonly primary: string = '#2563EB' // 0xFF2563EB
  static readonly secondary: string = '#60A5FA' // 0xFF60A5FA
  static readonly tertiary: string = '#93C5FD' // 0xFF93C5FD
  static readonly background: string = '#F8FAFC' // 0xFFF8FAFC
  static readonly surface: string = '#FFFFFF' // 0xFFFFFFFF
  static readonly surfaceVariant: string = '#E2E8F0' // 0xFFE2E8F0
  static readonly outline: string = '#CBD5E1' // 0xFFCBD5E1
  static readonly success: string = '#22C55E' // 0xFF22C55E
  static readonly warning: string = '#F59E0B' // 0xFFF59E0B
  static readonly error: string = '#EF4444' // 0xFFEF4444
  static readonly onPrimary: string = '#FFFFFF' // 0xFFFFFFFF
  static readonly onSecondary: string = '#1E3A8A' // 0xFF1E3A8A
  static readonly onTertiary: string = '#1E40AF' // 0xFF1E40AF
  static readonly onBackground: string = '#0F172A' // 0xFF0F172A
  static readonly onSurface: string = '#0F172A' // 0xFF0F172A
}

// Swift: AppTokens.TypographyTokens -> ArkTS: TypographyTokens
class TypographyTokens {
  // Kotlin的displayLarge映射到28sp Bold，titleMedium映射到18sp Medium，bodyMedium映射到14sp Normal，labelMedium映射到12sp Medium。
  static readonly display: Font = { size: 28, weight: FontWeight.Bold }
  static readonly title: Font = { size: 18, weight: FontWeight.Medium }
  static readonly body: Font = { size: 14, weight: FontWeight.Regular } // Kotlin's FontWeight.Normal maps to .regular
  static readonly label: Font = { size: 12, weight: FontWeight.Medium }
}

// Swift: AppTokens.Shapes -> ArkTS: AppShapes
class AppShapes {
  static readonly small: number = 4.0
  static readonly medium: number = 8.0
  static readonly large: number = 16.0
}

// Swift: AppTokens.Spacing -> ArkTS: AppSpacing
class AppSpacing {
  static readonly sm: number = 6.0
  static readonly md: number = 10.0
  static readonly lg: number = 14.0
  static readonly xl: number = 20.0
  static readonly xxl: number = 28.0
}

// 阴影规范，用于映射到 SwiftUI 的 shadow 修饰符
class ShadowSpec {
  elevation: number // 在 SwiftUI shadow 中通常映射到 blur radius 或作为整体阴影强度参考
  radius: number    // SwiftUI shadow 的 blur radius
  dy: number        // SwiftUI shadow 的 y 偏移
  opacity: number   // SwiftUI shadow 颜色透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2.0, 4.0, 2.0, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6.0, 8.0, 4.0, 0.18)
}

// MARK: - CustomLinearProgressViewStyle
// 自定义 ProgressView 样式，以匹配 Kotlin 的 LinearProgressIndicator 颜色和圆角
@Component
struct CustomLinearProgress {
  @Prop tint: string = '#2563EB' // 进度条颜色
  @Prop trackColor: string = '#E2E8F0' // 轨道颜色
  @Prop progress: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 轨道背景
      Column()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.trackColor)

      // 进度条
      Column()
        .width(`${this.progress * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.tint)
    }
    .width('100%')
    .height(8) // 确保整个 ProgressView 的高度为 8
  }
}

// MARK: - RootScreen
// 主 UI 视图，对应 Kotlin 的 RootScreen Composable
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5 // 对应 Kotlin 的 mutableFloatStateOf
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  // 绘制正弦波形 K-Line 图
  private drawChart(): void {
    const ctx = this.canvasCtx
    const width = ctx.width
    const height = ctx.height
    const step = width / 50.0 // 50 个步长
    ctx.clearRect(0, 0, width, height)
    ctx.beginPath()
    // 移动到起始点
    ctx.moveTo(0, height / 2.0)
    // 绘制正弦波形
    for (let i = 0; i <= 50; i++) {
      const x = i * step
      // 对应 Kotlin 的 sin(i * PI / 8 + progress * PI).toFloat() * (height / 3)
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0)
      ctx.lineTo(x, y)
    }
    // 描边路径
    ctx.strokeStyle = AppColors.primary
    ctx.lineWidth = 4
    ctx.stroke()
  }

  build() {
    // 对应 Kotlin 的 Scaffold，使用 Column 模拟顶部栏和内容区域
    Column() {
      // 顶部栏 (CenterAlignedTopAppBar 对应)
      Stack() {
        Column()
          .width('100%')
          .height(56) // 默认 AppBar 高度
          .backgroundColor(AppColors.background)

        Text('Stock K-Line')
          .font(TypographyTokens.display)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      // 扩展背景到顶部安全区域，以覆盖状态栏
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      // 主内容区域 (对应 Kotlin 的 Column)
      Column({ space: AppSpacing.lg }) {
        // 用于图表的 Surface
        Stack() { // 使用 Stack 来应用背景、圆角和阴影
          // 背景圆角矩形，应用阴影，根据 Kotlin 的 ElevationMapping.level2
          Column()
            .width('100%')
            .height('100%')
            .borderRadius(AppShapes.large)
            .backgroundColor(AppColors.surface)
            .shadow({
              radius: ElevationMapping.level2.radius,
              color: '#1F0F172A', // AppColors.onBackground.opacity(0.12)
              offsetX: 0, // Kotlin 的 ShadowSpec 没有 dx，所以 x 偏移为 0
              offsetY: ElevationMapping.level2.dy
            })

          // Canvas 用于绘制 K-Line 图
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .padding(AppSpacing.lg) // Canvas 内部的内边距
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%') // 填充宽度
        .height(260) // 固定高度 260.dp
        .borderRadius(AppShapes.large) // 确保 Stack 的内容也应用圆角

        Text('Market Trend')
          .font(TypographyTokens.title)
          .fontColor(AppColors.primary)

        // Slider 控件
        // 根据 UI 效果图，滑块和活跃轨道颜色为 primary
        Slider({ value: this.progress, min: 0, max: 1 })
          .selectedColor(AppColors.primary) // 设置滑块和活跃轨道的颜色
          .onChange((value: number) => {
            this.progress = value
            this.drawChart()
          })
          .width('100%') // 填充宽度
          .height(44) // 为 Slider 提供一个标准的可触摸高度

        // LinearProgressIndicator 控件
        CustomLinearProgress({ tint: AppColors.primary, trackColor: AppColors.surfaceVariant, progress: this.progress })
          .width('100%') // 填充宽度
          .height(8) // 确保 ProgressView 的外部高度也是 8
      }
      .width('100%')
      .layoutWeight(1) // 填充剩余空间
      .padding(AppSpacing.lg) // Column 内部的内边距
      // 背景渐变 (Brush.verticalGradient 对应)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0], // AppColors.secondary.opacity(0.15)
          [AppColors.background, 0.5],
          ['#262563EB', 1.0] // AppColors.primary.opacity(0.15)
        ]
      })
    }
    .width('100%')
    .height('100%')
    // 整个视图的背景色 (Scaffold 的 containerColor 对应)
    .backgroundColor(AppColors.background)
  }
}

// MARK: - Main App Entry Point
// SwiftUI 应用程序的入口点，对应 Kotlin 的 MainActivity。
// 在 ArkTS 中，单页面由 @Entry 标记的 RootScreen 直接作为应用入口，WindowGroup/statusBarHidden 语义由页面级属性承担。

// MARK: - Helper Extension
// 辅助扩展，用于将 Double 转换为 CGFloat，因为 sin 函数返回 Double。
// ArkTS 使用 number 统一表示数值类型，Math.sin 返回 number，无需额外转换。
