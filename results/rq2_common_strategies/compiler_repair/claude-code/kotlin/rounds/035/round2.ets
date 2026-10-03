@Entry
@Component
struct StockKLine {
  @State progress: number = 0.5
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private readonly Colors = {
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
  }

  private readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }

  aboutToAppear(): void {
    this.drawChart()
  }

  drawChart(): void {
    const ctx = this.canvasCtx
    const width = 340
    const height = 200
    ctx.clearRect(0, 0, width, height)

    const step = width / 50

    ctx.strokeStyle = this.Colors.primary
    ctx.lineWidth = 4
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'
    ctx.beginPath()

    for (let i = 0; i <= 50; i++) {
      const x = i * step
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
      prevY = y
    }
    ctx.stroke()
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        // Chart surface
        Column() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height(200)
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .padding(this.Spacing.lg)
        .backgroundColor(this.Colors.surface)
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: 4
        })

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.primary)
          .margin({ top: this.Spacing.lg })

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(this.Colors.primary)
          .selectedColor(this.Colors.secondary)
          .trackColor(this.Colors.surfaceVariant)
          .width('100%')
          .margin({ top: this.Spacing.md })
          .onChange((value: number) => {
            this.progress = value
            this.drawChart()
          })

        // Linear progress indicator
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .color(this.Colors.primary)
          .backgroundColor(this.Colors.surfaceVariant)
          .width('100%')
          .height(8)
          .margin({ top: this.Spacing.md })
      }
      .width('100%')
      .padding(this.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.Colors.secondary + '26', 0.0],
        [this.Colors.background, 0.5],
        [this.Colors.primary + '26', 1.0]
      ]
    })
  }
}
