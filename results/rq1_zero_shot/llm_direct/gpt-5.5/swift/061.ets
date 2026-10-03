interface CanvasPoint {
  x: number
  y: number
}

class AppColors {
  static primary: string = '#111827'
  static secondary: string = '#374151'
  static tertiary: string = '#6B7280'
  static background: string = '#F9FAFB'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E5E7EB'
  static outline: string = '#D1D5DB'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onBackground: string = '#111827'
  static onSurface: string = '#1F2937'
}

class AppTypographyTokens {
  static displaySize: number = 26
  static headlineSize: number = 18
  static titleSize: number = 14
  static bodySize: number = 12
}

class AppShapes {
  static smallCornerRadius: number = 6
  static mediumCornerRadius: number = 10
  static largeCornerRadius: number = 16
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 14
  static xl: number = 22
}

@Component
struct ParcelCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  @State private dragOffset: CanvasPoint = { x: 20, y: 20 }
  @State private parcelPoints: CanvasPoint[] = []
  @State private canvasWidth: number = 0
  @State private canvasHeight: number = 0

  private areaToNumber(value: number | string): number {
    if (typeof value === 'number') {
      return value
    }
    return Number.parseFloat(value)
  }

  private randomInRange(min: number, max: number): number {
    if (max <= min) {
      return min
    }
    return min + Math.random() * (max - min)
  }

  private generateRandomPoints(width: number, height: number): CanvasPoint[] {
    const points: CanvasPoint[] = []
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height
      })
    }
    return points
  }

  private initializeCanvas(outerWidth: number, outerHeight: number): void {
    const width = Math.max(40, outerWidth - AppSpacing.md * 2)
    const height = Math.max(40, outerHeight - AppSpacing.md * 2)

    const sizeChanged =
      Math.abs(width - this.canvasWidth) > 0.5 ||
      Math.abs(height - this.canvasHeight) > 0.5

    if (!sizeChanged && this.parcelPoints.length > 0) {
      return
    }

    this.canvasWidth = width
    this.canvasHeight = height
    this.parcelPoints = this.generateRandomPoints(width, height)
    this.dragOffset = {
      x: this.randomInRange(20, Math.max(20, width - 20)),
      y: this.randomInRange(20, Math.max(20, height - 20))
    }

    setTimeout(() => {
      this.drawCanvas()
    }, 0)
  }

  private updateDragPosition(x: number, y: number): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    const maxX = Math.max(20, this.canvasWidth - 20)
    const maxY = Math.max(20, this.canvasHeight - 20)

    this.dragOffset = {
      x: Math.max(20, Math.min(x, maxX)),
      y: Math.max(20, Math.min(y, maxY))
    }

    this.drawCanvas()
  }

  private drawCanvas(): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.context.fillStyle = AppColors.secondary
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const point = this.parcelPoints[i]
      this.context.beginPath()
      this.context.arc(point.x, point.y, 4, 0, Math.PI * 2)
      this.context.fill()
    }

    this.context.strokeStyle = AppColors.primary
    this.context.lineWidth = 3
    this.context.beginPath()
    this.context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, Math.PI * 2)
    this.context.stroke()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(this.canvasWidth)
        .height(this.canvasHeight)
        .position({
          x: AppSpacing.md,
          y: AppSpacing.md
        })
        .onReady(() => {
          this.drawCanvas()
        })

      Text('Drag to locate parcel')
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.largeCornerRadius)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.initializeCanvas(
        this.areaToNumber(newValue.width as number | string),
        this.areaToNumber(newValue.height as number | string)
      )
    })
    .onTouch((event: TouchEvent) => {
      if (
        (event.type === TouchType.Down || event.type === TouchType.Move) &&
          event.touches.length > 0
      ) {
        const touch = event.touches[0]
        this.updateDragPosition(
          touch.x - AppSpacing.md,
          touch.y - AppSpacing.md
        )
      }
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack() {
      Column({ space: AppSpacing.xl }) {
        Text('Parcel Tracker')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        ParcelCanvas()
          .width('100%')

        Text('Visualize parcel movements and positions.')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
  }
}