@Entry
@Component
struct MetroPlanner {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  @State canvasWidth: number = 0
  @State canvasHeight: number = 260

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear(): void {
  }

  drawStationPath(): void {
    const width: number = this.canvasWidth
    const height: number = this.canvasHeight
    const step: number = width / (this.stations.length - 1)
    const ctx: CanvasRenderingContext2D = this.canvasContext

    ctx.clearRect(0, 0, width, height)

    // Draw path
    ctx.beginPath()
    ctx.lineWidth = 6
    const gradient: CanvasGradient = ctx.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, '#00B4FF')
    gradient.addColorStop(1, '#00FFFF')
    ctx.strokeStyle = gradient
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    for (let i: number = 0; i < this.stations.length; i++) {
      const x: number = i * step
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.stroke()

    // Draw station circles
    for (let i: number = 0; i < this.stations.length; i++) {
      const x: number = i * step
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4

      // Outer circle
      ctx.beginPath()
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fillStyle = '#00FFFF'
      ctx.fill()

      // Inner dot
      ctx.beginPath()
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fillStyle = '#0A0A1A'
      ctx.fill()
    }
  }

  build() {
    Stack() {
      Column() {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')
          .margin({ bottom: 16 })

        Canvas(this.canvasContext)
          .width('100%')
          .height(260)
          .backgroundColor('#1E1E4A')
          .borderRadius(22)
          .padding(10)
          .margin({ bottom: 16 })
          .onReady(() => {
            this.drawStationPath()
          })
          .onAreaChange((oldArea: Area, newArea: Area) => {
            this.canvasWidth = newArea.width as number
            this.canvasHeight = newArea.height as number
            this.drawStationPath()
          })

        Column() {
          Text('Next Departures')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00B4FF')
            .margin({ bottom: 6 })

          Row() {
            Text('08:45 • Line 1')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .layoutWeight(1)
            Text('On Time')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00FFAA')
          }
          .width('100%')
          .margin({ top: 6, bottom: 6 })

          Row() {
            Text('09:10 • Line 2')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .layoutWeight(1)
            Text('On Time')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00FFAA')
          }
          .width('100%')
          .margin({ top: 6, bottom: 6 })

          Row() {
            Text('09:30 • Line 3')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .layoutWeight(1)
            Text('On Time')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00FFAA')
          }
          .width('100%')
          .margin({ top: 6, bottom: 6 })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#141436')
        .borderRadius(22)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.3)',
          offsetY: 4
        })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A1A', 0.0], ['#1E1E4A', 0.5], ['#0A0A1A', 1.0]]
      })

      // Floating Action Button
      Stack() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0A0A1A')
      }
      .width(72)
      .height(72)
      .borderRadius(36)
      .backgroundColor('#00FFFF')
      .shadow({
        radius: 12,
        color: 'rgba(0, 255, 255, 0.4)',
        offsetY: 4
      })
      .position({ x: '80%', y: '78%' })

      // Bottom Navigation Bar
      Row() {
        Text('Routes')
          .fontSize(14)
          .fontColor('#00B4FF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Planner')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Tickets')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#141436')
      .position({ x: 0, y: '100%' })
      .translate({ y: -56 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A1A')
  }
}
