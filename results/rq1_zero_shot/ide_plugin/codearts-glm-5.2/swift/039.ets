class AppTokens {
  static readonly Colors = {
    primary: '#FFFFA500',
    secondary: '#FFFFC107',
    tertiary: '#FFFFE066',
    background: '#FFFFFBF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFEED6',
    outline: '#FFF1C27D',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
    surface90: '#E6FFFFFF'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }
}

@Entry
@Component
struct InstallmentPlan {
  @State paymentProgress: number = 0.3

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 300
    const h: number = 208
    const step = w / 20

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
    ctx.moveTo(0, initialY)

    for (let i = 1; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = '#FFFFA500'
    ctx.lineWidth = 5
    ctx.stroke()
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(16)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(240)
        .borderRadius(20)
        .backgroundColor(AppTokens.Colors.surface90)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 16 })

        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value
            this.drawCanvas()
          })

        Button('Reset Progress') {
        }
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onTertiary)
        .width('100%')
        .height(48)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.tertiary)
        .onClick(() => {
          this.paymentProgress = 0.0
          this.drawCanvas()
        })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}