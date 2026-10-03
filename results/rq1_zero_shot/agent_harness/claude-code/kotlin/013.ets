@Entry
@Component
struct Index {
  @State knobX: number = 150
  @State knobY: number = 150
  private readonly canvasSize: number = 280

  build() {
    Stack() {
      Column() {
        // Top bar
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
          // Album art / canvas area
          Stack() {
            Canvas(this.canvasSettings)
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
                let x = event.localX
                let y = event.localY
                let center = this.canvasSize / 2
                let maxRadius = this.canvasSize / 2 - 20
                let dx = x - center
                let dy = y - center
                let dist = Math.sqrt(dx * dx + dy * dy)
                if (dist > maxRadius) {
                  let ratio = maxRadius / dist
                  x = center + dx * ratio
                  y = center + dy * ratio
                }
                this.knobX = x
                this.knobY = y
                this.drawCanvas()
              })
          )

          // Track title
          Text("Track: Summer Nights")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1F1F')
            .margin({ top: 24 })

          // Play / Pause buttons
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

          // Knob position display
          Text("Knob X:" + Math.round(this.knobX) + " Y:" + Math.round(this.knobY))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06D6A0')
            .margin({ top: 24 })

          Blank()
            .height(32)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#FFFCF2')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }

  private settings: CanvasRenderingContext2D | null = null

  get canvasSettings(): CanvasRenderingContext2D | null {
    return this.settings
  }

  set canvasSettings(value: CanvasRenderingContext2D | null) {
    this.settings = value
  }

  private drawCanvas(): void {
    let ctx = this.settings
    if (!ctx) return
    let size = this.canvasSize
    let center = size / 2
    let outerRadius = size / 2 - 20

    ctx.clearRect(0, 0, size, size)

    // Outer circle (secondary color ring)
    ctx.beginPath()
    ctx.arc(center, center, outerRadius, 0, Math.PI * 2)
    ctx.strokeStyle = '#FFD166'
    ctx.lineWidth = 12
    ctx.stroke()

    // Knob circle (primary color)
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2)
    ctx.fillStyle = '#EF476F'
    ctx.fill()
  }
}
