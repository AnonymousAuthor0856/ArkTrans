class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF93C5FD',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E3A8A',
    onTertiary: '#FF1E40AF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 16
  }
}

@Entry
@Component
struct StockKLine {
  @State progress: number = 0.5

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 320
    const h: number = 230
    const step = w / 50.0

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    const startY = h / 2.0
    ctx.moveTo(0, startY)

    for (let i = 0; i <= 50; i++) {
      const x = i * step
      const y = h / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (h / 3.0)
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = '#FF2563EB'
    ctx.lineWidth = 4
    ctx.stroke()
  }

  build() {
    Column() {
      Stack() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(14)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#2E0F172A', offsetX: 0, offsetY: 4 })

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 14 })

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
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value
            this.drawCanvas()
          })

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .padding(14)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}