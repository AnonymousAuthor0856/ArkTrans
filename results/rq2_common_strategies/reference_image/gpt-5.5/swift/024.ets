interface DrawPoint {
  x: number
  y: number
}

class AppColors {
  static readonly primary: string = '#EF476F'
  static readonly secondary: string = '#FFD166'
  static readonly tertiary: string = '#06D6A0'
  static readonly background: string = '#FFFCF2'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F7EDE2'
  static readonly outline: string = '#E5D4B1'
  static readonly success: string = '#06D6A0'
  static readonly warning: string = '#FFA600'
  static readonly error: string = '#D62828'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly smallCornerRadius: number = 6
  static readonly mediumCornerRadius: number = 10
  static readonly largeCornerRadius: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

@Entry
@Component
struct Index {
  @State private points: DrawPoint[] = []
  @State private currentColor: string = AppColors.primary

  private readonly buttonHeight: number = 44
  private readonly buttonWidth: number = 83
  private readonly fabSize: number = 56
  private readonly circleRadius: number = 10
  private readonly topBarActualHeight: number = 54
  private readonly bottomBarActualHeight: number = 68
  private readonly fabBottomMargin: number = 24

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private isCanvasReady: boolean = false

  private clearCanvas(): void {
    if (!this.isCanvasReady) {
      return
    }
    this.canvasContext.clearRect(0, 0, 10000, 10000)
  }

  private redraw(): void {
    if (!this.isCanvasReady) {
      return
    }

    this.canvasContext.clearRect(0, 0, 10000, 10000)
    this.canvasContext.fillStyle = this.currentColor

    for (let i: number = 0; i < this.points.length; i++) {
      const point: DrawPoint = this.points[i]
      this.canvasContext.beginPath()
      this.canvasContext.arc(
        point.x,
        point.y,
        this.circleRadius,
        0,
        Math.PI * 2
      )
      this.canvasContext.fill()
    }
  }

  private addPoint(x: number, y: number): void {
    const point: DrawPoint = {
      x: x,
      y: y
    }
    this.points = this.points.concat([point])
    this.redraw()
  }

  private selectColor(color: string): void {
    this.currentColor = color
    this.redraw()
  }

  private clearPoints(): void {
    this.points = []
    this.clearCanvas()
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Retro Whiteboard')
          .width('100%')
          .height(this.topBarActualHeight)
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)

        Canvas(this.canvasContext)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(AppColors.background)
          .onReady(() => {
            this.isCanvasReady = true
            this.redraw()
          })
          .onTouch((event: TouchEvent) => {
            if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
              this.addPoint(event.touches[0].x, event.touches[0].y)
            }
          })

        Row() {
          Button('Red', { type: ButtonType.Normal, stateEffect: true })
            .width(this.buttonWidth)
            .height(this.buttonHeight)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.smallCornerRadius)
            .shadow({
              radius: 6,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })
            .onClick(() => {
              this.selectColor(AppColors.primary)
            })

          Button('Yellow', { type: ButtonType.Normal, stateEffect: true })
            .width(this.buttonWidth)
            .height(this.buttonHeight)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.smallCornerRadius)
            .shadow({
              radius: 6,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })
            .onClick(() => {
              this.selectColor(AppColors.secondary)
            })

          Button('Green', { type: ButtonType.Normal, stateEffect: true })
            .width(this.buttonWidth)
            .height(this.buttonHeight)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.smallCornerRadius)
            .shadow({
              radius: 6,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })
            .onClick(() => {
              this.selectColor(AppColors.tertiary)
            })
        }
        .width('100%')
        .height(this.bottomBarActualHeight)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .justifyContent(FlexAlign.SpaceEvenly)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 2,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button('Clear', { type: ButtonType.Normal, stateEffect: true })
        .width(this.fabSize)
        .height(this.fabSize)
        .borderRadius(this.fabSize / 2)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .margin({
          right: AppSpacing.xl,
          bottom: this.fabBottomMargin
        })
        .shadow({
          radius: 6,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: 2
        })
        .onClick(() => {
          this.clearPoints()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}