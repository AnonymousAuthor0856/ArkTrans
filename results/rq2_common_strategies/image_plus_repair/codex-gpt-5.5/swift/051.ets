@Entry
@Component
struct MetroPlanner {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  private drawMetro() {
    const ctx = this.context
    const width = ctx.width
    const height = ctx.height
    if (width <= 0 || height <= 0) {
      return
    }

    ctx.clearRect(0, 0, width, height)
    const gradient = ctx.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, '#00B4FF')
    gradient.addColorStop(1, '#00FFFF')
    const inset = 10
    const step = (width - inset * 2) / 5
    const points: number[][] = []

    for (let i = 0; i < 6; i++) {
      points.push([inset + i * step, i % 2 === 0 ? height / 4 : height * 3 / 4])
    }

    ctx.beginPath()
    ctx.moveTo(points[0][0], points[0][1])
    for (let i = 1; i < points.length; i++) {
      ctx.lineTo(points[i][0], points[i][1])
    }
    ctx.strokeStyle = gradient
    ctx.lineWidth = 6
    ctx.stroke()

    for (let i = 0; i < points.length; i++) {
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 16, 0, Math.PI * 2)
      ctx.fillStyle = '#00FFFF'
      ctx.fill()
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 6, 0, Math.PI * 2)
      ctx.fillStyle = '#0A0A1A'
      ctx.fill()
    }
  }

  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')

        Canvas(this.context)
          .width('100%')
          .height(260)
          .backgroundColor('#1E1E4A')
          .borderRadius(22)
          .padding(10)
          .onReady(() => {
            this.drawMetro()
          })

        Column({ space: 6 }) {
          Text('Next Departures')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00B4FF')
            .width('100%')

          ForEach(this.departures, (departure: string) => {
            Row() {
              Text(departure)
                .fontSize(14)
                .fontColor('#FFFFFF')
              Blank()
              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#00FFAA')
            }
            .width('100%')
            .height(23)
          }, (departure: string) => departure)
        }
        .padding(16)
        .width('calc(100% - 32vp)')
        .backgroundColor('#141436')
        .borderRadius(22)
        .shadow({ radius: 8, color: '#262E2E5C', offsetY: 4 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 16, bottom: 72 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0xFF0A0A1A, 0.0], [0xFF1E1E4A, 0.5], [0xFF0A0A1A, 1.0]]
      })
      .align(Alignment.TopStart)

      Button('+')
        .width(56)
        .height(56)
        .fontSize(24)
        .fontColor('#0A0A1A')
        .backgroundColor('#00FFFF')
        .borderRadius(28)
        .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 128vp)' })

      Row() {
        Text('Routes').fontColor('#00B4FF').fontSize(14)
        Blank()
        Text('Planner').fontColor('#FFFFFF').fontSize(14)
        Blank()
        Text('Tickets').fontColor('#FFFFFF').fontSize(14)
        Blank()
        Text('Profile').fontColor('#FFFFFF').fontSize(14)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#141436')
      .align(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A1A')
  }
}
