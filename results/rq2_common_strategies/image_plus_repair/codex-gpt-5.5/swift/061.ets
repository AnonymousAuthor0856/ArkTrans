interface ParcelPoint {
  x: number
  y: number
}

class AppColors {
  static readonly primary: string = '#111827'
  static readonly secondary: string = '#374151'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly onSurface: string = '#1F2937'
}

@Entry
@Component
struct ParcelTrackerApp {
  private readonly canvasWidth: number = 694
  private readonly canvasHeight: number = 300
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  @State private dragX: number = 347
  @State private dragY: number = 150
  @State private parcelPoints: ParcelPoint[] = []

  aboutToAppear(): void {
    this.parcelPoints = this.createParcelPoints(this.canvasWidth, this.canvasHeight)
  }

  private createParcelPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = []
    for (let index = 0; index < 25; index++) {
      points.push({
        x: 10 + Math.random() * Math.max(1, width - 20),
        y: 10 + Math.random() * Math.max(1, height - 20)
      })
    }
    return points
  }

  private clamp(value: number, minimum: number, maximum: number): number {
    return Math.max(minimum, Math.min(value, maximum))
  }

  private redraw(): void {
    const context = this.canvasContext
    context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    context.fillStyle = AppColors.secondary
    for (const point of this.parcelPoints) {
      context.beginPath()
      context.arc(point.x, point.y, 4, 0, Math.PI * 2)
      context.fill()
    }

    context.strokeStyle = AppColors.primary
    context.lineWidth = 3
    context.beginPath()
    context.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2)
    context.stroke()
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .margin({ bottom: 22 })

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.redraw()
          })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              const touch = event.touches[0]
              this.dragX = this.clamp(touch.x, 20, this.canvasWidth - 20)
              this.dragY = this.clamp(touch.y, 20, this.canvasHeight - 20)
              this.redraw()
            }
          })

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(300)
      .backgroundColor(AppColors.surface)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: 16
      })
      .borderRadius(16)
      .clip(true)

      Blank()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
    .justifyContent(FlexAlign.Start)
  }
}
