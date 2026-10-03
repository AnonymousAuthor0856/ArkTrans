@Entry
@Component
struct StockKLineApp {
  @State private progress: number = 0.5
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private chartContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart(): void {
    let width: number = this.chartContext.width
    let height: number = this.chartContext.height
    if (width <= 0 || height <= 0) {
      return
    }

    this.chartContext.clearRect(0, 0, width, height)
    this.chartContext.beginPath()

    let step: number = width / 50
    for (let i: number = 0; i <= 50; i++) {
      let x: number = i * step
      let y: number = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)
      if (i === 0) {
        this.chartContext.moveTo(x, y)
      } else {
        this.chartContext.lineTo(x, y)
      }
    }

    this.chartContext.strokeStyle = '#2563EB'
    this.chartContext.lineWidth = 4
    this.chartContext.lineJoin = 'miter'
    this.chartContext.lineCap = 'butt'
    this.chartContext.stroke()
  }

  @Builder
  private chart(): void {
    Stack() {
      Canvas(this.chartContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawChart()
        })
    }
    .width('100%')
    .height(260)
    .padding({ left: 14, right: 14, top: 14, bottom: 14 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 8,
      color: '#2F3A4D2E',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      Text('Stock K-Line')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F8FAFC')
        .margin({ top: 0 })

      Column() {
        this.chart()

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .margin({ top: 14, bottom: 0 })

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .blockColor('#FFFFFF')
          .trackColor('#CBD5E1')
          .selectedColor('#2563EB')
          .onChange((value: number) => {
            this.progress = value
            this.drawChart()
          })

        Stack() {
          Row()
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor('#2563EB')
            .borderRadius(4)
            .alignSelf(ItemAlign.Start)
        }
        .width('100%')
        .height(8)
        .backgroundColor('#E2E8F0')
        .borderRadius(4)
        .margin({ top: 0 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 14, right: 14, top: 236, bottom: 14 })
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#EAF2FE')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#DDEBFC', 0.0], ['#F8FAFC', 0.48], ['#D8E6FB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
