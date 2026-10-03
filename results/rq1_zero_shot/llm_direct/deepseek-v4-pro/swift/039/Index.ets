@Entry
@Component
struct InstallmentPlanApp {
  @State paymentProgress: number = 0.3

  // AppTokens
  private primary: string = '#FFA500'
  private secondary: string = '#FFC107'
  private tertiary: string = '#FFE066'
  private background: string = '#FFFBF2'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#FFEED6'
  private onSurface: string = '#1E1E1E'
  private onTertiary: string = '#1E1E1E'

  @Builder
  CustomLinearProgressIndicator(progress: number, color: string, trackColor: string, height: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(height)
        .backgroundColor(trackColor)
        .borderRadius(height / 2)

      Row()
        .width(`${progress * 100}%`)
        .height(height)
        .backgroundColor(color)
        .borderRadius(height / 2)
    }
    .width('100%')
    .height(height)
  }

  @Builder
  SurfaceWithCanvas() {
    Stack() {
      Column()
        .width('100%')
        .height(240)
        .backgroundColor(this.surface)
        .opacity(0.9)
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })

      Canvas(this.renderCanvas)
        .width('100%')
        .height(240)
        .padding(16)
    }
    .width('100%')
    .height(240)
  }

  private renderCanvas = (context: CanvasRenderingContext2D) => {
    const w = context.width
    const h = context.height
    const step = w / 20

    context.beginPath()
    context.strokeStyle = this.primary
    context.lineWidth = 5
    context.lineCap = 'round'
    context.lineJoin = 'round'

    for (let i = 0; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      if (i === 0) {
        context.moveTo(x, y)
      } else {
        context.lineTo(x, y)
      }
    }
    context.stroke()
  }

  build() {
    Column() {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.background)

      // Content Area
      Column({ space: 16 }) {
        this.SurfaceWithCanvas()

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)

        this.CustomLinearProgressIndicator(this.paymentProgress, this.primary, this.surfaceVariant, 8)

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(this.primary)
          .trackColor(this.surfaceVariant)
          .blockColor(this.secondary)
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(this.tertiary)
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0.0
          })
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [[this.secondary, 0.25], [this.background, 1.0], [this.primary, 0.25]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}