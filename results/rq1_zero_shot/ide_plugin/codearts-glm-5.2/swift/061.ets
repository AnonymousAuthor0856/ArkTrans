class AppTokens {
  static readonly Colors = {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22,
  }
}

@Entry
@Component
struct RootScreen {
  @State dragOffsetX: number = 140
  @State dragOffsetY: number = 140
  @State parcelPoints: number[] = []
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.parcelPoints.push(Math.random())
    }
    this.dragOffsetX = 20 + Math.random() * 240
    this.dragOffsetY = 20 + Math.random() * 240
  }

  private drawCanvas() {
    const ctx = this.canvasContext
    const w = 280
    const h = 280
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.secondary
    for (let i = 0; i < 25; i++) {
      const px = this.parcelPoints[i * 2] * w
      const py = this.parcelPoints[i * 2 + 1] * h
      ctx.beginPath()
      ctx.arc(px, py, 4, 0, Math.PI * 2)
      ctx.fill()
    }

    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 3
    ctx.beginPath()
    ctx.arc(this.dragOffsetX, this.dragOffsetY, 20, 0, Math.PI * 2)
    ctx.stroke()
  }

  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
          .gesture(
            PanGesture({ distance: 0 })
              .onActionUpdate((event: GestureEvent) => {
                const x = event.fingerList[0].localX
                const y = event.fingerList[0].localY
                this.dragOffsetX = Math.max(20, Math.min(x, 260))
                this.dragOffsetY = Math.max(20, Math.min(y, 260))
                this.drawCanvas()
              })
          )

        Text('Drag to locate parcel')
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(300)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline })

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
  }
}