@Entry
@Component
struct RootScreen {
  @State knobX: number = 0
  @State knobY: number = 0
  @State powerOn: boolean = false

  private canvasWidth: number = 280
  private canvasHeight: number = 280

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawCanvas() {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    const cx = this.canvasWidth / 2
    const cy = this.canvasHeight / 2

    // Draw background circle
    this.context.beginPath()
    this.context.arc(cx, cy, 100, 0, Math.PI * 2)
    this.context.fillStyle = 'rgba(255,195,0,0.2)'
    this.context.fill()

    // Draw knob
    this.context.beginPath()
    this.context.arc(this.knobX, this.knobY, 18, 0, Math.PI * 2)
    this.context.fillStyle = '#FF7A00'
    this.context.fill()
  }

  getProgress(): number {
    const val = (this.knobX + this.knobY) % 400
    return val / 400
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFF8E7')
      .justifyContent(FlexAlign.Center)

      // Main Content
      Column({ space: 24 }) {
        // Canvas Area
        Stack() {
          Canvas(this.context)
            .width(280)
            .height(280)
            .backgroundColor('#FFEBC8')
            .borderRadius(24)
            .onReady(() => {
              this.knobX = this.canvasWidth / 2
              this.knobY = this.canvasHeight / 2
              this.drawCanvas()
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const touch = event.touches[0]
                this.knobX = touch.x
                this.knobY = touch.y
                this.drawCanvas()
              }
            })
        }
        .width(280)
        .height(280)
        .borderRadius(24)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetY: 2 })

        // Power Status
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? '#28A745' : '#DC3545')

        // Buttons Row
        Row({ space: 40 }) {
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
              this.drawCanvas()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Progress Bar
        Column() {
          Progress({
            value: this.getProgress() * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(6)
            .color('#FF7A00')
            .backgroundColor('#FFEBC8')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .backgroundColor('#FFF8E7')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
  }
}