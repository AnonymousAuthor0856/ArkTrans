// 由 SwiftUI 源文件翻译为 ArkTS (ArkUI 声明式 UI)。
// import SwiftUI / CoreGraphics / UIKit 在 ArkTS 中无需显式导入；
// ArkUI 组件、绘图 API 及全局枚举均可用。

// MARK: - 字体令牌类型
class FontToken {
  size: number
  weight: FontWeight
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

// MARK: - AppTokens
// 统一的 UI 令牌，方便修改颜色、字体、间距和形状
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFA500' // #FFA500
    export const secondary: string = '#FFC107' // #FFC107
    export const tertiary: string = '#FFE066' // #FFE066
    export const background: string = '#FFFBF2' // #FFFBF2
    export const surface: string = '#FFFFFF' // #FFFFFF
    export const surfaceVariant: string = '#FFEED6' // #FFEED6
    export const outline: string = '#F1C27D' // #F1C27D
    export const success: string = '#22C55E' // #22C55E
    export const warning: string = '#F59E0B' // #F59E0B
    export const error: string = '#EF4444' // #EF4444
    export const onPrimary: string = '#FFFFFF' // #FFFFFF
    export const onSecondary: string = '#1E1E1E' // #1E1E1E
    export const onTertiary: string = '#1E1E1E' // #1E1E1E
    export const onBackground: string = '#1E1E1E' // #1E1E1E
    export const onSurface: string = '#1E1E1E' // #1E1E1E
  }

  export namespace TypographyTokens {
    export const display: FontToken = new FontToken(28, FontWeight.Bold)
    export const title: FontToken = new FontToken(18, FontWeight.Medium)
    export const body: FontToken = new FontToken(14, FontWeight.Regular) // Kotlin's FontWeight.Normal maps to .regular
    export const label: FontToken = new FontToken(12, FontWeight.Medium)
  }

  export namespace Shapes {
    export const small: number = 6.0
    export const medium: number = 12.0
    export const large: number = 20.0
  }

  export namespace Spacing {
    export const sm: number = 8.0
    export const md: number = 12.0
    export const lg: number = 16.0
    export const xl: number = 24.0
    export const xxl: number = 32.0
  }

  // Compose ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
  // SwiftUI shadow(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
  // We map Compose's `radius` to ArkUI's `radius` (blur radius) and `dy` to `offsetY`.
  export class ShadowSpec {
    radius: number // Blur radius
    dy: number     // Y offset
    opacity: number // Shadow color opacity
    constructor(radius: number, dy: number, opacity: number) {
      this.radius = radius
      this.dy = dy
      this.opacity = opacity
    }
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = new ShadowSpec(4, 2, 0.12)
    export const level2: ShadowSpec = new ShadowSpec(8, 4, 0.18)
  }
}

// MARK: - Helper Extensions
// 将 Double 转换为 CGFloat，用于绘图（ArkTS 中 number 即浮点，此转换为恒等操作）
function toCGFloat(value: number): number {
  return value
}

// MARK: - Custom ArkUI Components

// 自定义线性进度指示器，以匹配 Compose 版本的颜色和高度
@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  barColor: string = ''
  trackColor: string = ''
  barHeight: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 背景轨道
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      // 进度条
      Row()
        .width((this.progress * 100).toString() + '%')
        .height(this.barHeight)
        .backgroundColor(this.barColor)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// 自定义滑块，使用原生 Slider 组件封装，以精确控制滑块拇指颜色
@Component
struct CustomSlider {
  @Link value: number
  activeTrackColor: string = ''
  inactiveTrackColor: string = ''
  thumbColor: string = ''

  build() {
    Slider({ value: this.value, min: 0, max: 1, style: SliderStyle.OutSet })
      .selectedColor(this.activeTrackColor)
      .trackColor(this.inactiveTrackColor)
      .blockColor(this.thumbColor)
      .onChange((value: number, mode: SliderChangeMode) => {
        this.value = value
      })
  }
}

// MARK: - Main UI Components

// 包含 Canvas 绘图的 Surface 区域
@Component
struct SurfaceWithCanvas {
  @Link @Watch('onProgressChanged') paymentProgress: number
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private isReady: boolean = false

  build() {
    Stack() {
      // Surface 背景和阴影
      Row()
        .width('100%')
        .height(240) // 固定高度，与 Kotlin 版本一致
        .backgroundColor(AppTokens.Colors.surface)
        .opacity(0.9)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level2.opacity + ')',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

      // Canvas 绘图区域
      Canvas(this.context)
        .width('100%')
        .height(240) // 确保 Canvas 占据其父 Surface 的全部高度
        .padding(AppTokens.Spacing.lg) // Canvas 内部的内边距
        .onReady(() => {
          this.isReady = true
          this.drawWave()
        })
    }
    .width('100%')
  }

  onProgressChanged() {
    if (this.isReady) {
      this.drawWave()
    }
  }

  drawWave() {
    const w = this.context.width
    const h = this.context.height
    const step = w / 20 // 20 个步长

    // 计算第一个点 (x=0) 的 Y 坐标，并移动到该点
    const initialY = h / 2 + toCGFloat(Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI)) * (h / 3)
    this.context.beginPath()
    this.context.moveTo(0, initialY)

    // 绘制后续的线段，从 i=1 开始
    for (let i = 1; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + toCGFloat(Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI)) * (h / 3)
      this.context.lineTo(x, y)
    }
    this.context.lineWidth = 5
    this.context.strokeStyle = AppTokens.Colors.primary
    this.context.stroke()
  }
}

// MARK: - Root Screen
// 应用程序的根视图，包含所有 UI 元素和布局
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3 // 支付进度状态

  build() {
    Column({ space: 0 }) { // 最外层 Column，用于放置 Top Bar 和内容区域，间距为 0
      // 顶部栏 (对应 Compose 的 CenterAlignedTopAppBar)
      Text('Installment Plan')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64) // Compose Material3 TopAppBar 的默认高度为 64.dp
        .backgroundColor(AppTokens.Colors.background) // 顶部栏背景色
        .textAlign(TextAlign.Center)

      // 主要内容区域 (对应 Compose Scaffold 的 content lambda)
      Column({ space: AppTokens.Spacing.lg }) { // 内容区域内部的元素间距
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          barColor: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant,
          barHeight: 8
        })
        .width('100%') // 填充宽度

        CustomSlider({
          value: $paymentProgress,
          activeTrackColor: AppTokens.Colors.primary,
          inactiveTrackColor: AppTokens.Colors.surfaceVariant,
          thumbColor: AppTokens.Colors.secondary
        })
        .width('100%') // 填充宽度

        Button('Reset Progress')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48) // 按钮高度
          .backgroundColor(AppTokens.Colors.tertiary) // 按钮背景色
          .borderRadius(AppTokens.Shapes.medium) // 按钮圆角
          .onClick(() => {
            this.paymentProgress = 0.0 // 重置进度
          })
      }
      .padding(AppTokens.Spacing.lg) // 内容区域的内边距
      .width('100%')
      .layoutWeight(1) // 填充剩余空间
      .linearGradient({ // 内容区域的渐变背景
        direction: GradientDirection.Bottom,
        colors: [
          [0x40FFC107, 0.0], // AppTokens.Colors.secondary.opacity(0.25)
          [0xFFFBF2, 0.5],   // AppTokens.Colors.background
          [0x40FFA500, 1.0]  // AppTokens.Colors.primary.opacity(0.25)
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // 整个屏幕的背景色 (Scaffold containerColor)
  }
}

// MARK: - App Entry Point
// 应用程序的入口点：Swift 的 @main App 结构体映射为 ArkUI 的 @Entry 组件（见 RootScreen）。
