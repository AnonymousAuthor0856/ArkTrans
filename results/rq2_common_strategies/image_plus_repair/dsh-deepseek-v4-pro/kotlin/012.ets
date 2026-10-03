@Entry
@Component
struct RootScreen {
  @State markerX: number = 200
  @State markerY: number = 400
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMap(): void {
    this.ctx.clearRect(0, 0, this.ctx.width, this.ctx.height)
    const cx: number = this.ctx.width / 2
    const cy: number = this.ctx.height / 2

    this.ctx.fillStyle = 'rgba(147,197,253,0.3)'
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, 220, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = 'rgba(147,197,253,0.2)'
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, 340, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = '#60A5FA'
    this.ctx.beginPath()
    this.ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.strokeStyle = 'rgba(96,165,250,0.3)'
    this.ctx.lineWidth = 3
    this.ctx.beginPath()
    this.ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2)
    this.ctx.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9FAFB')

      Stack({ alignContent: Alignment.Center }) {
        Stack() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMap()
            })
        }
        .width('100%')
        .height(400)
        .radialGradient({
          center: [344, 200],
          radius: 400,
          colors: [['rgba(255,255,255,0.8)', 0.0], ['rgba(239,246,255,0.6)', 1.0]]
        })
        .borderRadius(24)
        .border({ width: 1, color: '#D1D5DB' })

        Column({ space: 12 }) {
          Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#111827')
          Button('Save Marker', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .backgroundColor('#60A5FA')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(16)
            .onClick(() => {
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [['rgba(255,255,255,0.6)', 0.0], ['rgba(239,246,255,0.5)', 0.5], ['rgba(255,255,255,0.7)', 1.0]]
      })
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}
