class AppTokens {
  static readonly Colors = {
    primary: '#FFFFA500',
    secondary: '#FFFFC300',
    tertiary: '#FFFFE066',
    background: '#FFFFFBF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFEED6',
    outline: '#FFF1C27D',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

@Entry
@Component
struct TransferWizard {
  @State markerX: number = 200
  @State markerY: number = 400
  @State progress: number = 0.4

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 360
    const h: number = 500
    const centerX = w / 2
    const centerY = h / 2

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2)
    ctx.fillStyle = '#FFFFEED6'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2)
    ctx.fillStyle = '#FFFFA500'
    ctx.fill()
  }

  build() {
    Column() {
      Stack() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .padding(24)
          .onReady(() => {
            this.drawCanvas()
          })

        Column() {
          Blank()

          Column() {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)

            Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
              .width('80%')
              .height(8)
              .color(AppTokens.Colors.primary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .margin({ top: 16 })

            Row() {
              Button('+') {
              }
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(64)
              .height(64)
              .borderRadius(32)
              .backgroundColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0)
              })

              Button('-') {
              }
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(64)
              .height(64)
              .borderRadius(32)
              .backgroundColor(AppTokens.Colors.secondary)
              .margin({ left: 12 })
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0)
              })
            }
            .margin({ top: 16 })
          }
          .width('100%')
          .padding({ bottom: 32 })
        }
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}