import { canvasRenderingContext2D } from '@kit.ArkGraphics'

@Entry
@Component
struct InstallmentPlan {
  @State paymentProgress: number = 0.3

  private readonly primaryColor: string = '#FFA500'
  private readonly secondaryColor: string = '#FFC107'
  private readonly tertiaryColor: string = '#FFE066'
  private readonly backgroundColor: string = '#FFFBF2'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly surfaceVariantColor: string = '#FFEED6'
  private readonly textColor: string = '#1E1E1E'

  build() {
    Column() {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 16 })

      // Main Content Area
      Column({ space: 16 }) {
        
        // Chart Card
        Row() {
          Canvas({ drawTask: this.renderChart }).width('100%').height('100%')
        }
        .width('100%')
        .height(240)
        .backgroundColor(Color(this.surfaceColor))
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
        .margin({ left: 16, right: 16 })

        // Progress Section
        Column({ space: 12 }) {
          Text('Payment Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primaryColor)
            .textAlign(TextAlign.Center)

          // Linear Progress Indicator
          Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(this.primaryColor)
            .trackColor(Color(this.surfaceVariantColor))

          // Slider
          Slider({ value: this.paymentProgress, min: 0, max: 1 })
            .width('100%')
            .selectedColor(this.primaryColor)
            .trackColor(Color(this.surfaceVariantColor))
            .blockColor(this.secondaryColor)

          // Reset Button
          Button('Reset Progress')
            .type(ButtonType.Normal)
            .backgroundColor(this.tertiaryColor)
            .fontColor(this.textColor)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(48)
            .borderRadius(12)
            .onClick(() => {
              this.paymentProgress = 0
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.secondaryColor, 0.25],
        [this.backgroundColor, 0.5],
        [this.primaryColor, 0.25]
      ]
    })
  }

  renderChart(context: canvasRenderingContext2D.CanvasRenderingContext2D, canvasInfo: canvasRenderingContext2D.CanvasSize) {
    const w = canvasInfo.width
    const h = canvasInfo.height
    
    context.lineWidth = 5
    context.strokeStyle = this.primaryColor
    context.lineCap = 'round'
    context.lineJoin = 'round'

    const step = w / 20
    let prevY = h / 2
    
    context.beginPath()
    context.moveTo(0, prevY)

    for (let i = 1; i <= 20; i++) {
      const x = i * step
      // Replicating the sine wave logic from Kotlin: sin(i * PI / 5 + progress * PI)
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      context.lineTo(x, y)
      prevY = y
    }
    context.stroke()
  }
}