@Entry
@Component
struct StockKLine {
  @State progress: number = 0.5

  build() {
    Column() {
      Text('Stock K-Line')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ top: 20, bottom: 10 })

      // Chart card
      Column() {
        Canvas(this.chartSettings)
          .width('100%')
          .height(220)
          .margin({ top: 14, bottom: 14 })
          .onReady(() => {
            this.drawChart()
          })
      }
      .width('90%')
      .borderRadius(24)
      .backgroundColor('#E0E9FF')
      .padding(14)
      .margin({ top: 10, bottom: 10 })

      Text('Market Trend')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2563EB')
        .margin({ top: 10, bottom: 14 })

      // Slider
      Slider({
        value: this.progress * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor('#2563EB')
        .trackColor('#E2E8F0')
        .selectedColor('#60A5FA')
        .width('90%')
        .margin({ bottom: 20 })
        .onChange((value: number) => {
          this.progress = value / 100
        })

      // Linear progress indicator
      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .color('#2563EB')
        .backgroundColor('#E2E8F0')
        .width('90%')
        .height(10)
        .borderRadius(5)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E0E9FF', 0.0], ['#F8FAFC', 0.5], ['#E0E9FF', 1.0]]
    })
  }

  private chartSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawChart() {
    const ctx = this.chartSettings
    const width = 360
    const height = 220
    const steps = 50
    const stepX = width / steps
    const midY = height / 2
    const amplitude = height / 3

    ctx.clearRect(0, 0, width, height)

    ctx.beginPath()
    ctx.strokeStyle = '#2563EB'
    ctx.lineWidth = 4
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    for (let i = 0; i <= steps; i++) {
      const x = i * stepX
      const y = midY + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * amplitude
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }

    ctx.stroke()
  }
}
