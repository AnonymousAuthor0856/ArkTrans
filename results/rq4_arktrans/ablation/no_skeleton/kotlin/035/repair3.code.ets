import { canvas, Path2D, Paint, StrokeCap, StrokeJoin } from '@kit.graphics.canvas'

@Entry
@Component
struct StockKLine {
  @State progress: number = 0.5
  private context: canvas.CanvasRenderingContext2D | null = null

  build() {
    Column() {
      // Top Bar
      Text('Stock K-Line')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(60)

      // Main Content Area
      Column({ space: 14 }) {
        // Chart Card
        Row() {
          Canvas(this.context)
            .onReady((context: canvas.CanvasRenderingContext2D) => {
              this.context = context
              this.drawChart(context)
            })
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(260)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })

        // Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .textAlign(TextAlign.Center)

        // Slider
        Slider({ value: this.progress, min: 0, max: 1, style: SliderStyle.OutSet })
          .width('100%')
          .trackColor('#E2E8F0')
          .selectedColor('#60A5FA')
          .blockColor('#2563EB')
          .onChange((value: number) => {
            this.progress = value
            if (this.context) {
              this.drawChart(this.context)
            }
          })

        // Progress Indicator
        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
          .borderRadius(4)

      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 14, right: 14 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#2563EB', 0.15], ['#F8FAFC', 0.5], ['#60A5FA', 0.15]]
    })
  }

  private drawChart(context: canvas.CanvasRenderingContext2D): void {
    const width = context.canvas.width
    const height = context.canvas.height
    const step = width / 50
    
    // Create Path for the line
    const path = new Path2D()
    
    let prevY: number = height / 2
    for (let i = 0; i <= 50; i++) {
      const x: number = i * step
      // Formula from Kotlin: sin(i * PI / 8 + progress * PI)
      const y: number = (height / 2) + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)
      
      if (i === 0) {
        path.moveTo(x, y)
      } else {
        path.lineTo(x, y)
      }
      prevY = y
    }

    // Draw Line
    const paint = new Paint()
    paint.color = '#2563EB'
    paint.strokeWidth = 4
    paint.lineCap = StrokeCap.Round
    paint.lineJoin = StrokeJoin.Round
    
    context.strokePath(path, paint)
  }
}