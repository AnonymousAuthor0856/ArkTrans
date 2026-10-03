class AppTokens {
  static readonly Colors = {
    primary: '#FFFF7A00',
    secondary: '#FFFFC300',
    tertiary: '#FFFFF3C0',
    background: '#FFFFF8E7',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFEBC8',
    outline: '#FFBCA789',
    success: '#FF28A745',
    warning: '#FFFFC107',
    error: '#FFDC3545',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
    secondary20: '#33FFC300'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

@Entry
@Component
struct RetroRemoteControl {
  @State knobX: number = 90
  @State knobY: number = 140
  @State powerOn: boolean = false

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 280
    const h: number = 280
    const centerX = w / 2
    const centerY = h / 2

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2)
    ctx.fillStyle = '#33FFC300'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fillStyle = '#FFFF7A00'
    ctx.fill()
  }

  build() {
    Column() {
      Row().height(40)

      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Scroll() {
        Column() {
          Stack() {
            Canvas(this.canvasContext)
              .width(280)
              .height(280)
              .onReady(() => {
                this.drawCanvas()
              })
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
          .gesture(
            PanGesture({ distance: 0 })
              .onActionUpdate((event: GestureEvent) => {
                const x = event.fingerList[0].localX
                const y = event.fingerList[0].localY
                this.knobX = Math.max(16, Math.min(264, x))
                this.knobY = Math.max(16, Math.min(264, y))
                this.drawCanvas()
              })
          )

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
            .margin({ top: 24 })

          Row() {
            Button('On') {
            }
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppTokens.Colors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Button() {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSecondary)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppTokens.Colors.secondary)
            .margin({ left: 60 })
            .onClick(() => {
              this.knobX = 90
              this.knobY = 140
              this.drawCanvas()
            })
          }
          .margin({ top: 24 })

          Row()
            .width('100%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ top: 24, left: 16, right: 16 })
        }
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}