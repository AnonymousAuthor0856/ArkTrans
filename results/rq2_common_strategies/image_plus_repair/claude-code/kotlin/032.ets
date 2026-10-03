@Entry
@Component
struct TransferWizard {
  @State markerX: number = 200
  @State markerY: number = 400
  @State progress: number = 0.4

  private readonly primaryColor: string = '#FFA500'
  private readonly secondaryColor: string = '#FFC300'
  private readonly surfaceVariantColor: string = '#FFEED6'
  private readonly bgColor: string = '#FFFBF2'
  private readonly onSurfaceColor: string = '#1E1E1E'
  private readonly onPrimaryColor: string = '#FFFFFF'

  build() {
    Stack() {
      Column() {
        Text('Transfer Wizard')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurfaceColor)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Stack() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCircles()
          })

        Column() {
          Text('Transfer Progress')
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .margin({ bottom: 16 })

          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .width('80%')
            .height(16)
            .color(this.primaryColor)
            .backgroundColor(this.surfaceVariantColor)
            .borderRadius(8)

          Row() {
            Button('+')
              .width(120)
              .height(80)
              .fontSize(32)
              .fontColor(this.onPrimaryColor)
              .backgroundColor(this.primaryColor)
              .borderRadius(40)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1)
              })

            Button('-')
              .width(120)
              .height(80)
              .fontSize(32)
              .fontColor(this.onSurfaceColor)
              .backgroundColor(this.secondaryColor)
              .borderRadius(40)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0)
              })
          }
          .margin({ top: 32 })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.End)
        .padding({ bottom: 64 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.primaryColor + '33', 0.0],
        [this.bgColor, 0.5],
        [this.secondaryColor + '33', 1.0]
      ]
    })
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawCircles() {
    let ctx = this.canvasCtx
    let centerX = 360
    let centerY = 520

    ctx.beginPath()
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2)
    ctx.fillStyle = this.surfaceVariantColor
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2)
    ctx.fillStyle = this.primaryColor
    ctx.fill()
  }
}
