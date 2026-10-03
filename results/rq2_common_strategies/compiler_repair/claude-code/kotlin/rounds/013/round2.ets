@Entry
@Component
struct Index {
  @State knobX: number = 140
  @State knobY: number = 140
  private readonly canvasSize: number = 280
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Row() {
        Text("Retro Music Player")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFCF2')

      Column() {
        Stack() {
          Canvas(this.context)
            .width(this.canvasSize)
            .height(this.canvasSize)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width(this.canvasSize)
        .height(this.canvasSize)
        .backgroundColor('#FFF8E1')
        .borderRadius(16)
        .border({ width: 3, color: '#BDBDBD' })
        .gesture(
          PanGesture({ direction: PanDirection.All, distance: 1 })
            .onActionUpdate((event: GestureEvent) => {
              if (event.fingerList && event.fingerList.length > 0) {
                this.knobX = event.fingerList[0].localX
                this.knobY = event.fingerList[0].localY
                this.drawCanvas()
              }
            })
        )

        Text("Track: Summer Nights")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')
          .margin({ top: 24 })

        Row() {
          Button("Play")
            .width(120)
            .height(48)
            .backgroundColor('#EF476F')
            .fontColor('#FFFFFF')
            .borderRadius(12)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})

          Button("Pause")
            .width(120)
            .height(48)
            .backgroundColor('#FFD166')
            .fontColor('#1F1F1F')
            .borderRadius(12)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        Text("Knob X:" + Math.round(this.knobX) + " Y:" + Math.round(this.knobY))
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#06D6A0')
          .margin({ top: 24 })

        Blank()
          .height(32)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#FFFCF2')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }

  private drawCanvas(): void {
    let ctx = this.context
    let size = this.canvasSize
    let center = size / 2
    let outerRadius = size / 2 - 20

    ctx.clearRect(0, 0, size, size)

    ctx.beginPath()
    ctx.arc(center, center, outerRadius, 0, Math.PI * 2)
    ctx.strokeStyle = '#FFD166'
    ctx.lineWidth = 12
    ctx.stroke()

    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2)
    ctx.fillStyle = '#EF476F'
    ctx.fill()
  }
}
