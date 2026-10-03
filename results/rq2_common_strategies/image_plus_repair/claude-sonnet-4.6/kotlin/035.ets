@Entry
@Component
struct Index {
  @State progress: number = 0.5

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F8FAFC')

      // Main Content
      Column({ space: 14 }) {
        // Chart Card
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .padding(14)
        .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

        // Market Trend Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#E2E8F0')
          .selectedColor('#60A5FA')
          .blockColor('#2563EB')
          .onChange((value: number) => {
            this.progress = value
            this.drawChart()
          })

        // Progress Bar
        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
          .style({ strokeWidth: 8, enableScanEffect: false })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0],
          ['#F8FAFC', 0.5],
          ['#262563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawChart() {
    const ctx = this.context
    if (!ctx) return

    const width = ctx.width
    const height = ctx.height

    ctx.clearRect(0, 0, width, height)

    const step = width / 50
    const PI = Math.PI

    ctx.beginPath()
    ctx.strokeStyle = '#2563EB'
    ctx.lineWidth = 4
    ctx.lineJoin = 'round'
    ctx.lineCap = 'round'

    let prevY = height / 2
    ctx.moveTo(0, prevY)

    for (let i = 1; i <= 50; i++) {
      const x = i * step
      const y = height / 2 + Math.sin(i * PI / 8 + this.progress * PI) * (height / 3)
      ctx.lineTo(x, y)
      prevY = y
    }

    ctx.stroke()
  }
}