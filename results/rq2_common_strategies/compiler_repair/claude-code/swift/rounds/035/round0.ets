import { Color, FontWeight, ProgressType, SliderStyle, GradientDirection, Area } from '@ohos.arkui'

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范
class AppTokens {
  static readonly Colors = class {
    static readonly primary: ResourceColor = 0xFF2563EB
    static readonly secondary: ResourceColor = 0xFF60A5FA
    static readonly tertiary: ResourceColor = 0xFF93C5FD
    static readonly background: ResourceColor = 0xFFF8FAFC
    static readonly surface: ResourceColor = 0xFFFFFFFF
    static readonly surfaceVariant: ResourceColor = 0xFFE2E8F0
    static readonly outline: ResourceColor = 0xFFCBD5E1
    static readonly success: ResourceColor = 0xFF22C55E
    static readonly warning: ResourceColor = 0xFFF59E0B
    static readonly error: ResourceColor = 0xFFEF4444
    static readonly onPrimary: ResourceColor = 0xFFFFFFFF
    static readonly onSecondary: ResourceColor = 0xFF1E3A8A
    static readonly onTertiary: ResourceColor = 0xFF1E40AF
    static readonly onBackground: ResourceColor = 0xFF0F172A
    static readonly onSurface: ResourceColor = 0xFF0F172A
  }

  static readonly TypographyTokens = class {
    static readonly displaySize: Length = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly titleSize: Length = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodySize: Length = 14
    static readonly bodyWeight: FontWeight = FontWeight.Normal
    static readonly labelSize: Length = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static readonly Shapes = class {
    static readonly small: Length = 4
    static readonly medium: Length = 8
    static readonly large: Length = 16
  }

  static readonly Spacing = class {
    static readonly sm: Length = 6
    static readonly md: Length = 10
    static readonly lg: Length = 14
    static readonly xl: Length = 20
    static readonly xxl: Length = 28
  }

  static readonly ElevationMapping = class {
    static readonly level1 = { radius: 4, dy: 2, opacity: 0.12 }
    static readonly level2 = { radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - StockKLineChart
// K线图组件，使用Canvas绘制正弦波形
@Component
struct StockKLineChart {
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  @Link progress: number
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0
  private isCanvasReady: boolean = false

  private drawChart() {
    if (!this.isCanvasReady || this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }
    const ctx = this.canvasContext
    const width: number = this.canvasWidth
    const height: number = this.canvasHeight
    const step: number = width / 50.0

    ctx.clearRect(0, 0, width, height)
    ctx.beginPath()

    const startY: number = height / 2.0 + Math.sin(0 + this.progress * Math.PI) * (height / 3.0)
    ctx.moveTo(0, startY)

    for (let i: number = 0; i <= 50; i++) {
      const x: number = i * step
      const y: number = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0)
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = AppTokens.Colors.primary as string
    ctx.lineWidth = 4
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'
    ctx.stroke()
  }

  build() {
    Canvas(this.canvasContext)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.isCanvasReady = true
        this.drawChart()
      })
      .onAreaChange((oldArea: Area, newArea: Area) => {
        this.canvasWidth = newArea.width as number
        this.canvasHeight = newArea.height as number
        if (this.isCanvasReady) {
          this.drawChart()
        }
      })
  }
}

// MARK: - CustomLinearProgress
// 自定义进度条组件，匹配Kotlin的LinearProgressIndicator颜色和圆角
@Component
struct CustomLinearProgress {
  @Link progress: number
  private tint: ResourceColor = AppTokens.Colors.primary
  private trackColor: ResourceColor = AppTokens.Colors.surfaceVariant

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
// 顶部应用栏组件
@Component
struct TopAppBar {
  private title: string = 'Stock K-Line'

  build() {
    Stack() {
      Text(this.title)
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - RootScreen
// 主UI视图，对应Kotlin的RootScreen Composable和SwiftUI的RootScreen
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5
  private canvasChartRef: StockKLineChart | null = null

  private onProgressChange(value: number) {
    this.progress = value
  }

  build() {
    Column() {
      TopAppBar()

      Column() {
        // Chart Surface Card
        Stack() {
          StockKLineChart({ progress: $progress })
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 0x2E0F172A,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Market Trend')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        // Slider Control
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
            this.onProgressChange(value)
          })

        // Linear Progress Indicator
        CustomLinearProgress({ progress: $progress })
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
          [0x2660A5FA, 0],
          [AppTokens.Colors.background, 0.5],
          [0x262563EB, 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
