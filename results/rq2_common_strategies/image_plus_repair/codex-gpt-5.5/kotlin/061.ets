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
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
}

@Component
struct ParcelCanvas {
  @State private dragX: number = 20
  @State private dragY: number = 20

  private readonly canvasWidth: number = 624
  private readonly canvasHeight: number = 558
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)
  private readonly parcelPoints: ParcelPoint[] = [
    { x: 100, y: 27 },
    { x: 268, y: 25 },
    { x: 418, y: 27 },
    { x: 99, y: 61 },
    { x: 414, y: 75 },
    { x: 360, y: 77 },
    { x: 363, y: 82 },
    { x: 88, y: 139 },
    { x: 30, y: 182 },
    { x: 106, y: 184 },
    { x: 119, y: 192 },
    { x: 147, y: 191 },
    { x: 202, y: 198 },
    { x: 143, y: 216 },
    { x: 362, y: 198 },
    { x: 367, y: 247 },
    { x: 221, y: 265 },
    { x: 358, y: 272 },
    { x: 381, y: 281 },
    { x: 399, y: 280 },
    { x: 70, y: 304 },
    { x: 121, y: 315 },
    { x: 133, y: 326 },
    { x: 46, y: 331 },
    { x: 290, y: 334 }
  ]

  private drawParcelField(): void {
    const ctx = this.canvasContext
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    for (let index = 0; index < this.parcelPoints.length; index++) {
      const point = this.parcelPoints[index]
      ctx.beginPath()
      ctx.fillStyle = AppColors.secondary
      ctx.arc(point.x, point.y, 7, 0, Math.PI * 2)
      ctx.fill()
    }

    ctx.beginPath()
    ctx.strokeStyle = AppColors.primary
    ctx.lineWidth = 4
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2)
    ctx.stroke()
  }

  private updateLocator(deltaX: number, deltaY: number): void {
    const nextX = Math.max(0, Math.min(this.canvasWidth, this.dragX + deltaX))
    const nextY = Math.max(0, Math.min(this.canvasHeight, this.dragY + deltaY))
    this.dragX = nextX
    this.dragY = nextY
    this.drawParcelField()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasContext)
        .width(this.canvasWidth)
        .height(this.canvasHeight)
        .position({ x: 20, y: 20 })
        .onReady(() => {
          this.drawParcelField()
        })
        .onAreaChange(() => {
          this.drawParcelField()
        })

      Text('Drag to locate parcel')
        .fontSize(24)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(598)
    .backgroundColor(AppColors.surface)
    .borderRadius(32)
    .border({
      width: 2,
      color: AppColors.outline,
      radius: 32
    })
    .clip(true)
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.updateLocator(event.offsetX, event.offsetY)
        })
    )
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .height(76)
        .lineHeight(76)
        .textAlign(TextAlign.Center)
        .margin({ top: 27, bottom: 31 })

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(24)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(36)
        .lineHeight(36)
        .textAlign(TextAlign.Center)
        .margin({ top: 44 })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 28, right: 28 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Center)
  }
}
