@Entry
@Component
struct MetroPlannerApp {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']
  @State bottomSelected: number = 1

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00FFFF')
            .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 0 })

        Canvas(this.pathSettings)
          .width('100%')
          .height(260)
          .backgroundColor('#1E1E4A')
          .borderRadius(22)
          .padding(10)
          .margin({ top: 16, left: 16, right: 16 })
          .onReady(() => {
            this.drawMetroMap()
          })

        Column() {
          Text('Next Departures')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00B4FF')
            .width('100%')
            .margin({ bottom: 6 })

          ForEach(this.departures, (item: string) => {
            Row() {
              Text(item)
                .fontSize(14)
                .fontColor('#FFFFFF')
              Blank()
              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#00FFAA')
            }
            .width('100%')
            .padding({ top: 4, bottom: 4 })
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#141436')
        .borderRadius(22)
        .margin({ top: 16, left: 16, right: 16 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A1A', 0.0], ['#1E1E4A', 0.5], ['#0A0A1A', 1.0]]
      })

      // Bottom App Bar
      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(14)
            .fontColor(this.bottomSelected === 0 ? '#00B4FF' : '#FFFFFF')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => { this.bottomSelected = 0 })
          Text('Planner')
            .fontSize(14)
            .fontColor(this.bottomSelected === 1 ? '#00B4FF' : '#FFFFFF')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => { this.bottomSelected = 1 })
          Text('Tickets')
            .fontSize(14)
            .fontColor(this.bottomSelected === 2 ? '#00B4FF' : '#FFFFFF')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => { this.bottomSelected = 2 })
          Text('Profile')
            .fontSize(14)
            .fontColor(this.bottomSelected === 3 ? '#00B4FF' : '#FFFFFF')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => { this.bottomSelected = 3 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#141436')
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A1A')
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor('#00FFFF')
            .margin({ right: 16, bottom: 84 })
            .shadow({ radius: 8, color: 'rgba(0, 255, 255, 0.4)', offsetY: 4 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A1A')
  }

  private pathSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private drawMetroMap(): void {
    let ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.pathSettings)
    let width: number = 328
    let height: number = 240
    let step: number = width / (this.stations.length - 1)

    // Draw path
    ctx.beginPath()
    for (let i = 0; i < this.stations.length; i++) {
      let x: number = i * step
      let y: number = (i % 2 === 0) ? height / 4 : height * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    let gradient = ctx.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, '#00B4FF')
    gradient.addColorStop(1, '#00FFFF')
    ctx.strokeStyle = gradient
    ctx.lineWidth = 6
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'
    ctx.stroke()

    // Draw station circles
    for (let i = 0; i < this.stations.length; i++) {
      let x: number = i * step
      let y: number = (i % 2 === 0) ? height / 4 : height * 3 / 4

      // Outer circle
      ctx.beginPath()
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fillStyle = '#00FFFF'
      ctx.fill()

      // Inner circle
      ctx.beginPath()
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fillStyle = '#0A0A1A'
      ctx.fill()
    }
  }
}
