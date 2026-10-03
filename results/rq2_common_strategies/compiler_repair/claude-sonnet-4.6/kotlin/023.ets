@Entry
@Component
struct RootScreen {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isRunning: boolean = false
  private canvasSize: number = 280

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFCF9')

      Column({ space: 24 }) {
        // Circle Canvas Area
        Stack() {
          Circle()
            .width(280)
            .height(280)
            .fill('#FDE2E4')

          Canvas(this.context)
            .width(280)
            .height(280)
            .onReady(() => {
              this.drawCanvas()
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  let x = event.offsetX + 140
                  let y = event.offsetY + 140
                  this.knobX = Math.max(0, Math.min(280, x))
                  this.knobY = Math.max(0, Math.min(280, y))
                  this.drawCanvas()
                })
                .onActionUpdate((event: GestureEvent) => {
                  let x = event.offsetX + 140
                  let y = event.offsetY + 140
                  this.knobX = Math.max(0, Math.min(280, x))
                  this.knobY = Math.max(0, Math.min(280, y))
                  this.drawCanvas()
                })
            )
        }
        .width(280)
        .height(280)
        .borderRadius(140)
        .clip(true)
        .shadow({ radius: 8, color: '#30000000', offsetY: 4 })

        // Status Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4ADE80' : '#FB7185')

        // Buttons Row
        Row({ space: 16 }) {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FF8FAB')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .onClick(() => {
              this.isRunning = true
            })

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FFD6A5')
            .fontColor('#1E1E1E')
            .fontSize(16)
            .onClick(() => {
              this.isRunning = false
            })
        }
        .alignItems(VerticalAlign.Center)

        // Progress Bar
        Column() {
          Progress({
            value: (this.knobX + this.knobY) % 400,
            total: 400,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(8)
            .color('#FF8FAB')
            .backgroundColor('#FDE2E4')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF9')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawCanvas() {
    const ctx = this.context
    if (!ctx) return
    ctx.clearRect(0, 0, 280, 280)

    // Draw background circle
    ctx.beginPath()
    ctx.arc(140, 140, 180, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(180, 227, 208, 0.4)'
    ctx.fill()

    // Draw knob
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 30, 0, Math.PI * 2)
    ctx.fillStyle = '#FF8FAB'
    ctx.fill()
  }
}