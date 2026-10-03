@Entry
@Component
struct RootScreen {
  @State markerX: number = 200
  @State markerY: number = 400

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Favorite Spots Map')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9FAFB')

      // Main Content
      Stack({ alignContent: Alignment.Bottom }) {
        // Map Canvas Area
        Stack({ alignContent: Alignment.Center }) {
          // Background gradient simulation
          Column()
            .width('100%')
            .height(400)
            .borderRadius(24)
            .backgroundColor('#CCFFFFFF')
            .border({ width: 1, color: '#D1D5DB', radius: 24 })

          // Circles simulation using Canvas
          Canvas(this.context)
            .width('100%')
            .height(400)
            .onReady(() => {
              this.drawMap()
            })
        }
        .width('100%')
        .height(400)

        // Bottom info and button
        Column({ space: 12 }) {
          Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
            .fontSize(14)
            .fontColor('#111827')
            .fontWeight(FontWeight.Normal)

          Button('Save Marker')
            .width('100%')
            .height(48)
            .borderRadius(16)
            .backgroundColor('#60A5FA')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  drawMap() {
    const ctx = this.context
    const w = ctx.width
    const h = ctx.height

    // Clear
    ctx.clearRect(0, 0, w, h)

    // Draw background gradient manually
    const grad = ctx.createRadialGradient(w / 2, h / 2, 0, w / 2, h / 2, Math.max(w, h) / 2)
    grad.addColorStop(0, 'rgba(255,255,255,0.8)')
    grad.addColorStop(1, 'rgba(239,246,255,0.6)')
    ctx.fillStyle = grad
    ctx.fillRect(0, 0, w, h)

    // Draw outer ring
    ctx.beginPath()
    ctx.arc(w / 2, h / 2, 340, 0, Math.PI * 2)
    ctx.strokeStyle = 'rgba(147,197,253,0.2)'
    ctx.lineWidth = 2
    ctx.stroke()

    // Draw inner ring
    ctx.beginPath()
    ctx.arc(w / 2, h / 2, 220, 0, Math.PI * 2)
    ctx.strokeStyle = 'rgba(147,197,253,0.3)'
    ctx.lineWidth = 2
    ctx.stroke()

    // Fill inner circle
    ctx.beginPath()
    ctx.arc(w / 2, h / 2, 220, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(147,197,253,0.1)'
    ctx.fill()

    // Draw marker circle (outer glow)
    ctx.beginPath()
    ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2)
    ctx.strokeStyle = 'rgba(96,165,250,0.3)'
    ctx.lineWidth = 3
    ctx.stroke()

    // Draw marker dot
    ctx.beginPath()
    ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2)
    ctx.fillStyle = '#60A5FA'
    ctx.fill()
  }
}