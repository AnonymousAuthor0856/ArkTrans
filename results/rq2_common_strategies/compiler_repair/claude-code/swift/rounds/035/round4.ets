// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#2563EB'
    export const secondary: string = '#60A5FA'
    export const tertiary: string = '#93C5FD'
    export const background: string = '#F8FAFC'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E2E8F0'
    export const outline: string = '#CBD5E1'
    export const success: string = '#22C55E'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#1E3A8A'
    export const onTertiary: string = '#1E40AF'
    export const onBackground: string = '#0F172A'
    export const onSurface: string = '#0F172A'
  }

  export namespace Typography {
    export const displaySize: number = 28
    export const displayWeight: FontWeight = FontWeight.Bold
    export const titleSize: number = 18
    export const titleWeight: FontWeight = FontWeight.Medium
    export const bodySize: number = 14
    export const bodyWeight: FontWeight = FontWeight.Normal
    export const labelSize: number = 12
    export const labelWeight: FontWeight = FontWeight.Medium
  }

  export namespace Shapes {
    export const small: number = 4
    export const medium: number = 8
    export const large: number = 16
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 14
    export const xl: number = 20
    export const xxl: number = 28
  }

  export interface ShadowSpec {
    radius: number
    dy: number
    opacity: number
  }

  export namespace Elevation {
    export const level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.12 }
    export const level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - StockKLineChart
// K线图组件，使用Canvas绘制正弦波形
@Component
struct StockKLineChart {
  @Prop progress: number = 0.5
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0
  private isReady: boolean = false

  private drawChart(): void {
    if (!this.isReady || this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }
    const ctx: CanvasRenderingContext2D = this.canvasContext
    const w: number = this.canvasWidth
    const h: number = this.canvasHeight
    const step: number = w / 50.0

    ctx.clearRect(0, 0, w, h)
    ctx.beginPath()

    const startY: number = h / 2.0 + Math.sin(this.progress * Math.PI) * (h / 3.0)
    ctx.moveTo(0, startY)

    for (let i: number = 0; i <= 50; i++) {
      const x: number = i * step
      const y: number = h / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (h / 3.0)
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 4
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'
    ctx.stroke()
  }

  aboutToUpdate(): void {
    if (this.isReady) {
      this.drawChart()
    }
  }

  build() {
    Canvas(this.canvasContext)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.isReady = true
        this.drawChart()
      })
      .onAreaChange((oldArea, newArea) => {
        this.canvasWidth = newArea.width as number
        this.canvasHeight = newArea.height as number
        if (this.isReady) {
          this.drawChart()
        }
      })
  }
}

// MARK: - CustomLinearProgress
// 自定义线形进度条，匹配Kotlin LinearProgressIndicator的颜色和圆角
@Component
struct CustomLinearProgress {
  @Prop progress: number = 0
  @Prop tint: string = AppTokens.Colors.primary
  @Prop trackColor: string = AppTokens.Colors.surfaceVariant

  build() {
    Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
      .width('100%')
      .height(8)
      .color(this.tint)
      .backgroundColor(this.trackColor)
      .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - TopAppBar
// 顶部应用栏
@Component
struct TopAppBar {
  @Prop title: string = 'Stock K-Line'

  build() {
    Stack() {
      Text(this.title)
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - RootScreen
// 主界面，对应SwiftUI的RootScreen和Kotlin的RootScreen Composable
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5

  build() {
    Column() {
      TopAppBar({ title: 'Stock K-Line' })

      Column({ space: AppTokens.Spacing.lg }) {
        // Chart Surface Card
        Stack() {
          StockKLineChart({ progress: this.progress })
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: 'rgba(15, 23, 42, 0.18)',
          offsetX: 0,
          offsetY: AppTokens.Elevation.level2.dy
        })

        Text('Market Trend')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value
          })

        // Linear Progress Indicator
        CustomLinearProgress({
          progress: this.progress,
          tint: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant
        })
          .width('100%')
          .height(8)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
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
