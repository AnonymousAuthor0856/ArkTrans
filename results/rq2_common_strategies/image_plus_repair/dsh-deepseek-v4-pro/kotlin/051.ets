@Entry
@Component
struct MetroPlannerPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private stations: string[] = ["A", "B", "C", "D", "E", "F"]
  private departures: string[] = ["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"]

  drawMap() {
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    const width: number = this.context.width
    const height: number = this.context.height
    const step: number = width / (this.stations.length - 1)
    const grad: CanvasGradient = this.context.createLinearGradient(0, 0, width, 0)
    grad.addColorStop(0.0, '#00B4FF')
    grad.addColorStop(1.0, '#00FFFF')
    this.context.strokeStyle = grad
    this.context.lineWidth = 6
    this.context.beginPath()
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step
      const y: number = (i % 2 == 0) ? height / 4 : height * 3 / 4
      if (i == 0) {
        this.context.moveTo(x, y)
      } else {
        this.context.lineTo(x, y)
      }
    }
    this.context.stroke()
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step
      const y: number = (i % 2 == 0) ? height / 4 : height * 3 / 4
      this.context.beginPath()
      this.context.arc(x, y, 16, 0, Math.PI * 2)
      this.context.fillStyle = '#00FFFF'
      this.context.fill()
      this.context.beginPath()
      this.context.arc(x, y, 6, 0, Math.PI * 2)
      this.context.fillStyle = '#0A0A1A'
      this.context.fill()
    }
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 16 }) {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00FFFF')

          Canvas(this.context)
            .width('100%')
            .height(260)
            .backgroundColor('#1E1E4A')
            .borderRadius(22)
            .onReady(() => {
              this.drawMap()
            })

          Column({ space: 6 }) {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00B4FF')
            ForEach(this.departures, (item: string) => {
              Row() {
                Text(item)
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                Text('On Time')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#00FFAA')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }, (item: string) => item)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#141436')
          .borderRadius(22)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#0A0A1A', 0], ['#1E1E4A', 0.5], ['#0A0A1A', 1]]
        })

        Row() {
          Text('Routes')
            .fontSize(14)
            .fontColor('#00B4FF')
          Text('Planner')
            .fontSize(14)
            .fontColor('#FFFFFF')
          Text('Tickets')
            .fontSize(14)
            .fontColor('#FFFFFF')
          Text('Profile')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#141436')
      }
      .width('100%')
      .height('100%')

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0A1A')
      }
      .width(56)
      .height(56)
      .backgroundColor('#00FFFF')
      .margin({ right: 16, bottom: 60 })
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A1A')
  }
}
