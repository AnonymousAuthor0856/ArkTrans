import { curves } from '@kit.ArkUI'

const PRIMARY_COLOR = '#FFA500'
const SECONDARY_COLOR = '#FFC107'
const TERTIARY_COLOR = '#FFE066'
const BACKGROUND_COLOR = '#FFFBF2'
const SURFACE_COLOR = '#FFFFFF'
const SURFACE_VARIANT_COLOR = '#FFEED6'
const ON_SURFACE_COLOR = '#1E1E1E'
const ON_TERTIARY_COLOR = '#1E1E1E'

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(BACKGROUND_COLOR)

      // Main content
      Column({ space: 16 }) {
        // Wave chart card
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawWave()
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor(SURFACE_COLOR)
        .borderRadius(20)
        .padding(16)
        .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

        // Payment Progress label
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_COLOR)

        // Linear progress bar
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(SURFACE_VARIANT_COLOR)
            .borderRadius(4)
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .backgroundColor(PRIMARY_COLOR)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)

        // Slider
        Slider({
          value: this.paymentProgress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(SURFACE_VARIANT_COLOR)
          .selectedColor(PRIMARY_COLOR)
          .blockColor(SECONDARY_COLOR)
          .onChange((value: number) => {
            this.paymentProgress = value / 100
            this.drawWave()
          })

        // Reset button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_TERTIARY_COLOR)
          .backgroundColor(TERTIARY_COLOR)
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0
            this.drawWave()
          })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#40FFC107', 0.0],
        [BACKGROUND_COLOR, 0.5],
        ['#40FFA500', 1.0]
      ]
    })
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawWave(): void {
    const ctx = this.context
    if (!ctx) {
      return
    }
    const w = ctx.width
    const h = ctx.height
    if (w === 0 || h === 0) {
      return
    }
    ctx.clearRect(0, 0, w, h)
    ctx.strokeStyle = PRIMARY_COLOR
    ctx.lineWidth = 5
    ctx.lineJoin = 'round'
    ctx.lineCap = 'round'
    ctx.beginPath()
    const step = w / 20
    let prevY = h / 2
    for (let i = 0; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
      prevY = y
    }
    ctx.stroke()
  }
}