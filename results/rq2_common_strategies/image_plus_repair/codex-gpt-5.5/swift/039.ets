const PRIMARY: string = '#FFA500'
const SECONDARY: string = '#FFC107'
const TERTIARY: string = '#FFE066'
const BACKGROUND: string = '#FFFBF2'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#FFEED6'
const INK: string = '#1E1E1E'

@Entry
@Component
struct InstallmentPlanApp {
  @State private paymentProgress: number = 0.3
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawWaveform(): void {
    const context = this.canvasContext
    const width = context.width
    const height = context.height
    if (width <= 0 || height <= 0) {
      return
    }

    context.clearRect(0, 0, width, height)
    context.beginPath()
    const step: number = width / 20
    const center: number = height / 2
    const amplitude: number = height / 3
    const phase: number = this.paymentProgress * Math.PI

    for (let index = 0; index <= 20; index++) {
      const x: number = index * step
      const y: number = center + Math.sin(index * Math.PI / 5 + phase) * amplitude
      if (index === 0) {
        context.moveTo(x, y)
      } else {
        context.lineTo(x, y)
      }
    }

    context.strokeStyle = PRIMARY
    context.lineWidth = 5
    context.lineJoin = 'miter'
    context.lineCap = 'butt'
    context.stroke()
  }

  build() {
    Column({ space: 0 }) {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(INK)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(BACKGROUND)
        .padding({ top: 7 })

      Column({ space: 16 }) {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(240)
            .padding(16)
            .onReady(() => {
              this.drawWaveform()
            })
            .onAreaChange(() => {
              this.drawWaveform()
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor(SURFACE)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY)
          .width('100%')
          .textAlign(TextAlign.Center)

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(SURFACE_VARIANT)

          Row()
            .width(`${Math.max(0, Math.min(1, this.paymentProgress)) * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(PRIMARY)
        }
        .width('100%')
        .height(8)

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(32)
          .blockColor(SECONDARY)
          .trackColor(SURFACE_VARIANT)
          .selectedColor(PRIMARY)
          .onChange((value: number) => {
            this.paymentProgress = value
            this.drawWaveform()
          })

        Button('Reset Progress', { type: ButtonType.Normal })
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(INK)
          .width('100%')
          .height(48)
          .backgroundColor(TERTIARY)
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0
            this.drawWaveform()
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 256, bottom: 16 })
      .backgroundColor(BACKGROUND)
      .linearGradient({
        angle: 180,
        colors: [[SECONDARY, 0.0], [BACKGROUND, 0.5], [PRIMARY, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
