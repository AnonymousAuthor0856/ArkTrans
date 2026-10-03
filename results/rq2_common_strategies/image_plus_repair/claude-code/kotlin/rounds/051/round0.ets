@Entry
@Component
struct MetroPlanner {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']

  @Builder
  StationCanvas() {
    Canvas(this.pathPainter)
      .width('100%')
      .height(260)
      .backgroundColor('#1E1E4A')
      .borderRadius(22)
      .padding(10)
  }

  private pathPainter = new PathPainter(this.stations)

  build() {
    Stack() {
      Column() {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')
          .margin({ bottom: 16 })

        this.StationCanvas()
          .margin({ bottom: 16 })

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

class PathPainter implements IDrawing {
  private stations: string[]

  constructor(stations: string[]) {
    this.stations = stations
  }

  draw(context: CanvasRenderingContext2D): void {
    const width = context.canvas.width
    const height = context.canvas.height
    const step = width / (this.stations.length - 1)

    // Draw path
    context.beginPath()
    context.lineWidth = 6
    const gradient = context.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, '#00B4FF')
    gradient.addColorStop(1, '#00FFFF')
    context.strokeStyle = gradient
    context.lineCap = 'round'
    context.lineJoin = 'round'

    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4
      if (i === 0) {
        context.moveTo(x, y)
      } else {
        context.lineTo(x, y)
      }
    }
    context.stroke()

    // Draw station circles
    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4

      // Outer circle
      context.beginPath()
      context.arc(x, y, 16, 0, Math.PI * 2)
      context.fillStyle = '#00FFFF'
      context.fill()

      // Inner dot
      context.beginPath()
      context.arc(x, y, 6, 0, Math.PI * 2)
      context.fillStyle = '#0A0A1A'
      context.fill()
    }
  }
}
