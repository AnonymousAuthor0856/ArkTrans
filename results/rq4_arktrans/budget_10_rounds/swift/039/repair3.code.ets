@Entry
@Component
struct Index {
  @State paymentProgress: number = 40

  build() {
    Stack() {
      Column() {
        // Header
        Text('Installment Plan')
          .backgroundColor('#FFFBF2')
          .height(64)
          .width('100%')
          .fontColor('#1E1E1E')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .padding({ top: 50 }) // Simulating status bar space

        // Content Area
        Column() {
          // Graph Card
          Stack() {
            // Background Card
            Rect()
              .fill('#FFFFFF')
              .opacity(0.9)
              .borderRadius(32)
              .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
              .height(240)
              .width('100%')

            // Canvas for the graph line
            Canvas(this.ctx).height(240).width('100%').margin(20)
          }
          .width('100%')

          // Progress Label
          Text('Payment Progress')
            .fontColor('#FFA500')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 24 })

          // Progress Bar (Visual only)
          Row() {
            Progress({ value: this.paymentProgress, total: 100 })
              .width(`${this.paymentProgress}%`)
              .height(12)
              .color('#FFA500')
              .borderRadius(6)
          }
          .width('100%')
          .height(12)
          .backgroundColor('#FFF0D4')
          .borderRadius(6)
          .margin({ top: 16 })

          // Slider Control
          Slider({ value: this.paymentProgress, min: 0, max: 100 })
            .width('100%')
            .blockColor('#FFA500')
            .trackColor('#FFF0D4')
            .selectedColor('#FFA500')
            .showValue(false)
            .margin({ top: 24 })

          // Reset Button
          Button('Reset Progress')
            .type(ButtonType.Capsule)
            .backgroundColor('#FFE066')
            .fontColor('#1E1E1E')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(48)
            .width('100%')
            .margin({ top: 32 })
            .onClick(() => {
              this.paymentProgress = 0
            })

        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          angle: 180,
          colors: [['#FFF7D6', 0], ['#FFE4B5', 1]]
        })
        .padding(24)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  private ctx: CanvasRenderingContext2D | null = null

  aboutToAppear() {
    this.drawGraph()
  }

  drawGraph() {
    if (!this.ctx) return
    
    interface Point {
      x: number;
      y: number;
    }

    const points: Point[] = [
      { x: 0.1, y: 0.7 },
      { x: 0.2, y: 0.8 },
      { x: 0.3, y: 0.6 },
      { x: 0.4, y: 0.2 },
      { x: 0.5, y: 0.3 },
      { x: 0.6, y: 0.7 },
      { x: 0.7, y: 0.8 },
      { x: 0.8, y: 0.6 },
      { x: 0.9, y: 0.2 },
      { x: 1.0, y: 0.3 },
      { x: 1.1, y: 0.7 },
      { x: 1.2, y: 0.8 }
    ]

    this.ctx.beginPath()
    this.ctx.moveTo(points[0].x * 100, points[0].y * 200)
    
    for (let i = 1; i < points.length; i++) {
      this.ctx.lineTo(points[i].x * 100, points[i].y * 200)
    }

    this.ctx.lineWidth = 8
    this.ctx.lineCap = 'round'
    this.ctx.lineJoin = 'round'
    this.ctx.strokeStyle = '#FFA500'
    this.ctx.stroke()
  }
}