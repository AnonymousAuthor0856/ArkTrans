interface ParcelPoint {
  x: number
  y: number
}

class AppColors {
  static readonly primary: string = '#111827'
  static readonly secondary: string = '#374151'
  static readonly tertiary: string = '#6B7280'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly headlineSize: number = 18
  static readonly titleSize: number = 14
  static readonly bodySize: number = 12
}

class AppShapes {
  static readonly smallCornerRadius: number = 6
  static readonly mediumCornerRadius: number = 10
  static readonly largeCornerRadius: number = 16
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 22
}

@Component
struct ParcelCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private canvasWidth: number = 0
  private canvasHeight: number = 0
  private dragX: number = 20
  private dragY: number = 20
  private parcelPoints: ParcelPoint[] = []
  private isCanvasReady: boolean = false
  private isInitialized: boolean = false

  private randomIn(min: number, max: number): number {
    if (max <= min) {
      return min
    }
    return Math.random() * (max - min) + min
  }

  private generateRandomPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = []
    for (let i = 0; i < 25; i++) {
      points.push({
        x: this.randomIn(4, Math.max(4, width - 4)),
        y: this.randomIn(4, Math.max(4, height - 4))
      })
    }
    return points
  }

  private initializeCanvas(): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0 || this.isInitialized) {
      return
    }

    const effectiveWidth = Math.max(40, this.canvasWidth - AppSpacing.md * 2)
    const effectiveHeight = Math.max(40, this.canvasHeight - AppSpacing.md * 2)

    this.parcelPoints = this.generateRandomPoints(effectiveWidth, effectiveHeight)
    this.dragX = this.randomIn(20, Math.max(20, effectiveWidth - 20))
    this.dragY = this.randomIn(20, Math.max(20, effectiveHeight - 20))
    this.isInitialized = true
  }

  private drawCanvas(): void {
    if (!this.isCanvasReady || this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    const inset = AppSpacing.md

    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.context.fillStyle = AppColors.secondary
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const point = this.parcelPoints[i]
      this.context.beginPath()
      this.context.arc(inset + point.x, inset + point.y, 4, 0, Math.PI * 2)
      this.context.fill()
    }

    this.context.strokeStyle = AppColors.primary
    this.context.lineWidth = 3
    this.context.beginPath()
    this.context.arc(inset + this.dragX, inset + this.dragY, 20, 0, Math.PI * 2)
    this.context.stroke()
  }

  private updateDragPosition(x: number, y: number): void {
    const effectiveWidth = Math.max(40, this.canvasWidth - AppSpacing.md * 2)
    const effectiveHeight = Math.max(40, this.canvasHeight - AppSpacing.md * 2)

    const localX = x - AppSpacing.md
    const localY = y - AppSpacing.md

    this.dragX = Math.max(20, Math.min(localX, effectiveWidth - 20))
    this.dragY = Math.max(20, Math.min(localY, effectiveHeight - 20))
    this.drawCanvas()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.isCanvasReady = true
          this.initializeCanvas()
          this.drawCanvas()
        })

      Text('Drag to locate parcel')
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.largeCornerRadius)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .clip(true)
    .onAreaChange((oldArea, newArea) => {
      const newWidth = Number(newArea.width)
      const newHeight = Number(newArea.height)

      if (Math.abs(newWidth - this.canvasWidth) > 0.5 || Math.abs(newHeight - this.canvasHeight) > 0.5) {
        this.canvasWidth = newWidth
        this.canvasHeight = newHeight
        this.isInitialized = false
      }

      this.initializeCanvas()
      this.drawCanvas()
    })
    .onTouch((event: TouchEvent) => {
      if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
        this.updateDragPosition(event.touches[0].x, event.touches[0].y)
      }
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')

      ParcelCanvas()
        .width('100%')
        .margin({ top: AppSpacing.xl })

      Blank()
        .layoutWeight(1)

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: AppSpacing.xl })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
  }
}