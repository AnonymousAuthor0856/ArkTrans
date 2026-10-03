@Entry
@Component
struct Index {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false

  // Colors
  readonly colorPrimary: string = '#FFEF476F'
  readonly colorSecondary: string = '#FFFFD166'
  readonly colorTertiary: string = '#FF06D6A0'
  readonly colorBackground: string = '#FFFFFCF2'
  readonly colorSurface: string = '#FFFFF8E1'
  readonly colorOutline: string = '#FFBDBDBD'
  readonly colorOnPrimary: string = '#FFFFFFFF'
  readonly colorOnSecondary: string = '#FF1F1F1F'
  readonly colorOnSurface: string = '#FF1F1F1F'

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Music Player')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorBackground)

      // Main Content
      Column() {
        // Knob Area
        Stack() {
          Canvas(this.renderingContextCanvas())
            .width(280)
            .height(280)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width(280)
        .height(280)
        .backgroundColor(this.colorSurface)
        .borderRadius(16)
        .border({ width: 3, color: this.colorOutline, radius: 16 })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move || event.type === TouchType.Down) {
            let touch = event.touches[0]
            this.knobX = touch.x
            this.knobY = touch.y
            this.drawCanvas()
          }
        })

        // Track Name
        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnSurface)
          .margin({ top: 24, bottom: 24 })

        // Buttons Row
        Row() {
          Button('Play')
            .width(120)
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnPrimary)
            .backgroundColor(this.colorPrimary)
            .borderRadius(12)

          Button('Pause')
            .width(120)
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSecondary)
            .backgroundColor(this.colorSecondary)
            .borderRadius(12)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 24 })

        // Knob Position Text
        Text(`Knob X:${Math.round(this.knobX)} Y:${Math.round(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorTertiary)
          .margin({ bottom: 32 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.colorBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }

  private canvasContext: CanvasRenderingContext2D | null = null

  private renderingContextCanvas(): CanvasRenderingContext2D {
    let settings = new RenderingContextSettings(true)
    let ctx = new CanvasRenderingContext2D(settings)
    this.canvasContext = ctx
    return ctx
  }

  private drawCanvas() {
    if (this.canvasContext === null) return
    let ctx = this.canvasContext
    ctx.clearRect(0, 0, 280, 280)

    // Draw outer circle (secondary color)
    let centerX = 140
    let centerY = 140
    let radius = 140 - 20

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.strokeStyle = '#FFFFD166'
    ctx.lineWidth = 12
    ctx.stroke()

    // Draw knob (primary color)
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2)
    ctx.fillStyle = '#FFEF476F'
    ctx.fill()
  }
}