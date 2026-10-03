@Entry
@Component
struct PomodoroTimer {
  @State knobPositionX: number = 140
  @State knobPositionY: number = 140
  @State isRunning: boolean = false
  private canvasSize: number = 280

  private colors = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FCC2D7',
    success: '#4ADE80',
    warning: '#FACC15',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  aboutToAppear() {
    this.knobPositionX = this.canvasSize / 2
    this.knobPositionY = this.canvasSize / 2
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 16, bottom: 24 })

      Stack() {
        Circle()
          .width(this.canvasSize)
          .height(this.canvasSize)
          .fill(this.colors.surfaceVariant)
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.18)',
            offsetY: 4
          })

        Canvas(this.onCanvasDraw)
          .width(this.canvasSize)
          .height(this.canvasSize)
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                const x = event.offsetX + this.canvasSize / 2
                const y = event.offsetY + this.canvasSize / 2
                const clampedX = Math.max(0, Math.min(this.canvasSize, x))
                const clampedY = Math.max(0, Math.min(this.canvasSize, y))
                this.knobPositionX = clampedX
                this.knobPositionY = clampedY
              })
          )
      }
      .width(this.canvasSize)
      .height(this.canvasSize)
      .margin({ bottom: 24 })

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? this.colors.success : this.colors.error)
        .margin({ bottom: 24 })

      Row() {
        Button('Start')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.primary)
          .fontColor(this.colors.onPrimary)
          .margin({ right: 16 })
          .onClick(() => {
            this.isRunning = true
          })

        Button('Stop')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.tertiary)
          .fontColor(this.colors.onSecondary)
          .onClick(() => {
            this.isRunning = false
          })
      }
      .margin({ bottom: 24 })

      Progress({
        value: ((this.knobPositionX + this.knobPositionY) % 400) / 400 * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  private onCanvasDraw = (ctx: CanvasRenderingContext2D) => {
    const centerX = this.canvasSize / 2
    const centerY = this.canvasSize / 2

    ctx.beginPath()
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(180, 227, 208, 0.4)'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.knobPositionX, this.knobPositionY, 30, 0, Math.PI * 2)
    ctx.fillStyle = this.colors.primary
    ctx.fill()
  }
}
