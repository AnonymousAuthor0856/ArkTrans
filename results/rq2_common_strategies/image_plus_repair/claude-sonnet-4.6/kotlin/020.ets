@Entry
@Component
struct RootScreen {
  @State knobX: number = 0
  @State knobY: number = 0
  @State powerOn: boolean = false
  private canvasWidth: number = 0
  private canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawKnobCanvas() {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    const cx = this.canvasWidth / 2
    const cy = this.canvasHeight / 2

    // Background circle
    this.context.beginPath()
    this.context.arc(cx, cy, 200, 0, Math.PI * 2)
    this.context.fillStyle = 'rgba(255, 195, 0, 0.2)'
    this.context.fill()

    // Knob dot
    this.context.beginPath()
    this.context.arc(this.knobX, this.knobY, 24, 0, Math.PI * 2)
    this.context.fillStyle = '#FF7A00'
    this.context.fill()
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#FFF8E7')

      // Main content
      Column({ space: 24 }) {
        // Canvas area
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasWidth = this.context.width
              this.canvasHeight = this.context.height
              this.knobX = this.canvasWidth / 2
              this.knobY = this.canvasHeight / 2
              this.drawKnobCanvas()
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const touch = event.touches[0]
                this.knobX = touch.x
                this.knobY = touch.y
                this.drawKnobCanvas()
              }
            })
        }
        .width(280)
        .height(280)
        .backgroundColor('#FFEBC8')
        .borderRadius(24)
        .padding(16)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 })

        // Power status
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? '#28A745' : '#DC3545')

        // Buttons row
        Row({ space: 0 }) {
          Button(this.powerOn ? 'Off' : 'On')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor('#FF7A00')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

          Button('Reset')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor('#FFC300')
            .fontColor('#1E1E1E')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.knobX = this.canvasWidth / 2
              this.knobY = this.canvasHeight / 2
              this.drawKnobCanvas()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        // Progress bar
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(6)
            .backgroundColor('#FFEBC8')
            .borderRadius(3)

          Row()
            .width(`${Math.min(100, Math.max(0, ((this.knobX + this.knobY) % 400) / 400 * 100))}%`)
            .height(6)
            .backgroundColor('#FF7A00')
            .borderRadius(3)
        }
        .width('100%')
        .height(6)
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
  }
}