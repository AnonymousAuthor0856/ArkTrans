@Entry
@Component
struct StockKLinePage {
  @State progress: number = 0.5
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart(): void {
    const ctx: CanvasRenderingContext2D = this.context
    const width: number = ctx.width
    const height: number = ctx.height
    const step: number = width / 50
    let prevY: number = height / 2
    ctx.lineWidth = 4
    ctx.strokeStyle = '#2563EB'
    ctx.beginPath()
    for (let i = 0; i <= 50; i++) {
      const x: number = i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)
      ctx.moveTo(x - step, prevY)
      ctx.lineTo(x, y)
      prevY = y
    }
    ctx.stroke()
  }

  private redraw(): void {
    const ctx: CanvasRenderingContext2D = this.context
    ctx.clearRect(0, 0, ctx.width, ctx.height)
    this.drawChart()
  }

  build() {
    Column() {
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

      Column() {
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .padding(14)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .margin({ top: 14 })

        Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .selectedColor('#60A5FA')
          .trackColor('#E2E8F0')
          .blockColor('#2563EB')
          .margin({ top: 14 })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value
            this.redraw()
          })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .style({ strokeWidth: 8 })
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
          .margin({ top: 14 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding(14)
      .linearGradient({
        angle: 180,
        colors: [['rgba(96, 165, 250, 0.15)', 0.0], ['#F8FAFC', 0.5], ['rgba(37, 99, 235, 0.15)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
