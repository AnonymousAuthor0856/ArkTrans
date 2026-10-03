const PRIMARY: string = '#FFA500'
const SECONDARY: string = '#FFC107'
const TERTIARY: string = '#FFE066'
const BACKGROUND: string = '#FFFBF2'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#FFEED6'
const ON_SURFACE: string = '#1E1E1E'

@Entry
@Component
struct InstallmentPlanPage {
  @State private paymentProgress: number = 0.3

  private readonly chartWidth: number = 656
  private readonly chartHeight: number = 480
  private readonly chartPadding: number = 32
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  private drawPaymentLine(): void {
    const context = this.canvasContext
    const width: number = this.chartWidth
    const height: number = this.chartHeight
    const contentWidth: number = width - this.chartPadding * 2
    const contentHeight: number = height - this.chartPadding * 2
    const centerY: number = this.chartPadding + contentHeight / 2
    const step: number = contentWidth / 20
    let previousY: number = centerY

    context.clearRect(0, 0, width, height)
    context.beginPath()
    context.lineWidth = 5
    context.lineCap = 'butt'
    context.lineJoin = 'miter'
    context.strokeStyle = PRIMARY
    context.moveTo(this.chartPadding - step, previousY)

    for (let i = 0; i <= 20; i++) {
      const x: number = this.chartPadding + i * step
      const y: number = centerY + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * contentHeight / 3
      context.lineTo(x, y)
      previousY = y
    }

    context.stroke()
  }

  @Builder
  private ProgressTrack() {
    Row() {
      Row()
        .width(`${this.paymentProgress * 100}%`)
        .height(16)
        .backgroundColor(PRIMARY)
        .borderRadius(8)

      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill(PRIMARY)
      }
      .layoutWeight(1)
      .height(16)
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)
      .padding({ right: 4 })
      .backgroundColor(SURFACE_VARIANT)
      .borderRadius(8)
    }
    .width('100%')
    .height(16)
    .clip(true)
    .margin({ top: 42 })
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(112)
        .lineHeight(112)
        .margin({ top: 24, bottom: 24 })

      Stack() {
        Canvas(this.canvasContext)
          .width(this.chartWidth)
          .height(this.chartHeight)
          .onReady(() => {
            this.drawPaymentLine()
          })
          .onAreaChange(() => {
            this.drawPaymentLine()
          })
      }
      .width('100%')
      .height(this.chartHeight)
      .backgroundColor('rgba(255,255,255,0.90)')
      .borderRadius(36)
      .clip(true)
      .shadow({
        radius: 8,
        color: '#1A000000',
        offsetX: 0,
        offsetY: 4
      })

      Text('Payment Progress')
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(52)
        .lineHeight(52)
        .margin({ top: 31 })

      this.ProgressTrack()

      Slider({
        value: this.paymentProgress,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(72)
        .selectedColor(PRIMARY)
        .trackColor(SURFACE_VARIANT)
        .blockColor(SECONDARY)
        .showSteps(false)
        .margin({ top: 24 })
        .onChange((value: number) => {
          this.paymentProgress = value
          this.drawPaymentLine()
        })

      Button('Reset Progress', { type: ButtonType.Normal })
        .width('100%')
        .height(96)
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
        .backgroundColor(TERTIARY)
        .borderRadius(24)
        .stateEffect(false)
        .margin({ top: 36 })
        .onClick(() => {
          this.paymentProgress = 0
          this.drawPaymentLine()
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor(BACKGROUND)
    .linearGradient({
      angle: 180,
      colors: [
        ['rgba(255,193,7,0.25)', 0.0],
        [BACKGROUND, 0.52],
        ['rgba(255,165,0,0.25)', 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Center)
  }
}
