@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F8FAFC')

      // Main Content Area
      Column({ space: 14 }) {
        // Chart Surface
        Stack() {
          // Background Card with Shadow
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 8, color: '#1E0F172A', offsetY: 4 })

          // Canvas for K-Line
          Canvas({ drawRender: this.drawCanvas.bind(this) })
            .width('100%')
            .height('100%')
            .padding(14)
        }
        .width('100%')
        .height(260)
        .borderRadius(16)

        // Title
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .textAlign(TextAlign.Center)

        // Slider
        Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .trackThickness(4)
          .selectedColor('#2563EB')
          .trackColor('#E2E8F0')
          .blockColor('#FFFFFF')
          .onChange((value: number) => {
            this.progress = value
          })

        // Linear Progress Indicator
        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E2E8F0')
          .borderRadius(4)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#60A5FA', 0.15], ['#F8FAFC', 0.5], ['#2563EB', 0.15]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  drawCanvas(ctx: CanvasRenderingContext2D, size: Size): void {
    const width = size.width
    const height = size.height
    const step = width / 50.0

    ctx.lineWidth = 4
    ctx.strokeStyle = '#2563EB'
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    ctx.beginPath()

    let prevY = height / 2.0
    ctx.moveTo(0, prevY)

    for (let i = 0; i <= 50; i++) {
      const x = i * step
      // Formula: sin(i * PI / 8 + progress * PI) * (height / 3)
      const y = (height / 2.0) + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0)
      ctx.lineTo(x, y)
      prevY = y
    }
    ctx.stroke()
  }
}